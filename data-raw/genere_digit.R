# DS-Digital
library(magick)
library(tidyverse)
base <- image_read("blanc.png")
base <- image_read("transparent.png")
image_annotate(base, "8", font = 'DS-Digital', size = 1300)
image_annotate(base, "4", font = 'DS-Digital', size = 1300)
image_annotate(base, "1", font = 'DS-Digital', size = 1300)
image_annotate(base, "01234567890", font = 'DS-Digital', size = 1300)

image_annotate(base, "7", font = 'DS-Digital', size = 1300) %>% 
  image_fill("blue") %>%
  image_crop( "540x880+50+210")
image_annotate(base, "  1", font = 'DS-Digital', size = 1300) %>% 
  image_fill("blue") %>%
  image_crop( "540x880+330+230")




image_resize()
0:9 %>% map(
~image_annotate(base, as.character(.x), font = 'DS-Digital', size = 1300) %>% 
  # image_fill("blue") %>%
  image_crop( "540x880+50+210") %>% 
  image_write(glue::glue("{.x}.png"))
)


image_annotate(base, "", font = 'DS-Digital', size = 1300) %>% 
  # image_fill("blue") %>%
  image_crop( "540x880+50+210") %>% 
  image_annotate( "1", font = 'DS-Digital', size = 1300,location = '+303-210') %>% 
  image_write("1.png")
image_annotate(base, "", font = 'DS-Digital', size = 1300) %>% 
  # image_fill("blue") %>%
  image_crop( "540x880+50+210") %>% 
  image_annotate( ":", font = 'DS-Digital', size = 1300,location = '+303-210') %>% 
  image_write("dot.png")

base <- glue::glue("{c(0:9,'dot')}.png") %>% 
  map(image_read)
base[[11]]

layer<-Reduce(c,base)
image_mosaic(layer)



image_append(layer)
image_montage(layer)

write_rds(layer,path = "layer.rds")

read_rds("layer.rds")


get_layer <- function(){
  glue::glue("{c(0:9,'dot')}.png") %>% 
    map(image_read) %>% 
    Reduce(c,.)
  
  
}
microbenchmark::microbenchmark(
a<-get_layer()
)



a<-get_layer()
