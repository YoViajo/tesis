## Ref: https://www.learn-r.org/r-tutorial/read-csv.php

library(stringr)

# Mostrar directorio actual de trabajo
getwd()

# Definir directorio de trabajo donde están los archivos CSV
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/esp/combin")

# Leer el archivo CSV
datos <- read.csv('ta_atracciones_scz_todo.csv')

# Convertir factor a numérico
x_num <- as.numeric(as.character(datos$opiniones_nro))
str(x_num)

# Mostrar máximo y mínimo, sin considerar nulos
max(x_num, na.rm = TRUE)
min(x_num, na.rm = TRUE)

# Reemplazar nulos por 0
x_num[is.na(x_num)] <- 0

# Quitar columnas innecesarias
datos_nvo1 <- datos[-1]
datos_nvo2 <- datos_nvo1[-1]

# Añadir versión convertida de opiniones_nro y quitar antigua
datos_nvo2$opin_num <- x_num
datos_nvo2 <- datos_nvo2[-3]

# Dividir en elementos el campo texto "nombre"
nombre_txt <- as.character(datos_nvo2$nombre)

#gregexpr(pattern ='\\.',nombre_txt)
nombre_div <- str_split(nombre_txt, "\\.")

for (i in 1:length(nombre_div)) {
  lista <- nombre_div[[i]]
  atrac_pos[i] <- trimws(lista[1])
  atrac_nombre[i] <- trimws(lista[2])
}

datos_nvo2$a_pos <- as.numeric(atrac_pos)
datos_nvo2$a_nom <- atrac_nombre
datos_nvo3 <- datos_nvo2[-1]
datos_nvo4 <- datos_nvo3[ , c("a_pos","a_nom","categoria","opin_num")]

# Exportar a CSV
write_csv(datos_nvo4, 'export.csv')

