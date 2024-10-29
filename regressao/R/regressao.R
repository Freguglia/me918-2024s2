#' @title regressao
#' @description aa
#'
#' @param y Vetor de observações da variável resposta.
#' @param X Matriz de covariáveis.
#'
#' @return Objeto da classe `regressao`, com estimativas dos betas,
#' valores preditos, resíduos, e outras informações.
#'
#' @details A função `plot` pode ser utilizada para visualizar o gráfico
#' de valores preditos contra valores observados.
#'
#' A função `predict` pode ser utilizada para fazer novas predições com base
#' no modelo ajustado.
#'
#' @examples
#' modelo <- regressao(exemploy, exemploX)
#' modelo
#' plot(modelo)
#' novoX <- rbind(c(1, 0.5, 3), c(1, 0.8, 1.5))
#' predict(modelo, novoX)
#'
#' @export
regressao <- function(y, X) {

  if(nrow(X) != length(y)){
    stop("O número de observações (linhas de 'X') deve ser igual ao comprimento de 'y'")
  }

  if(length(y) < 2){
    stop("Ao menos 2 observações são necessárias.")
  }

  if(qr(X)$rank != ncol(X)){
    stop("A matriz 'X' deve ter posto completo.")
  }

  betas <- solve(t(X)%*%X)%*%t(X)%*%y
  preditos <- X%*%betas
  residuos <- y - preditos
  n <- length(y)

  if(all(abs(residuos) < 10^(-10))){
    warning("Ajuste perfeito. Overfitting?")
  }

  out <- list(
    betas = betas,
    preditos = preditos,
    residuos = residuos,
    sigma2 = mean(residuos^2),
    y = y,
    X = X,
    n = n
  )
  class(out) <- "regressao"
  return(out)
}

#' @importFrom glue glue
#' @export
print.regressao <- function(x){
  cat(glue("Modelo de Regressão Linear ajustado com {x$n} observações.
           Coeficientes estimados: {paste0(round(x$betas, 3), collapse = ', ')}.
           Variância Estimada: {round(x$sigma2, 3)}."))
}
