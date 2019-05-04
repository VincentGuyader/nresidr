#' return digital as layer
#'
#' @importFrom glue glue
#' @importFrom purrr map
#' @importFrom magick image_read
get_digital <- function(){
  
  glue::glue("{file.path(system.file(package='nresidr','base_digits'),c(0:9,'dot'))}.png") %>% 
    map(image_read) %>% 
    Reduce(c,.)
  
  
}

draw_as_digits <- function(t=lubridate::now()){
  t <- t_char_to_date(t)
  
  h <- as.numeric(format(t,"%H"))
  m <- as.numeric(format(t,"%M"))
  s <- as.numeric(format(t,"%S"))
  
  m <- m + s %/% 60
  h <- h + m %/% 60
  
  h <- h %% 12
  m <- m %% 60
  s <- s %% 60
  
  image_append(get_digital()[c(2,2,11,1,8,11,5,5)]) %>% 
    image_resize("200")
  
}