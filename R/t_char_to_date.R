#' @importFrom lubridate hms hm
t_char_to_date <- function(t){

if (is.character(t)){
  res <- NA
  try(res <- lubridate::hms(t) %>%  as.Date(origin=Sys.Date()),silent=TRUE)
  if (is.na(res)){
    res <- lubridate::hm(t) %>%  as.Date(origin=Sys.Date())
    sec = FALSE
  }
  t <- res
}

t
  }
