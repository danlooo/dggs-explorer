server <- function(input, output) {
  output$viz <- renderUI({
    url <- paste0("http://viz.localhost?path=", URLencode(input$url, reserved = TRUE))
    tags$iframe(src = url, style = "width:100%;height:100%")
  })

  output$api <- renderUI({
    url <- paste0("http://api.localhost/docs")
    tags$iframe(src = url, style = "width:100%;height:100%")
  })

  output$metadata <- renderUI({
    input$url |>
      paste0("/.zattrs") |>
      read_json() |>
      json_view()
  })
}
