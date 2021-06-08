seleccionar_anio <- function(df, anio){
  df_sel <- df[df$exp_anio==anio,]
  return(df_sel)
}