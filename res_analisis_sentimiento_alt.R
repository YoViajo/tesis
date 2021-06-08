#*#*# res_analisis_sentimiento_alt.R #*#*#

## Ref: https://www.r-bloggers.com/2021/05/sentiment-analysis-in-r-3/
## Análisis de sentimiento en R
library(tm)
library(wordcloud)

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

#Importar datos a analizar

# Definir directorio de trabajo donde están los archivos CSV
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01/790r")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s03/580r")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s04/250r")
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s05/170r")

# Leer el archivo CSV
#datos <- read.csv('opiniones_nac.csv')
datos <- read.csv('opiniones_ext.csv')
str(datos)

# Construir corpus
corpus <- iconv(as.character(datos$op_texto))
corpus <- Corpus(VectorSource(corpus))
inspect(corpus[1:5])

# Limpiar texto
corpus <- tm_map(corpus, tolower)
inspect(corpus[1:5])

# Quitar caracteres especiales
corpus <- tm_map(corpus, removePunctuation)
inspect(corpus[1:5])

# Quitar números
corpus <- tm_map(corpus, removeNumbers)
inspect(corpus[1:5])

# Quitar palabras irrelevantes (stop words)
cleanset <- tm_map(corpus, removeWords, stopwords('spanish'))
inspect(cleanset[1:5])

# Quitar enlaces URL
removeURL <- function(x) gsub('http[[:alnum:]]*', '', x)
cleanset <- tm_map(cleanset, content_transformer(removeURL))
inspect(cleanset[1:5])

# Text stemming: reduce las palabras a su forma raíz
cleanset <- tm_map(cleanset, removeWords, c('bs'))
cleanset <- tm_map(cleanset, stemDocument)
cleanset <- tm_map(cleanset, stripWhitespace)
inspect(cleanset[1:5])

# Matriz de términos de documento
tdm <- TermDocumentMatrix(cleanset)
tdm <- as.matrix(tdm)
tdm[1:10, 1:20]

# Gráfico de barras
w <- rowSums(tdm)
w <- subset(w, w>=25)
barplot(w,
        las = 2,
        col = rainbow(50))

# Nube de palabras
w <- sort(rowSums(tdm), decreasing = TRUE)
set.seed(222)
wordcloud(words = names(w),
          freq = w,
          max.words = 150,
          random.order = F,
          min.freq = 5,
          colors = brewer.pal(8, 'Dark2'),
          scale = c(3.5, 0.1),
          rot.per = 0.7)

library(wordcloud2)
w <- data.frame(names(w), w)
colnames(w) <- c('word', 'freq')
wordcloud2(w,
           size = 0.5,
           shape = 'triangle',
           rotateRatio = 0.5,
           minSize = 1)


# ANÁLISIS DE SENTIMIENTO

library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

# Obtener puntuación de sentimiento
v_txt <- as.character(datos$op_texto)
s <- get_nrc_sentiment(v_txt)
head(s)

# Gráfico de barras
barplot(colSums(s),
        las = 2,
        col = rainbow(10),
        ylab = 'Cuenta',
        main = 'Puntuación de sentimiento de opiniones')

## Ref: https://cran.r-project.org/web/packages/syuzhet/vignettes/syuzhet-vignette.html
# Métodos alternativos de análisis de sentimiento
syuzhet_vector <- get_sentiment(v_txt, method="syuzhet")
head(syuzhet_vector)

bing_vector <- get_sentiment(v_txt, method = "bing")
head(bing_vector)

nrc_vector <- get_sentiment(v_txt, method = "nrc", lang = "spanish")
head(nrc_vector)

afinn_vector <- get_sentiment(v_txt, method = "afinn")
head(afinn_vector)

# Comparación de métodos
rbind(
  sign(head(syuzhet_vector)),
  sign(head(bing_vector)),
  sign(head(afinn_vector)),
  sign(head(nrc_vector))
)

# Medida de la valencia general en el texto
sum(nrc_vector)

# Tendencia central, valencia emocional promedio
mean(nrc_vector)

# Sensación amplia de la distribución de sentimiento
summary(nrc_vector)
