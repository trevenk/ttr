body <- dashboardBody(
  add_busy_spinner(spin = "circle", color = "#cce7e8", position = 'bottom-right', onstart = T, margins = c(80, 80), height = "90px", width = "90px"),
  tags$head(tagList(
    tags$link(rel = "shortcut icon", href = "https://precise-future-ws.s3.amazonaws.com/fav_32.png"),
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
    HTML('
    <script async src="https://cse.google.com/cse.js?cx=7adacbaed12d22da5"></script>
    <div class="gcse-search"></div>
         ')
  )),
  #setSkin(skin = skin),
  tabItems(
    tabItem(
      tabName = "search",
      fluidPage(
        h1("Información de entrada"),
        fluidRow(
          FormTerminoUI("termino_ui")
        )
      )
    ),
    tabItem(
      tabName = "density",
      fluidPage(
        h1("Densidad de palabras"),
        fluidRow(
          column(width = 5, uiOutput("select_articles"), actionBttn(inputId = "get_denisty", label = "Obtener densidad")),
          column(width = 6, uiOutput('density'))
        )
      )
    )


  )
)
