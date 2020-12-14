body <- dashboardBody(
  add_busy_spinner(spin = "circle", color = "lightgreen", position = 'bottom-right', onstart = T, margins = c(80, 80), height = "90px", width = "90px"),
  tags$head(tagList(
    tags$link(rel = "shortcut icon", href = "https://precise-future-ws.s3.amazonaws.com/fav-final.png"),
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
    HTML('
    <script async src="https://cse.google.com/cse.js?cx=7adacbaed12d22da5"></script>
    <div class="gcse-search"></div>
         ')
  )),
  fixedPanel(
    top = 150, right = 50, actionBttn("restart", "Reiniciar búsqueda", icon = icon("sync-alt"), color = "royal", style = "material-circle")
  ),
  #setSkin(skin = skin),
  tabItems(
    tabItem(
      tabName = "search",
      add_busy_spinner(spin = "circle", color = "lightgreen", position = 'bottom-right', onstart = T,
                       margins = c(80, 80), height = "90px", width = "90px"),
      fluidPage(
        h1("Información de entrada"),
        fluidRow(
          FormTerminoUI("termino_ui")
        )
      ),
      br(),
      br()
    ),
    tabItem(
      tabName = "density",
      add_busy_spinner(spin = "circle", color = "lightgreen", position = 'bottom-right', onstart = T,
                       margins = c(80, 80), height = "90px", width = "90px"),
      fluidPage(
        h1("Densidad de palabras"),
        fluidRow(
          column(
            width = 5,
            uiOutput("select_articles"),
            actionBttn(inputId = "get_denisty", label = "Obtener densidad"),
            actionBttn(inputId = "informe_btn", label = "Generar Informe")
          ),
          column(width = 7, uiOutput("informe_out"))
        ),
        hr(),
        column(width = 12, uiOutput('density'))
      ),
      br(),
      br()
    ),
    tabItem(
      tabName = "report",
      add_busy_spinner(spin = "circle", color = "lightgreen", position = 'bottom-right', onstart = T,
                       margins = c(80, 80), height = "90px", width = "90px"),
      fluidPage(
        column(width = 12, align = "center", h1("Resumen de la Tarea Técnica de Redacción")),
        box(
          width = 12, status = "info",
          h3("Título del Artículo: "),
          textOutput("r_title"),
          hr(),
          h3("Objetivo:"),
          tags$p(textOutput("r_aim")),
          hr(),
          h3("URL Entrante: "),
          uiOutput("r_url_out"),
          h3("URL del Artículo/Slug: "),
          textOutput("r_url")
        ),
        hr(),

        fluidPage(
          column(width = 12, align = "center", h2("Densidad de palabras clave propuesta")),
          fluidRow(
            column(width = 1),
            column(width = 10, box(
              status = "info", width = 12, formattableOutput(outputId = "r_main_density")
            )),
            column(width = 1)
          ),
          hr(),
          column(width = 12, align = "center", h3("Artículos de referencia")),
          column(
            width = 12,
            box(
              width = 12,
              uiOutput("final_report")
            )
          )
        )
      ),
      br(),
      br(),
    )
  ),
  absolutePanel(
    bottom = "1%", right = "10px",
    fluidRow(
      align = "right", column(width = 8, ""),
      column(width = 4, HTML(text = '<img src = "https://precise-future-ws.s3.amazonaws.com/final.png", width = "60%", title = "Precise-Future_logo",
                             alt = "Logo de precise future" />'))
    )
  )
)
