#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  callModule(mod_digit_server, "digit_ui_1")
  callModule(mod_clock_server, "clock_ui_1")
}
