## Ref: https://medium.com/@niharika.goel/merge-multiple-csv-excel-files-in-a-folder-using-r-e385d962a90a
## Adaptado

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())


# Definir directorio de trabajo donde están los archivos CSV
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01/")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s04/")
#setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s05/")
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s03/")

#path <- "/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01/"
#path <- "/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s04/"
#path <- "/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s05/"
path <- "/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s03/"

filenames_list <- list.files(path= path, full.names=TRUE)

All <- lapply(filenames_list,function(filename){
  print(paste("Merging",filename,sep = " "))
  read.csv(filename)
})

df <- do.call(rbind.data.frame, All)

# Exportar a CSV
#write_csv(df, 's01_export.csv')
#write_csv(df, 's04_export.csv')
#write_csv(df, 's05_export.csv')
write.csv(df, 's03_export.csv')
