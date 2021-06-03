## PROCESAR CAMPOS FECHA - RESEÑAS

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

library(stringr)

# Definir directorio de trabajo donde están los archivos CSV
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01/790r")

# Leer el archivo CSV
datos <- read.csv('datos_ed.csv')

datos <- datos[c(-1)]

# Distribución geográfica de viajeros
paises_nombre <- levels(datos$aut_ubic_pais)
paises_numvia <- table(datos$aut_ubic_pais)
lis_paises <- data.frame(paises_nombre,paises_numvia)
lis_paises <- lis_paises[c(-2)]
colnames(lis_paises) <- c("pais", "num_viajeros")

write.csv(dist_anios, 'tab_dist_geog.csv')

# Distribución temporal de opiniones
lis_anios <- as.factor(datos$exp_anio)
anio_etiq <- levels(lis_anios)
anio_numvia <- table(lis_anios)
dist_anios <- data.frame(anio_etiq,anio_numvia)
dist_anios <- dist_anios[c(-2)]
colnames(dist_anios) <- c("anio", "num_viajeros")

write.csv(dist_anios, 'tab_anios.csv')

# Distribución de tipo de experiencia
lis_texp <- as.factor(datos$exp_tipo)
texp_etiq <- levels(lis_texp)
texp_numvia <- table(lis_texp)
dist_texp <- data.frame(texp_etiq,texp_numvia)
dist_texp <- dist_texp[c(-2)]
colnames(dist_texp) <- c("tipo de experiencia", "num viajeros")

write.csv(dist_texp, 'tab_tipo_experiencia.csv')

