## PROCESAR CAMPOS FECHA - RESEÑAS

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

library(stringr)

# Definir directorio de trabajo donde están los archivos CSV
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01")
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s04/250r")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s05/170r")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s03")

# Leer el archivo CSV
#datos <- read.csv('s01_export_790r.csv')
datos <- read.csv('s04_export.csv')
#datos <- read.csv('s05_export.csv')
#datos <- read.csv('s03_export_580r.csv')

datos <- datos[c(-1)]

## TRANSFORMAR "FECHA_EXPERIENCIA" (fecha y tipo de experiencia)
# Extraer fecha como texto
datos.fec_exp <- str_trim(substr(datos$fecha_experiencia,1,12))

# Separar elementos de fecha
txt_mes <- substr(datos.fec_exp,1,3)

replace_all <- function(df, pattern, replacement) {
  char <- vapply(df, function(x) is.factor(x) || is.character(x), logical(1))
  df[char] <- lapply(df[char], str_replace_all, pattern, replacement)  
  return(df)
}

txt_mes <- replace_all(txt_mes, "ene", "Jan")
txt_mes <- replace_all(txt_mes, "abr", "Apr")
txt_mes <- replace_all(txt_mes, "may", "Jan")
txt_mes <- replace_all(txt_mes, "ago", "Aug")
txt_mes <- replace_all(txt_mes, "dic", "Dec")

# Convertir mes y año a numérico
proper=function(x) paste0(toupper(substr(x, 1, 1)), tolower(substring(x, 2)))
txt_mes <- proper(txt_mes)
txt_mes_num <- match(txt_mes, month.abb)
datos$exp_mes <- txt_mes_num

txt_anio <- substr(datos.fec_exp,9,12)
#txt_anio <- substr(datos.fec_exp,5,8)
txt_anio.num <- as.numeric(txt_anio)
datos$exp_anio <- txt_anio.num

# Extraer tipo de experiencia como texto
#datos.tipo_exp <- str_trim(substr(datos$fecha_experiencia,13,str_length(datos$fecha_experiencia)))
#head(datos.fec_exp)
#head(datos.tipo_exp)

#typeof(datos.tipo_exp)

# Quitar caracter especial de tipo de experiencia
#cad_txt <- datos.tipo_exp[1]
#cad_txt[1]
#car_quitar <- substring(cad_txt, 1, 1)
#datos.tipo_exp <- str_trim(gsub(car_quitar, '', datos.tipo_exp))
#typeof(datos.tipo_exp)

# (alternativa) Extraer directarmente texto de tipo de experiencia
datos.tipo_exp <- substring(datos$fecha_experiencia, 16, str_length(datos$fecha_experiencia))

# Convertir en tipo factor (categoría)
datos.tipo_exp.f <- as.factor(datos.tipo_exp)

datos$exp_tipo <- datos.tipo_exp.f

# Ocurrencia de diferentes valores de tipos de experiencia
table(datos.tipo_exp.f)

## TRANSFORMAR "A_UBICACION" (ubicación de autor de reseña)

datos.a_ubic <- as.character(datos$a_ubicacion)

# Extraer país
txt_ubic_elem <- strsplit(datos.a_ubic, split = ",")

txt_ubic_pais <- vector()
for (i in 1:length(txt_ubic_elem)) {
  if (is.null(txt_ubic_elem[[i]][2])) {
    txt_ubic_pais[i] <- "desconocido"
  } else {
    txt_ubic_pais[i] <- str_trim(txt_ubic_elem[[i]][2])
  }
}

typeof(txt_ubic_pais)

# Reemplazar texto erróneo de país
txt_ubic_pais <- sub("Argentina.", "Argentina", txt_ubic_pais)
txt_ubic_pais <- sub("Ciudad Autónoma de Buenos Aires", "Argentina", txt_ubic_pais)
txt_ubic_pais <- sub("Jujuy", "Argentina", txt_ubic_pais)
txt_ubic_pais <- sub("Salta", "Argentina", txt_ubic_pais)
txt_ubic_pais <- sub("Tucuman", "Argentina", txt_ubic_pais)
txt_ubic_pais <- sub("Isla Gran Bahama", "Bahamas", txt_ubic_pais)
txt_ubic_pais <- sub("bolivia", "Bolivia", txt_ubic_pais)
txt_ubic_pais <- sub("Bolivi", "Bolivia", txt_ubic_pais)
txt_ubic_pais <- sub("Boliviaa", "Bolivia", txt_ubic_pais)
txt_ubic_pais <- sub("Cochabamba", "Bolivia", txt_ubic_pais)
txt_ubic_pais <- sub("La Paz", "Bolivia", txt_ubic_pais)
txt_ubic_pais <- sub("Santa Cruz", "Bolivia", txt_ubic_pais)
txt_ubic_pais <- sub("BA", "Brasil", txt_ubic_pais)
txt_ubic_pais <- sub("MG", "Brasil", txt_ubic_pais)
txt_ubic_pais <- sub("RJ", "Brasil", txt_ubic_pais)
txt_ubic_pais <- sub("SP", "Brasil", txt_ubic_pais)
txt_ubic_pais <- sub("PR", "Brasil", txt_ubic_pais)
txt_ubic_pais <- sub("Canada", "Canadá", txt_ubic_pais)
txt_ubic_pais <- sub("Antofagasta", "Chile", txt_ubic_pais)
txt_ubic_pais <- sub("Maule", "Chile", txt_ubic_pais)
txt_ubic_pais <- sub("Region Metropolitana", "Chile", txt_ubic_pais)
txt_ubic_pais <- sub("Tarapaca", "Chile", txt_ubic_pais)
txt_ubic_pais <- sub("Alabama", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("California", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Carolina del Norte", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Colorado", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Distrito de Columbia", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("District of Columbia", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Florida", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Georgia", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Illinois", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Kansas", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Massachusetts", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Missouri", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("MN", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Nueva Jersey", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Nuevo Mexico", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Estado de Nueva York", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("NY", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Ohio", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Texas", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("TX", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Tennessee", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Utah", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Vermont", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Virginia", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Washington", "EE.UU.", txt_ubic_pais)
txt_ubic_pais <- sub("Madrid", "España", txt_ubic_pais)
txt_ubic_pais <- sub("Distrito Federal", "México", txt_ubic_pais)
txt_ubic_pais <- sub("Netherlands", "Países Bajos", txt_ubic_pais)
txt_ubic_pais <- sub("Ancash", "Perú", txt_ubic_pais)
txt_ubic_pais <- sub("Lima", "Perú", txt_ubic_pais)
txt_ubic_pais <- sub("England", "Reino Unido", txt_ubic_pais)
txt_ubic_pais <- sub("Royaume-uni", "Reino Unido", txt_ubic_pais)
txt_ubic_pais <- sub("Wales", "Reino Unido", txt_ubic_pais)
txt_ubic_pais <- sub("Södermanland County", "Suecia", txt_ubic_pais)


txt_ubic_pais.f <- as.factor(txt_ubic_pais)
table(txt_ubic_pais.f)

datos$aut_ubic_pais <- txt_ubic_pais.f

# Guardar nueva base de datos
write.csv(datos, 'datos.csv')
