getDensity <- function(url_list) {
  art_density <- lapply(1:length(url_list), function(i) {
    list()
  })
  for (i in 1:length(url_list)) {
    art_density[[i]] <- tryCatch({
      page_source <- httr::content(
        GET(url_list[i], .headers = list(
          "user-agent" = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.67 Safari/537.36"
        ))
      )
      title <- html_text(html_node(page_source, "title"), trim = T)
      title_ngrams <- unlist(tokenize_ngrams(
        str_trim(str_squish(str_flatten(chartr("áéíóú", "aeiou", tolower(str_remove_all(title, "[:punct:]|\n|\t"))), " "))),
        n = 4, n_min = 1
      ))
      meta <- html_nodes(page_source, "meta")
      description <- html_attr(meta[which(html_attr(meta, "name") == "description")], "content")
      desc_ngrams <- unlist(tokenize_ngrams(
        str_trim(str_squish(str_flatten(chartr("áéíóú", "aeiou", tolower(str_remove_all(description, "[:punct:]|\n|\t"))), " "))),
        n = 4, n_min = 1
      ))
      keywords <- html_attr(meta[which(html_attr(meta, "name") == "keywords")], "content")
      p <- html_text(html_nodes(page_source, "p"), trim = T)
      if(is_empty(p)) {
        stop("wrong")
      }
      #spare <- unlist(str_split(p, " "))
      #spare <- spare[!tolower(spare) %in% stopwords("es")]
      flat_text <- str_trim(str_squish(str_flatten(chartr("áéíóú", "aeiou", tolower(str_remove_all(p, "[:punct:]|\n|\t"))), " ")))
      n_grams <- tokenize_ngrams(flat_text, n = 4, n_min = 1, simplify = T)
      this_density <- data.frame(table(n_grams))
      this_density <- this_density[!this_density$n_grams %in% stopwords("es"), ]
      this_density <- this_density[order(this_density$Freq, decreasing = T), ]
      this_density <- this_density[1:80, ]
      #
      h1 <- html_text(html_nodes(page_source, "h1"))
      h1_ngrams <- unlist(tokenize_ngrams(
        str_trim(str_squish(str_flatten(chartr("áéíóú", "aeiou", tolower(str_remove_all(h1, "[:punct:]|\n|\t"))), " "))),
        n = 4, n_min = 1
      ))

      h2 <- html_text(html_nodes(page_source, "h2"))
      h2_ngrams <- unlist(tokenize_ngrams(
        str_trim(str_squish(str_flatten(chartr("áéíóú", "aeiou", tolower(str_remove_all(h2, "[:punct:]|\n|\t"))), " "))),
        n = 4, n_min = 1
      ))

      h3 <- html_text(html_nodes(page_source, "h3"))
      h3_ngrams <- unlist(tokenize_ngrams(
        str_trim(str_squish(str_flatten(chartr("áéíóú", "aeiou", tolower(str_remove_all(h3, "[:punct:]|\n|\t"))), " "))),
        n = 4, n_min = 1
      ))

      h4 <- html_text(html_nodes(page_source, "h4"))
      h4_ngrams <- unlist(tokenize_ngrams(
        str_trim(str_squish(str_flatten(chartr("áéíóú", "aeiou", tolower(str_remove_all(h4, "[:punct:]|\n|\t"))), " "))),
        n = 4, n_min = 1
      ))

      h5 <- html_text(html_nodes(page_source, "h5"))
      h5_ngrams <- unlist(tokenize_ngrams(
        str_trim(str_squish(str_flatten(chartr("áéíóú", "aeiou", tolower(str_remove_all(h5, "[:punct:]|\n|\t"))), " "))),
        n = 4, n_min = 1
      ))

      h6 <- html_text(html_nodes(page_source, "h6"))
      h6_ngrams <- unlist(tokenize_ngrams(
        str_trim(str_squish(str_flatten(chartr("áéíóú", "aeiou", tolower(str_remove_all(h6, "[:punct:]|\n|\t"))), " "))),
        n = 4, n_min = 1
      ))

      density <- data.frame(
        this_density
      )
      density$title <- ifelse(density$n_grams %in% title_ngrams, T, F)
      density$description <- ifelse(density$n_grams %in% desc_ngrams, T, F)
      density$keywords <- ifelse(density$n_grams %in% keywords, T, F)
      density$h1 <- ifelse(density$n_grams %in% h1_ngrams, T, F)
      density$h2 <- ifelse(density$n_grams %in% h2_ngrams, T, F)
      density$h3 <- ifelse(density$n_grams %in% h3_ngrams, T, F)
      density$heading_456 <- ifelse(density$n_grams %in% c(h4_ngrams, h5_ngrams, h6_ngrams), T, F)
      legend <- c("T", "D", "K", "H1", "H2", "H3", "H456")
      density_summary <- data.frame(
        "termino" = as.character(density$n_grams),
        "frecuencia" = density$Freq,
        "encontrado_en" = unlist(lapply(1:nrow(density), function(j) {
          ifelse(is_empty(legend[which(density[j, 3:9] == T)]), " ", str_flatten(legend[which(density[j, 3:9] == T)], " "))
        }))
      )
      density_summary
    }, error = function(e) {
      "wrong"
    })
  }
  return(art_density)
}
