library(plumber)

#* @apiTitle API Exemplo ME918
#* @apiDescription Exemplos utilizados na aula de ME918.

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
#* @get /mensagem
function(msg = "") {
    list(msg = paste0("The message is: '", msg, "'"))
}

#* Histograma de n amostras da normal padrão
#* @serializer jpeg
#* @param n Número de amostras
#* @get /plot
function(n = 100) {
  rand <- rnorm(n)
  hist(rand)
}

df <- gapminder::gapminder
#* Dados de um país
#* @serializer json
#* @param pais País a específico os dados
#* @get /dadosJson
function(pais = "Brazil") {
  df[df$country == pais,]
}

#* Dados de um país em csv
#* @serializer csv
#* @param pais País a específico os dados
#* @get /dadosCsv
function(pais = "Brazil") {
  df[df$country == pais,]
}

library(lubridate)
library(glue)
dias_semana_aula <- c(3, 5) # segunda e quarta
feriados <- c("2024-10-28", "2024-11-20")
ultimo_dia <- "2024-11-28"
#* Verifica se hoje tem aula de ME918
#* @serializer text
#* @get /temAula
function() {
  hoje <- today()
  tem_aula <- (wday(hoje) %in% dias_semana_aula) & !(hoje %in% feriados) &
    (hoje < ultimo_dia)
  glue("Hoje {ifelse(tem_aula, '', 'não')} tem aula de ME918.")
}

contador <- 0
#* Incrementa um contador
#* @serializer text
#* @get /contador
function() {
  contador <<- contador + 1
  glue("Essa rota já teve {contador} acessos.")
}
