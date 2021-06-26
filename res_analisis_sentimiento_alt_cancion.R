# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

library(dplyr)
library(ggplot2)
library(reshape2)
library(syuzhet)
library(tidytext)
library(tm)
library(wordcloud)

# Definir directorio de trabajo donde están los archivos CSV
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01/790r")

# Leer el archivo CSV
datos <- read.csv('ta_resenia_sitio.csv')

## Preparación del texto
lyrics_text <- as.character(datos$txt_resenia)

# PALABRAS MÁS FRECUENTES

#Removing punctuations and alphanumeric content
lyrics_text<- gsub('[[:punct:]]+', '', lyrics_text)
lyrics_text<- gsub("([[:alpha:]])\1+", "", lyrics_text)
#creating a text corpus
docs <- Corpus(VectorSource(lyrics_text))
# Converting the text to lowercase
docs <- tm_map(docs, content_transformer(tolower))
# Removing english common stopwords
docs <- tm_map(docs, removeWords, stopwords("spanish"))
# creating term document matrix 
tdm <- TermDocumentMatrix(docs)
# defining tdm as matrix
m <- as.matrix(tdm)
# getting word counts in decreasing order
word_freqs = sort(rowSums(m), decreasing=TRUE) 
# creating a data frame with words and their frequencies
lyrics_wc_df <- data.frame(word=names(word_freqs), freq=word_freqs)

lyrics_wc_df <- lyrics_wc_df[1:300,]

# plotting word cloud

set.seed(1234)
wordcloud(words = lyrics_wc_df$word, freq = lyrics_wc_df$freq, 
          min.freq = 1,scale=c(1.8,.5),
          max.words=200, random.order=FALSE, rot.per=0.15, 
          colors=brewer.pal(8, "Dark2"))

# PALABRAS POSITIVAS Y NEGATIVAS EN LAS OPINIONES

d <- data.frame(txt = sapply(docs, as.character), stringsAsFactors = FALSE)

tidy_lyrics <- d %>% 
  unnest_tokens(word,txt)

set.seed(1234)
tidy_lyrics %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("#F8766D", "#00BFC4"), max.words = 250)


# SENTIMIENTOS GENERALES EXPRESADO

# Getting the sentiment value for the lyrics
ty_sentiment <- get_nrc_sentiment((lyrics_text))

# Dataframe with cumulative value of the sentiments
sentimentscores <- data.frame(colSums(ty_sentiment[,]))

# Dataframe with sentiment and score as columns
names(sentimentscores) <- "Score"
sentimentscores <- cbind("sentiment"=rownames(sentimentscores),sentimentscores)
rownames(sentimentscores) <- NULL

# Plot for the cumulative sentiments
ggplot(data=sentimentscores,aes(x=sentiment,y=Score))+
  geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("Scores")+
  ggtitle("Total sentiment based on scores")+
  theme_minimal() 

# PALABRAS PRINCIPALES USADAS PARA DESCRIBIR DIFERENTES EMOCIONES

tidy_lyrics <- data.frame(txt = sapply(docs, as.character), track_title = datos$titulo, stringsAsFactors = FALSE)

song_wrd_count <- tidy_lyrics %>% count(track_title)

lyric_counts <- tidy_lyrics %>%
  left_join(song_wrd_count, by = "track_title") %>% 
  rename(total_words=n)

lyric_sentiment <- tidy_lyrics %>% 
  inner_join(get_sentiments("nrc"),by="word")

1lyric_sentiment %>% 
  count(word,sentiment,sort=TRUE) %>% 
  group_by(sentiment)%>%top_n(n=10) %>% 
  ungroup() %>%
  ggplot(aes(x=reorder(word,n),y=n,fill=sentiment)) +
  geom_col(show.legend = FALSE) + 
  facet_wrap(~sentiment,scales="free") +
  xlab("Sentiments") + ylab("Scores")+
  ggtitle("Top words used to express emotions and sentiments") +
  coord_flip()
