# How to Generate Word Clouds in R
# Ref: https://towardsdatascience.com/create-a-word-cloud-with-r-bde3e7422e8a

# 1: CARGAR PAQUETES Y RECUPERAR LOS DATOS 

#install.packages("wordcloud")
library(wordcloud)
#install.packages("RColorBrewer")
library(RColorBrewer)
#install.packages("wordcloud2")
library(wordcloud2)

# Para apoyar la carga de datos texto
install.packages("tm")
library(tm)

#Create a vector containing only the text
text <- data$text # Create a corpus  
docs <- Corpus(VectorSource(text))

# 2: LIMPIAR LOS DATOS TEXTO

docs <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeWords, stopwords("english"))

# 3: CREAR UNA MATRIZ DOCUMENT-TÉRMINO

dtm <- TermDocumentMatrix(docs) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)

# 4: GENERAR LA NUBE DE PALABRAS

set.seed(1234) # for reproducibility 
wordcloud(words = df$word, freq = df$freq, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))

# Visualizaciones más avanzadas
wordcloud2(data=df, size=1.6, color='random-dark')
wordcloud2(data=df, size = 0.7, shape = 'pentagon')

