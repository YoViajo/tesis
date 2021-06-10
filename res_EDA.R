## Ref: https://finnstats.com/index.php/2021/05/04/exploratory-data-analysis/
## ANÁLISIS EXPLORATORIO DE DATOS (AED)

library(tidyverse)
library(DataExplorer)
library(stringr)

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

# Definir directorio de trabajo donde están los archivos CSV
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01/790r")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s03/580r")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s04/250r")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s05/170r")

# Leer el archivo CSV
datos <- read.csv('datos_ed.csv')

# Ajustes a campos
datos$a_num_aportes <- as.integer(as.character(datos$a_num_aportes))
txt_anio <- str_trim(as.character(datos$exp_anio))
txt_mes <- str_trim(sprintf("%02d",datos$exp_mes))
txt_fecha <- paste(v_anio,v_mes,'01',sep="-")
v_fecha <- as.Date(txt_fecha)
datos$exp_fecha <- v_fecha

# Vista general del conjunto de datos
datos %>% glimpse()

# Introducir el conjunto de datos
datos %>% introduce()

# Visualización
datos %>% plot_intro()

# Muestra qué columnas tienen valores faltantes
datos %>% plot_missing()
datos %>% profile_missing()

# Gráfico de densidad
datos %>% plot_density()

# Histograma
datos %>% plot_histogram()

# Gráfico de barra
datos %>% plot_bar()

# Gráfico de correlación
datos %>% plot_correlation()
