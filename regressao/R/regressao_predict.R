#' @export
predict.regressao <- function(object, novoX){
  return(as.vector(novoX%*%object$betas))
}
