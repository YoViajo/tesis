## Ref: https://medium.com/@niharika.goel/merge-multiple-csv-excel-files-in-a-folder-using-r-e385d962a90a
## Adaptado

# Definir directorio de trabajo donde están los archivos CSV
setwd("/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01/")

path <- "/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01/"
merge_file_name <- "/home/yoviajo/Documentos/lab/tesis/p11/extraido/opiniones/s01//merged_file.csv"

filenames_list <- list.files(path= path, full.names=TRUE)

All <- lapply(filenames_list,function(filename){
  print(paste("Merging",filename,sep = " "))
  read.csv(filename)
})

df <- do.call(rbind.data.frame, All)

# Exportar a CSV
write_csv(df, 'export.csv')
