#' @title Solução de Equações do Segundo Grau
#' @description
#' Encontre a solução de equações de segundo
#' grau da forma
#' \deqn{ax^2 + bx + c = 0}
#' utilizando a fórmula de Bhaskara.
#'
#' @details
#' As soluções apresentadas são apenas as reais.
#'
#' @param a Coeficiente do termo quadrático.
#' @param b Coeficiente do termo linear.
#' @param c Coeficiente constante.
#'
#' @return Um vetor numérico de tamanho
#' 0, 1 ou 2,
#' dependendo do número de soluções reais
#' encontradas.
#'
#' @examples
#' bhaskara(1, 0, -1)
#' bhaskara(1, 0, 1)
#' bhaskara(4, 4, 1)
#'
#' @export
bhaskara <- function(a, b, c){
  if(a == 0){stop("'a' não pode ser zero")}
  delta <- b^2 - 4*a*c
  if(delta == 0){
    return(-b/(2*a))
  } else if(delta > 0){
    s1 <- (-b + sqrt(delta))/(2*a)
    s2 <- (-b - sqrt(delta))/(2*a)
    return(c(s1, s2))
  } else {
    return(numeric(0))
  }
}
