## Ref: https://www.linkedin.com/pulse/an%C3%A1lisis-de-sentimiento-en-r-carlos-j%C3%A1uregui-fern%C3%A1ndez
## ANÁLISIS DE SENTIMIENTO

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

#Instalación de paquetes que se utilizarán
#install.packages("SnowballC")
#install.packages("tm")
#install.packages("twitteR")
#install.packages("syuzhet")

#Carga de paquetes
library(SnowballC)
library(tm)
#library(twitteR)
library(syuzhet)

#Importar datos a analizar

# Definir directorio de trabajo donde están los archivos CSV
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s04")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s05")
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s03")

# Leer el archivo CSV
#datos <- read.csv('s01_export.csv')
#datos <- read.csv('s04_export.csv')
#datos <- read.csv('s05_export.csv')
datos <- read.csv('s03_export_580r.csv')


datos_1 <- unlist(as.character(datos[ , "txt_resenia"]))
#typeof(datos_1)

#Verificando cantidad de tweets importados
n.tweet <- length(datos_1)
#n.tweet

#Convirtiendo los tweets en un data frame
tweets.df <- as.data.frame(datos_1) 
#head(tweets.df)

#Quitando los links en los tweets
#tweets.df2 <- gsub("http.*","",tweets.df$text)
#tweets.df2 <- gsub("https.*","",tweets.df2)

#Quitando los hashtags y usuarios en los tweets
#tweets.df2 <- gsub("#\\w+","",tweets.df2)
#tweets.df2 <- gsub("@\\w+","",tweets.df2)

#Quitando los signos de puntuación, números y textos con números
#tweets.df2 <- gsub("[[:punct:]]","",tweets.df2)
#tweets.df2 <- gsub("\\w*[0-9]+\\w*\\s*", "",tweets.df2)

# ANÁLISIS DE SENTIMIENTO

#Transformamos la base de textos importados en un vector para
#poder utilizar la función get_nrc_sentiment
#palabra.df <- as.vector(tweets.df)
palabra.df <- as.character(unlist(tweets.df))

#Aplicamos la función indicando el vector y el idioma y creamos
#un nuevo data frame llamado emocion.df
emocion.df <- get_nrc_sentiment(char_v = palabra.df, language = "spanish")

#Unimos emocion.df con el vector tweets.df para ver como
#trabajó la función get_nrc_sentiment cada uno de los tweets
emocion.df2 <- cbind(tweets.df, emocion.df)
head(emocion.df2)

#Creamos un data frame en el cual las filas serán las emociones
#y las columnas los puntajes totales

#Empezamos transponiendo emocion.df
emocion.df3 <- data.frame(t(emocion.df))

#Sumamos los puntajes de cada uno de los tweets para cada emocion
emocion.df3 <- data.frame(rowSums(emocion.df3))

#Nombramos la columna de puntajes como cuenta
names(emocion.df3)[1] <- "cuenta"

#Dado que las emociones son los nombres de las filas y no una variable
#transformamos el data frame para incluirlas dentro
emocion.df3 <- cbind("sentimiento" = rownames(emocion.df3), emocion.df3)

#Quitamos el nombre de las filas
rownames(emocion.df3) <- NULL

#Verificamos el data frame
print(emocion.df3)

## VISUALIZACIÓN GRÁFICA DE RESULTADOS

library(ggplot2)

#Primer gráfico: se detallaran las 8 emociones con sus puntajes respectivos
sentimientos1 <- ggplot(emocion.df3[1:8,],
                        aes(x = sentimiento,
                            y = cuenta, fill = sentimiento)) + 
  geom_bar(stat = "identity") +
  labs(title = "Análisis de sentimiento \n Ocho emociones",
       x = "Sentimiento", y = "Frecuencia") +
  geom_text(aes(label = cuenta),
            vjust = 1.5, color = "black",
            size = 5) +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size=12),
        axis.title = element_text(size=14,face = "bold"),
        title = element_text(size=20,face = "bold"),
        legend.position = "none")
print(sentimientos1)


#Segundo gráfico: se detallan los puntajes para las valoraciones
#positiva y negativa
sentimientos2 <- ggplot(emocion.df3[9:10,], 
                        aes(x = sentimiento,
                            y = cuenta, fill = sentimiento)) + 
  geom_bar(stat = "identity") +
  labs(title = "Análisis de sentimiento \n Valoración positiva o negativa", 
       x = "Sentimiento", y = "Frecuencia") +
  geom_text(aes(label = cuenta),
            vjust = 1.5, color = "black",
            size = 5) +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size=12),
        axis.title = element_text(size=14,face = "bold"),
        title = element_text(size=20,face = "bold"),
        legend.position = "none")
print(sentimientos2)
