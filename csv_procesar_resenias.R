## PROCESAR CSV FUSIONADOS - RESEÑAS

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

# Definir directorio de trabajo donde están los archivos CSV
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s04")
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s05/170r")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s03")

# Leer el archivo CSV
#datos <- read.csv('s01_export.csv')
#datos <- read.csv('s04_export.csv')
datos <- read.csv('s05_export.csv')
#datos <- read.csv('s03_export_580r.csv')

# Quitar columnas innecesarias y filas duplicadas
#datos_1 <- datos[c(-1,-2,-3)]
#datos_1 <- datos[c(-1,-2)]
datos_1 <- datos[c(-1)]
datos_2 <- unique(datos_1)

# Guardar sólo texto de reseñas
datos_3 <- as.character(datos_2[ , "txt_resenia"])

# Exportar lista a texto plano
sink("solo_resenias.txt")
print(datos_3)
sink()

