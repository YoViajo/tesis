## PROCESAR CAMPOS FECHA - RESEÑAS

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

library(stringr)

# Definir directorio de trabajo donde están los archivos CSV
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s05/170r")

# Leer el archivo CSV
datos <- read.csv('datos.csv')

datos <- datos[c(-1)]
colnames(datos) <- c("op_titulo","exp_fec_txt","op_texto","op_escrito","vj_nombre","vj_perfil","vj_aportes","vj_seunio","vj_ubicac","exp_mes","exp_anio","exp_tipo","vj_pais")

opiniones <- as.character(datos$op_texto)
typeof(opiniones)
length(opiniones)
# Máxima longitud de texto de opiniones
max(nchar(opiniones))

# Guardar nueva base de datos
write.csv(datos, 'datos.csv')
