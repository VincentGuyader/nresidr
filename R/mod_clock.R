# Module UI
  
#' @title   mod_clock_ui and mod_clock_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_clock
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_clock_ui <- function(id){
  ns <- NS(id)
  tagList(
     plotOutput(ns("clock"))
  )
}
    
# Module Server

    
#' @param freq refresh time in milliseconds
#'
#' @rdname mod_clock
#' @export
#' @keywords internal
    
mod_clock_server <- function(input, output, session,freq=1000){
  ns <- session$ns
  output$clock <- renderPlot({
    invalidateLater(freq)
    cadran()
    
  })
}
    
## To be copied in the UI
# mod_clock_ui("clock_ui_1")
    
## To be copied in the server
# callModule(mod_clock_server, "clock_ui_1")
 
