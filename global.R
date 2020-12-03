library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(shinybusy)

library(rvest)
library(stringr)
library(httr)
library(rlang)
library(tokenizers)
library(tm)
library(formattable)

source("methods/googleCustomSearch.R")
source("methods/scraper.R")
source("methods/transform.R")

source("modules/Sidebar.R")
source("modules/FormTermino.R")
source("modules/ArticuloOutput.R")

#termino <<- "prueba"
