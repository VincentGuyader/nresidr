#' draw a wath
#' @param t time as character POSIXct or Date
#' @param sec booleen display needle second hand
#' @param coord.h coordinates of hours
#' @param coord.m coordinates of minutes
#' @param coord.s coordinates of seconds
#' @param color.h hour needle color
#' @param color.m minute needle color
#' @param color.s second needle color
#'
#' @importFrom ggforce geom_circle
#' @importFrom ggthemes theme_solid
#' @import ggplot2
#' @export
#' @examples
#' cadran()
#' cadran(t="11:45:23")
#' cadran(t="07:46:23")
#' cadran(t="07:46:23",sec=FALSE)
#' cadran(t="07:46")
#'
cadran<- function(t = Sys.time(),
                  sec=TRUE,
                  coord.h=circleFun(npoints = 60*12,r=0.8),
                  coord.m=circleFun(npoints = 60*12),
                  coord.s=coord.m){


t <- t_char_to_date(t)

 h <- as.numeric(format(t,"%H"))
 m <- as.numeric(format(t,"%M"))
 s <- as.numeric(format(t,"%S"))

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
