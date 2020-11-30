getDensity <- function(url_list) {
  density <- list()
  for (i in 1:length(url_list)) {
    page_source <- content(
      GET(url_list[i], .headers = list(
        "user-agent" = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.67 Safari/537.36"
      ))
    )
    meta <- html_nodes(page_source, "meta")
    description <- html_attr(meta[which(html_attr(meta, "name") == "description")], "content")
    keywords <- html_attr(meta[which(html_attr(meta, "name") == "keywords")], "content")
    p <- html_text(html_nodes(page_source, "p"), trim = T)
    #spare <- unlist(str_split(p, " "))
    #spare <- spare[!tolower(spare) %in% stopwords("es")]
    flat_text <- str_trim(str_squish(str_flatten(chartr("áéíóú", "aeiou", tolower(str_remove_all(p, "[:punct:]|\n|\t"))), " ")))
    n_grams <- tokenize_ngrams(flat_text, n = 4, n_min = 1, simplify = T)
    this_density <- data.frame(table(n_grams))
    this_density <- this_density[!this_density$n_grams %in% stopwords("es"), ]
    this_density <- this_density[order(this_density$Freq, decreasing = T), ]
    this_density <- this_density[1:80, ]
    #
    density[[i]]$p <- list(
      "p" = this_density
    )
  }
}
