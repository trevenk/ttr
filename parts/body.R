body <- dashboardBody(
  add_busy_spinner(spin = "circle", color = "#cce7e8", position = 'bottom-right', onstart = T, margins = c(80, 80), height = "90px", width = "90px"),
  tags$head(tags$link(rel = "shortcut icon", href = "https://precise-future-ws.s3.amazonaws.com/fav_32.png")),
  #setSkin(skin = skin),
  tabItems(
    tabItem(
      tabName = "main",
      h1("Esto es prueba")
    )
  )
)
