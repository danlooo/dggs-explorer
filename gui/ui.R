library(tidyverse)
library(shiny)
library(bslib)
library(jsonlite)
library(yaml)

ui <- page_navbar(
  title = "DGGSexplorer",
  theme = bs_theme(bootswatch = "cyborg", bg = "black", fg = "white"),
  nav_panel(
    "Home",
    textInput("url", "DGGS Data Cube Path", value = "https://s3.bgc-jena.mpg.de:9000/dggs/modis", width = "100vw"),
    verbatimTextOutput("metadata")
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
