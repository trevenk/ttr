FormTerminoUI <- function(id) {
  ns <- NS(id)
  tagList(
    column(
      width = 5,
      column(width = 10, textInput(inputId = ns("termino"), label = "Inserta título del artículo", width = "100%")),
      column(width = 2, selectInput(inputId = ns("location"), label = "Ubicación", choices = c(
        "es", "ar", "bo", "cl", "co", "cr", "cu", "do", "ec", "mx", "py", "uy"
      ))),
      actionBttn(inputId = ns("bt_termino"), label = "Evaluar", style = "material-flat", color = "success", size = "xs", block = T)
    ),
    column(
      width = 7, uiOutput(ns("articulos"))
    )
  )
}

FormTerminoServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      observeEvent(input$bt_termino, {

        termino <- input$termino
        location <- input$location
        artic <- searchInGoogle(termino = termino, location = location)

        write.csv(x = artic, file = file.path(tempdir(), "articulos.csv"), row.names = F)

        output$articulos <- renderUI({
          fluidPage(
            lapply(1:nrow(artic), function(i) {
              box(
                width = 6, height = "250px", status = "success",
                title = artic$title[i],
                HTML(text = paste0(
                  'Título con formato: <a href = "', artic$url[i], '" title = "link-to-article">', artic$html_title[i],'</a>'
                )),
                hr(),
                HTML(text = paste0(
                  'Sitio web: <a href = "', artic$domain[i], '" title = "link-to-site">', artic$domain[i],'</a>'
                ))
              )
            })
          )
        })
      })
    }
  )
}
