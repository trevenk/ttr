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
          menuItem(text = "Home", icon = icon('home'), badgeLabel = "dev", badgeColor = "yellow", tabName = 'main',
                   selected = F)
        )
      })
    }
  )
}
