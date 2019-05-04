#' return digital as layer
#'
#' @importFrom glue glue
#' @importFrom purrr map
#' @importFrom magick image_read
#' @importFrom magrittr %>%
get_digital <- function(){
  
  glue::glue("{file.path(system.file(package='nresidr','base_digits'),c(0:9,'dot'))}.png") %>% 
    map(image_read) %>% 
    Reduce(c,.)
  
  
}

#' draw time using digits number
#'
#' @param t time to draw
#' @param size size in pixel
#' @param ampm if FALSE (by default) use 24H clock
#'
#' @export
#'
#' @examples
#' draw_as_digits(lubridate::now())
#' @importFrom magrittr %>%
#' @importFrom magick image_resize image_append
draw_as_digits <- function(t=lubridate::now(),size=200,ampm=FALSE){
  t <- t_char_to_date(t)
  
  h <- as.numeric(format(t,"%H"))
  m <- as.numeric(format(t,"%M"))
  s <- as.numeric(format(t,"%S"))
  
  m <- m + s %/% 60
  h <- h + m %/% 60
  
if (ampm){  h <- h %% 12}

  image_append(get_digital()[to_index(h,m,s)]) %>% 
      image_resize(geometry = size)
  
}

to_index <- function(h,m,s){  c(en_2(h)+1,11,en_2(m)+1,11,en_2(s)+1)}
en_2 <- function(n){c(n%/%10,n%%10)}
