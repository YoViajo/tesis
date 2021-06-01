## PROCESAR CSV FUSIONADOS - RESEÑAS

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

# Definir directorio de trabajo donde están los archivos CSV
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01")

# Leer el archivo CSV
datos <- read.csv('export.csv')

# Quitar columnas innecesarias
datos_2 <- datos[-1]
datos_2 <- datos_2[-1]

# Guardar sólo texto de reseñas
datos_3 <- as.character(datos_2[ , "txt_resenia"])

# Exportar lista a texto plano
sink("solo_resenias.txt")
print(datos_3)
sink()

