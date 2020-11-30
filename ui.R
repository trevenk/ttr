source("parts/header.R")
source("parts/sidebar.R")
source("parts/body.R")
#source("parts/r_sidebar.R")

ui <- dashboardPagePlus(
  header = header,
  title = "Tarea técnica de redacción",
  sidebar = sidebar,
  body = body,
  sidebar_fullCollapse = F,
  #rightsidebar = rsidebar,
  skin = "black",
  collapse_sidebar = T
)
