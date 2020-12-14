shinyServer(function(input, output, session) {
  SidebarServer(id = 'sidebar_ui', user = 0)
  FormTerminoServer("termino_ui")

  observeEvent(input$restart, {
    session$reload()
  })

  choices_df <- reactive({
    tryCatch({
      read.csv(file = file.path(tempdir(), "articulos.csv"))
    }, error = function(e) {
      NULL
    })
  })

  output$select_articles <- renderUI({
    the_choices <- choices_df()
    checkboxGroupInput(
      inputId = "check_articulos", label =" Seleccionar artículos de interés", choiceNames = the_choices$title,
      choiceValues = 1:nrow(the_choices), selected = 1, width = "100%"
    )
  })

  observeEvent(input$get_denisty, {
    the_choices <- choices_df()
    selected_choices <- input$check_articulos
    print(paste0("Choices: ", str_flatten(selected_choices, ", ")))
    url_list <- the_choices$url[as.numeric(c(selected_choices))]
    titles_list <- the_choices$title[as.numeric(c(selected_choices))]
    print(paste0("Selected list", titles_list, "  -->  ", url_list))
    density <- getDensity(url_list)
    best <- getBestDensity(density)
    output$density <- renderUI({
      lapply(1:length(density), function(i) {
        box(
          width = 12, title = titles_list[i], status = "success", solidHeader = T,
          HTML(text = format_table(density[[i]], format = "html"))
        )
      })
    })
    observeEvent(input$informe_btn, {
      showModal(
        modalDialog(
          title = "Detalles del artículo", easyClose = F, size = "m", fade = T,
          footer = actionBttn(inputId = "final_generate", label = "Generar", style = "material-flat", size = "xs", block = T, color = "success"),
          fluidPage(
            textAreaInput(inputId = "i_aim", label = "Objetivo del artículo"),
            textInput(inputId = "i_url_out", label = "URL del enlace a posicionar"),
            textInput(inputId = "i_url_aim", label = "URL que tendrá el artículo")
          )
        )
      )

      observeEvent(input$final_generate, {
        Sys.setenv(
          "OBJETIVO" = input$i_aim,
          "URL_OUT" = input$i_url_out,
          "URL_AIM" = input$i_url_aim
        )
        removeModal(session)

        Sys.sleep(2)

        updateTabItems(session = session, inputId = "menu", selected = "report")

        Sys.sleep(2)

        the_titles <- titles_list
        density <- density[density != "wrong"]
        density <- lapply(density, function(x) {
          x[1:10, ]
        })

        output$r_main_density <- renderFormattable({
          formattable(x = best[1:20, ], align = c("l", "r", "c"), list(
            frecuencia = normalize_bar(color = "lightgreen", 0.2),
            termino = formatter("span",
                                style = x ~ style(color = "gray")
            )
          ))
        })

        output$r_title <- renderText({
          Sys.getenv("TERMINO")
        })

        output$r_aim <- renderText({
          Sys.getenv("OBJETIVO")
        })

        output$r_url_out <- renderUI({
          sp <- Sys.getenv("URL_OUT")
          tags$ul(lapply(str_trim(str_squish(unlist(str_split(sp, ",")))), function(x) {
            tags$li(x)
          }))
        })

        output$r_url <- renderText({
          Sys.getenv("URL_AIM")
        })

        output$final_report <- renderUI({
          lapply(1:length(density), function(i) {
            box(
              width = 12, status = "success", solidHeader = T, title = HTML(text = paste0(
                '<a href = "', url_list[i], '" title = "link-to-article">', the_titles[i], '</a>'
              )),
              HTML(text = format_table(density[[i]], format = "html"))
            )
          })
        })
      })
    })
  })

})
