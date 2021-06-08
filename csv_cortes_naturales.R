
#*#*# csv_cortes_naturales.R #*#*#

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())


library(ggplot2)
library(magrittr)
library(dplyr)
library(classInt)

# Definir directorio de trabajo donde están los archivos CSV
setwd("/home/yoviajo/Documentos/git_github/tesis/datos")


# Leer el archivo CSV
datos <- read.csv('tab_pais_numviajeros.csv')

v <- as.numeric(as.character(datos$tot_viajeros))


# Clasificación cortes naturales
source("/home/yoviajo/Documentos/git_github/tesis/codigo_ref/plotjenks.r")
res <- plotJenks(v, n=4)
# clases creadas y número de observaciones que caen en cada clase
res$classif
# puntos de corte de las clases
res$classif$brks
