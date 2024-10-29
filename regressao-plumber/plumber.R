library(plumber)
library(readr)
library(ggplot2)

caminho_dados <- "data/dados_regressao.csv"
if(file.exists(caminho_dados)){
  df <- readr::read_csv(caminho_dados)
} else {
  ra <- 137784
  set.seed(ra)
  b0 <- runif(1, -2, 2); b1 <- runif(1, -2, 2)
  bB <- 2; bC <- 3
  n <- 25
  x <- rpois(n, lambda = 4) + runif(n, -3, 3)
  grupo <- sample(LETTERS[1:3], size = n, replace = TRUE)
  y <- rnorm(n, mean = b0 + b1*x + bB*(grupo=="B") + bC*(grupo=="C"), sd = 2)
  df <- data.frame(x = x, grupo = grupo, y = y,
                   momento_registro = lubridate::now())
  readr::write_csv(df, file = caminho_dados)
}
ajuste <- lm(y ~ x * grupo, data = df)

#* @apiTitle Exemplo API regressão - Trabalho 3 ME918 - 2024s2

#* Inclui um novo registro no banco de dados
#* @serializer unboxedJSON
#* @param x Variável `x` da observação a ser registrada.
#* @param grupo Variável `grupo` da observação a ser registrada.
#* Valores precisam ser A, B ou C.
#* @param y Variável `y` da observação a ser registrada.
#* @post /registrar
function(x, grupo, y){
  novo <- data.frame(x = x, grupo = grupo, y = y,
                     momento_registro = lubridate::now())
  df <<- rbind(df, novo)
  n <- nrow(df)
  readr::write_csv(novo, file = caminho_dados, append = TRUE)
  ajuste <<- lm(y ~ x * grupo, data = df)
  return(cbind(novo, data.frame(n = n)))
}

#* Gera gráfico dos dados no estado atual
#* @serializer png
#* @get /grafico
function(){
  pl <- ggplot(df, aes(x = x, y = y, color = grupo)) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    theme_bw()
  print(pl)
}

#* Estimativas dos parâmetros
#* @serializer unboxedJSON
#* @get /estimativas
function(){
  as.list(c(unlist(ajuste$coefficients),
            sigma2 = (summary(ajuste)$sigma)^2))
}

#* Predições
#* @serializer unboxedJSON
#* @param x:float Valor de `x` da observação a ter a resposta predita.
#* @param grupo:string Valor de `grupo` da observação a ter a resposta predita.
#* @get /predicao
function(x, grupo){
  list(predito = as.vector(predict(ajuste, data.frame(x = as.numeric(x),
                                                      grupo = grupo))))
}
