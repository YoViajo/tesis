## Ref: https://statisticsglobe.com/merge-csv-files-in-r
## FUSIONAR ARCHIVOS CSV


# Instalar y cargar los paquetes
options("install.lock"=FALSE)
#install.packages("dplyr")                                         # Install dplyr package
#install.packages("plyr")                                          # Install plyr package
#install.packages("readr")                                         # Install readr package
#install.packages("readr", dependencies = TRUE, INSTALL_opts = '--no-lock')

library("dplyr")                                                  # Load dplyr package
library("plyr")                                                   # Load plyr package
library("readr")                                                  # Load readr package

# Importar y fusionar los archivos CSV
data_all <- list.files(path = "/home/yoviajo/Documentos/lab/tesis/p11/extraido/esp",     # Identify all csv files in folder
                       pattern = "*.csv", full.names = TRUE) %>% 
  lapply(read_csv) %>%                                            # Store all files in list
  bind_rows                                                       # Combine data sets into one data set 
data_all                                                          # Print data to RStudio console
