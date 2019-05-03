library(tidyverse)
library(ggforce)
# https://stackoverflow.com/questions/6862742/draw-a-circle-with-ggplot2
circleFun <- function(center = c(0,0),
                      r = 1,
                      npoints = 100){
  tt <- seq(0,2*pi,length.out = npoints)
  yy <- center[1] + r * cos(tt)
  xx <- center[2] + r * sin(tt)
  data.frame(x = xx, y = yy)
}
coord<-circleFun(npoints = 60*12)
#' @importFrom ggforce geom_circle
#' @import ggplot2
cadran<- function(t = Sys.time(),
                  h ,
                  m ,
                  s ,
                  sec=TRUE,
                  coord.h=circleFun(npoints = 60*12,r=0.8),
                  coord.m=circleFun(npoints = 60*12),
                  coord.s=coord.m){


  if (is.character(t)){
    res <- NA
    try(res <- lubridate::hms(t) %>%  as.Date(origin=Sys.Date()),silent=TRUE)
    if (is.na(res)){

      suppressWarnings(
      res <- lubridate::hm(t) %>%  as.Date(origin=Sys.Date())
      )
    sec = FALSE
    }
    t <- res
  }

if (missing(h)){h <- as.numeric(format(t,"%H"))}
if (missing(m)){m <- as.numeric(format(t,"%M"))}
if (missing(s)){s <- as.numeric(format(t,"%S"))}

  m <- m + s %/% 60
  h <- h + m %/% 60

  h <- h %% 12
  m <- m %% 60
  s <- s %% 60

  sens.h <- ifelse(h<=6,"last","first")
  sens.m <- ifelse(m<=30,"last","first")
  sens.s <- ifelse(s<=30,"last","first")


  pos.h <- if (h!=0){coord.h[60 * h + m,]}else{data.frame(x=0,y=0.8)}
  lignes.h <- rbind(data.frame(x=0,y=0),pos.h)
  aiguille.h <- geom_line(data=lignes.h, aes(x, y),color = "green",
            arrow = arrow(length = unit(0.5, "cm"),
                          ends = sens.h))

  pos.m <- if (m!=0){coord.m[12 * m,]}else{data.frame(x=0,y=1)}
  lignes.m <- rbind(data.frame(x=0,y=0),pos.m)
  aiguille.m <- geom_line(data=lignes.m, aes(x, y),color = "blue",
            arrow = arrow(length = unit(0.5, "cm"),
                          ends = sens.m))

  pos.s <- if (s!=0){coord.s[12 * s,]}else{data.frame(x=0,y=1)}
  lignes.s <- rbind(data.frame(x=0, y=0),pos.s)
  aiguille.s <- geom_line(data=lignes.s, aes(x, y),color = "red",
            arrow = arrow(length = unit(0.5, "cm"),
                          ends = sens.s))

  out <- ggplot() +
    geom_circle(aes(x0 = 0, y0 = 0, r = 1)) +
    coord_fixed() +
    aiguille.h +
    aiguille.m +
     ggthemes::theme_solid()

  if ( sec){

    out <- out + aiguille.s
  }
  out
}

cadran(h = 3,m = 4,sec=FALSE)
cadran(h = 3,m = 15,sec=FALSE)
cadran(h = 3,m = 15)
cadran(h = 3,m = 15,s=15)
cadran(h = 3,m = 15,s=16)
cadran(h = 3,m = 15,s=17)
cadran(h = 3,m = 15,s=18)

cadran(h = 3,m = 4,s=22)
cadran(h = 3,m = 4,s=25)
cadran(t="11:45:23")
cadran(t="07:46:23")
cadran(t="07:46")
nresidr::cadran(t="07:46")

cadran()

library(magick)
library(lubridate)
img <- image_graph(400, 400, res = 96)
tt <- seq(from=now(),length.out = 100,by="1 min")
tt
map(tt,~cadran(.x,sec=FALSE))
dev.off()
animation <- image_animate(img, fps = 1)
print(animation)
image_write(animation, "clock2.gif")



ggsave(animation,filename = "out.gif")
frames <-

  image_animate(frames, fps = 1)

library(magick)
magick::image_animate()
a<-Sys.time()
format(a,"%H")
format(a,"%M")
