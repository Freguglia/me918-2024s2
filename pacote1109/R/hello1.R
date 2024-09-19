#' @title Saudação
#' @rdname saudacao
#'
#' @param nome Nome da pessoa.
#' @param sobrenome Sobrenome da pessoa.
#' @description Diz olá. Olhe também a fórmula
#' de \link[pacote1109]{bhaskara}.
#' @importFrom glue glue
#' @export
hello <- function(nome, sobrenome){
  return(glue("Olá, {nome} {sobrenome}!"))
}

#' @export
glue::glue
