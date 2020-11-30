searchInGoogle <- function(termino = "como aumentar tus clientes y ventas con instagram", location = "es") {
  api_key <- "AIzaSyCbddjTboNPJPsLiTcQqTYygpeD1VtHmsA"
  a <- GET(paste0("https://www.googleapis.com/customsearch/v1?key=", api_key, "&cx=7adacbaed12d22da5&q=", str_replace_all(termino, " ", "+"), "&gl=", location))
  a <- content(a)
  articulos <- data.frame(
    "title" = rep(NA, length(a$items)),
    "url" = rep(NA, length(a$items)),
    "html_title" = rep(NA, length(a$items)),
    "domain" = rep(NA, length(a$items))
  )
  for (i in 1:length(a$items)) {
    articulos$title[i] <- a$items[[i]]$title
    articulos$url[i] <- a$items[[i]]$link
    articulos$html_title[i] <- a$items[[i]]$htmlTitle
    articulos$domain[i] <- a$items[[i]]$displayLink
  }
  return(articulos[!str_detect(articulos$domain, "youtube|pinterest|facebook|tumblr|instagram|linkedin"), ])
  #
}

googleScraper <- function(termino = "como aumentar tus ventas en instagram", ubicacion = "es") {
  query <- paste0("https://www.google.com/search?hl=", ubicacion, "&q=", str_replace_all(termino, " ", "-"))
  response <- GET(query)
  content <- content(response)
  #
}
