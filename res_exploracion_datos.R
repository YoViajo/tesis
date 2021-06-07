
# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())


library(ggplot2)
library(magrittr)
library(dplyr)

# Definir directorio de trabajo donde están los archivos CSV
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01/790r")

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
max(v2)

# Calcular y representar función de densidad
densidad_aportes <- density(v2)
plot(densidad_aportes)
