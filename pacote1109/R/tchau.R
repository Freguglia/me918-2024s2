#' @rdname saudacao
#'
#' @param ate Quando vai encontrar a pessoa.
#' @param aaaaa Erro?.
#' @description Diz adeus.
#' @export
tchau <- function(nome, ate = "amanhã"){
  return(glue("Adeus, {nome}, até {ate}!"))
}
