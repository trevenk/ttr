SidebarUI <- function(id) {
  ns <- NS(id)
  sidebarMenuOutput(ns('dynamic_sidebar'))
}

SidebarServer <- function(id, user) {
  moduleServer(
    id,
    function(input, output, session) {
      output$dynamic_sidebar <- renderMenu({
        sidebarMenu(
          id = "menu",
          menuItem(text = "Buscar", icon = icon('search'), badgeLabel = "dev", badgeColor = "yellow", tabName = 'search',
                   selected = T),
          menuItem(text = "Densidad", icon = icon('spider'), badgeLabel = "dev", badgeColor = "yellow", tabName = 'density',
                   selected = F),
          menuItem(text = "Reporte", icon = icon('paste'), badgeLabel = "dev", badgeColor = "yellow", tabName = 'report',
                   selected = F)
        )
      })
    }
  )
}
