getBestDensity <- function(density) {
  n_art <- length(density[density!="wrong"])
  clear_density <- density[density!="wrong"]
  terminos_list <- unlist(
    lapply(clear_density, function(x) {
      as.character(x$termino)
    })
  )
  terminos_list <- unique(terminos_list)
  terminos_list <- terminos_list[!(terminos_list %in% chartr("áéíóú", "aeiou", stopwords("es")))]
  frecuencia_media <- data.frame("termino" = terminos_list, "frecuencia" = NA, "encontrado_en" = NA)
  for (i in 1:length(terminos_list)) {
    freq <- 0
    found <- ""
    for (j in 1:n_art) {
      position <- which(as.character(clear_density[[j]]$termino) == terminos_list[i])
      if(!is_empty(position)) {
        freq <- freq + clear_density[[j]]$frecuencia[position]
        found <- c(found, clear_density[[j]]$encontrado_en[position])
      }
    }
    frecuencia_media$frecuencia[i] <- freq
    frecuencia_media$encontrado_en[i] <- str_flatten(unique(unlist(str_split(str_trim(str_squish(str_flatten(found, " "))), " "))), " ")
  }
  frecuencia_media <- frecuencia_media[order(frecuencia_media$frecuencia, decreasing = T), ]
  frecuencia_media$frecuencia <- round(frecuencia_media$frecuencia/n_art)
  return(frecuencia_media)
}
