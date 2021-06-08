### res_exploracion_datos.R ###


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
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01/790r")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s03/580r")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s04/250r")
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s05/170r")


# Leer el archivo CSV
#datos <- read.csv('datos.csv')
datos <- read.csv('datos_ed.csv')

datos <- datos[c(-1)]

### Lugar de residencia (país, continente) de viajeros

table(datos$aut_ubic_pais)


paises <- levels(datos$aut_ubic_pais)
# Cuántos países están representados?  = 43
length(paises)

# Exportar lista de países como CSV
#write.csv(paises, file = 'lis_paises.csv')
df2 <- read.csv('lis_paises_continentes.csv', header=TRUE)
df2 <- df2[c(-1)]
colnames(df2)[colnames(df2) == "pais"] <- "aut_ubic_pais" # Renombrar columna

# Importar nombre de continente
df3 = merge(x=datos,y=df2,by="aut_ubic_pais")
continentes <- levels(df3$continente)

cant_viaj_pais <- as.numeric(table(datos$aut_ubic_pais))
cant_viaj_cont <- as.numeric(table(df3$continente))

df <- data.frame(paises, cant_viaj)
df

df_asc <- df[with(df, order(cant_viaj)), ]
df_dsc <- df[with(df, order(-cant_viaj)), ]

# Visualización de datos

# *** Gráficos de barra ***

# Gráfico de barras vertical, simple
barplot(df$cant_viaj ~ df$paises)

ggp <- ggplot(df_asc, aes(paises, cant_viaj)) +    # Create vertical barplot in ggplot2
  geom_bar(stat = "identity")
ggp                                         # Draw vertical barplot in ggplot2

ggplot(df,aes(paises,cant_viaj))+geom_bar(stat="identity")

# Gráfico de barras horizontal, simple
barplot(df_asc$cant_viaj ~ df$paises,            # Horizontal barplot in Base R
        horiz = TRUE)
barplot(df_asc$cant_viaj,names.arg=df$paises,xlab="Cantidad de viajeros",ylab="País",col="blue",
        main="Representación de Países en Reseñas", border="red", horiz = TRUE)


ggp +                                       # Horizontal barplot in ggplot2
  coord_flip()


# Gráfico de barras horizontal, con listado en orden descendente
ggplot(df,aes(x = reorder(paises, cant_viaj), y = cant_viaj))+geom_bar(stat="identity")+coord_flip()

# *** Gráficos de torta ***

ggplot(df, aes(x="", y=cant_viaj, fill=paises)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0)


### Caracterización de viajeros 

# Caracterización por número de aportes (opiniones escritas)

v1 <- as.numeric(as.character(datos$a_num_aportes))
# Quitar valores nulos del vector
v2 <- v1[!is.na(v1)]
# Cuál es el valor máximo?  = 4007 aportes!
min(v2)
max(v2)
mean(v2)
sd(v2)

# Calcular y representar función de densidad
densidad_aportes <- density(v2)
plot(densidad_aportes)

# Histograma
hist(v2)

# Agrupación en cuartiles
df_aportes <- data.frame(v2)
nro_compartim <- 4
df_aportes<-df_aportes%>%mutate(MyQuantileBins = cut(v2, 
                                     breaks = unique(quantile(v2,probs=seq.int(0,1, by=1/nro_compartim))), 
                                     include.lowest=TRUE))
head(df_aportes,10)

df_aportes%>%group_by(MyQuantileBins)%>%count()

# Clasificación cortes naturales
source("/home/yoviajo/Documentos/git_github/tesis/codigo_ref/plotjenks.r")
res <- plotJenks(v2, n=4)
# clases creadas y número de observaciones que caen en cada clase
res$classif
# puntos de corte de las clases
res$classif$brks


## TEMPORALIDAD DE EXPERIENCIAS
v_anios <- as.numeric(as.character(datos$exp_anio))
v2_anios <- v_anios[!is.na(v_anios)]
min(v2_anios)
max(v2_anios)
hist(v2_anios, nclass=11)

t_viaje <- data.frame(datos$exp_anio,datos$exp_mes)
colnames(t_viaje) <- c("anio","mes")

# Gráfico de distribución de experiencias (viajes)
mi_graf <- ggplot(t_viaje, aes(x = anio, y = mes)) +
  geom_point()
mi_graf +
  scale_x_continuous(breaks = seq(2010, 2020, by = 1)) +
  scale_y_continuous(breaks = seq(1, 12, by = 1)) +
  labs(
    x = "Año de viaje",
    y = "Mes de viaje",
    title = "Temporalidad de viajes: mes y año de visita",
    #subtitle = "S01 - Güembé"
    #subtitle = "S03 - Plaza 24 de Septiembre"
    #subtitle = "S04 - Samaipata"
    subtitle = "Iglesias de la Chiquitania"
  )


