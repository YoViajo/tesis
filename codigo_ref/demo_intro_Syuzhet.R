## Ref: https://cran.r-project.org/web/packages/syuzhet/vignettes/syuzhet-vignette.html

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())


library(syuzhet)
my_example_text <- "I begin this story with a neutral statement.  
  Basically this is a very silly test.  
  You are testing the Syuzhet package using short, inane sentences.  
  I am actually very happy today. 
  I have finally finished writing this package.  
  Tomorrow I will be very sad. 
  I won't have anything left to do. 
  I might get angry and decide to do something horrible.  
  I might destroy the entire package and start from scratch.  
  Then again, I might find it satisfying to have completed my first R package. 
  Honestly this use of the Fourier transformation is really quite elegant.  
  You might even say it's beautiful!"

# Obtener oraciones
s_v <- get_sentences(my_example_text)

class(s_v)

str(s_v)

head(s_v)

# Leer documento texto simple de fuente remota
url <- "https://www.gutenberg.org/files/4217/4217-0.txt"
data <- read.table(url, header = FALSE)
head(data)
