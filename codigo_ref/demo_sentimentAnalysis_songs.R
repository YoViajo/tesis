# Ref: https://www.kdnuggets.com/2018/09/sentiment-analysis-adele-songs.html
# Realizar técnicas de minería de texto, específicamente NLP, en letras de canciones
# para descubrir emociones y sentimientos subyacentes.

library(geniusr)
library(magrittr)
library(purrr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(tm)
library(wordcloud)
library(syuzhet)
library(circlize)
library(tidytext)
library(reshape2)


lyrics_text <- lyrics$lyric
#Removing punctuations and alphanumeric content
lyrics_text<- gsub('[[:punct:]]+', '', lyrics_text)
lyrics_text<- gsub("([[:alpha:]])\1+", "", lyrics_text)
#creating a text corpus
docs <- Corpus(VectorSource(lyrics_text))
# Converting the text to lowercase
docs <- tm_map(docs, content_transformer(tolower))
# Removing english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# creating term document matrix 
tdm <- TermDocumentMatrix(docs)
# defining tdm as matrix
m <- as.matrix(tdm)
# getting word counts in decreasing order
word_freqs = sort(rowSums(m), decreasing=TRUE) 
# creating a data frame with words and their frequencies
lyrics_wc_df <- data.frame(word=names(word_freqs), freq=word_freqs)


