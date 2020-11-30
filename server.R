shinyServer(function(input, output, session) {
  SidebarServer(id = 'sidebar_ui', user = 0)
  FormTerminoServer("termino_ui")

  choices_df <- reactive({
    tryCatch({
      read.csv(file = file.path(tempdir(), "articulos.csv"))
    }, error = function(e) {
      NULL
    })
  })

  output$select_articles <- renderUI({
    checkboxGroupInput(
      inputId = "check_articulos", label =" Seleccionar artículos de interés", choiceNames = choices_df()$title,
      choiceValues = choices_df()$url, selected = choices_df()$title[1], width = "100%"
    )
  })

  observeEvent(input$get_denisty, {
    url_list <- input$check_articulos
    density <- getDensity(url_list)
  })

})
