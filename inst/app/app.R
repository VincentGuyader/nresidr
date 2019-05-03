library(shiny)
library(nresidr)

ui <- fluidPage(
  mod_clock_ui("clock_ui_1"),
  mod_clock_ui("clock_ui_2")
  
)

server <- function(input, output, session) {
  callModule(mod_clock_server, "clock_ui_1")
  callModule(mod_clock_server, "clock_ui_2",freq=5000)
  
}

shinyApp(ui, server)