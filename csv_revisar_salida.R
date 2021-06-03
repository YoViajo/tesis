## REVISAR SALIDA DE WEB SCRAPER

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

# Definir directorio de trabajo donde están los archivos CSV
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s04")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s05")
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s03")

# Leer el archivo CSV
#datos <- read.csv('s01_export.csv')
#datos <- read.csv('s04_export.csv')
#datos <- read.csv('s05_export.csv')
#datos <- read.csv('ta_resenia_sitio.csv')
#datos <- read.csv('ta_resenia_sitio_790r.csv')
datos <- read.csv('ta_resenia_sitio_580r.csv')

# Quitar columnas innecesarias
datos_2 <- datos[c(-1,-2)]
datos_3 <- unique(datos_2)

# Guardar archivo CSV
write.csv(datos_3, 's03_export.csv')
#write.csv(datos_3, 's01_export.csv')
