library(tidyverse)
library(shiny)
library(bslib)
library(shinythemes)
library(jsonlite)
library(jsonview)

ui <- page_navbar(
  title = "DGGSexplorer",
  theme = bs_theme(bootswatch = "cyborg", bg = "black", fg = "white"),
  nav_panel(
    "Home",
    textInput("url", "DGGS Data Cube Path", value = "https://s3.bgc-jena.mpg.de:9000/dggs/modis", width = "100vw"),
    uiOutput("metadata", style = "height:100vh")
  ),
  nav_panel(
    "Map",
    htmlOutput(outputId = "viz", style = "width:100vw;height:100vw")
  ),
  nav_panel(
    "API",
    htmlOutput(outputId = "api", style = "width:100vw;height:100vw")
  )
)
