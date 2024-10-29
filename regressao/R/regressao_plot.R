#' @import ggplot2
#' @export
plot.regressao <- function(x){
  data.frame(predito = x$preditos, observado = x$y) |>
    ggplot(aes(x = predito, y = observado)) +
    geom_point() +
    geom_abline(slope = 1, intercept = 0)
}
