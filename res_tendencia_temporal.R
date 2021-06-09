### res_tendencia_temporal.R ###

library ("dplyr")

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())


# Definir directorio de trabajo donde están los archivos CSV
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01/790r")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s03/580r")
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s04/250r")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s05/170r")


# Leer el archivo CSV
datos <- read.csv('datos_ed.csv')

datos <- datos[c(-1)]

datos$exp_anio <- as.integer(datos$exp_anio)

lis_anios <- datos$exp_anio
nva_lista <- lis_anios[!is.na(lis_anios)]

a_ini <- min(nva_lista)
a_fin <- max(nva_lista)

i <- 1
lis_anios <-''
lis_anasem <- ''
# Recorrer todos los años
for (a in a_ini:a_fin) {
  print(a)
  datos_sel <- filter(datos, exp_anio==a)
  #num_reg <- nrow(datos_sel)
  #print(num_reg)
  nrc_vector <- get_sentiment(datos_sel$txt_resenia, method = "nrc", lang = "spanish")
#  nrc_vector <- get_sentiment(datos_sel$op_texto, method = "nrc", lang = "spanish")
  prom_anasem <- mean(nrc_vector)
  print(mean(prom_anasem))
  lis_anios[i] <- a
  lis_anasem[i] <- prom_anasem
  i <- i+1
}
max_anasem <- max(as.numeric(lis_anasem))
df_anasem <- data.frame(lis_anios,lis_anasem)
colnames(df_anasem) <- c("anio", "val_sent")

df_anasem[] <- lapply(df_anasem, function(x) if(is.factor(x)) as.numeric(as.character(x)) else x)

# Exportar a CSV
#write.csv(df_anasem, "s01_anasem.csv")
#write.csv(df_anasem, "s03_anasem.csv")
write.csv(df_anasem, "s04_anasem.csv")
#write.csv(df_anasem, "s05_anasem.csv")

# Gráfico de tendencia de valores de sentimiento en el tiempo
mi_graf <- ggplot(df_anasem, aes(x = anio, y = val_sent)) +
  geom_point()
mi_graf +
  scale_x_continuous(breaks = seq(a_ini, a_fin, by = 1)) +
  scale_y_continuous(breaks = seq(1, max_anasem, by = 0.5)) +
  labs(
    x = "Año del viaje",
    y = "Valoración de sentimiento",
    title = "Variación temporal de valoración promedio de sentimiento",
    #subtitle = "S01 - Güembé"
    #subtitle = "S03 - Plaza 24 de Septiembre"
    #subtitle = "S04 - Samaipata"
    subtitle = "S05 - Iglesias de la Chiquitania"
  )
