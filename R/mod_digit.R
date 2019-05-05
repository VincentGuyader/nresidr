# Module UI
  
#' @title   mod_digit_ui and mod_digit_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_digit
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_digit_ui <- function(id){
  ns <- NS(id)
  tagList(
    imageOutput(ns("clock"))
  )
}
    
# Module Server
    
#' @rdname mod_digit
#' @export
#' @keywords internal
#' @importFrom magick image_write
    
mod_digit_server <- function(input, output, session,freq=1000){
  ns <- session$ns
  output$clock <- renderImage({
    invalidateLater(freq)
    
    tmpfile <-  draw_as_digits() %>%
      image_write(tempfile(fileext='png'), format = 'png')
    
    # Return a list
    list(src = tmpfile, contentType = "image/png")
  })
}
    
## To be copied in the UI
# mod_digit_ui("digit_ui_1")
    
## To be copied in the server
# callModule(mod_digit_server, "digit_ui_1")
 
