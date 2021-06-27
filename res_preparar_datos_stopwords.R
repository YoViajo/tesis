## Leer archivo JSON

library(tm)

#install.packages("rjson")

# Load the package required to read JSON files.
library("rjson")

# Give the input file name to the function.
palElim <- fromJSON(file = "/home/yoviajo/Documentos/git_github/tesis/datos/stopwords-es.json")

# Print the result.
print(palElim)

class(palElim)
str(palElim)

# Start by importing text file created in step 1:
texto <- readLines(file.choose())

docs <- Corpus(VectorSource(texto))

# Text transformation:
toSpace <- content_transformer (function (x, pattern) gsub(pattern, " ", x))
docs1 <- tm_map(docs, toSpace, "/")
docs1 <- tm_map(docs, toSpace, "@")
docs1 <- tm_map(docs, toSpace, "#")

# Cleaning the Text:
# Convertir el texto a minúsculas
docs1 <- tm_map(docs1, content_transformer(tolower))

# Quitar números
docs1 <- tm_map(docs1, removeNumbers)

# Quitar puntuación
docs1 <- tm_map(docs1, removePunctuation)

# Quitar espacios blancos
docs1 <- tm_map(docs1, stripWhitespace)

# Quitar stop words en español
#docs1 = tm_map(docs1, removeWords, stopwords("spanish"))
docs1 = tm_map(docs1, removeWords, palElim)
#salida <- removeWords(texto, palElim)

