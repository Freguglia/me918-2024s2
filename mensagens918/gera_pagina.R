library(dplyr)
library(glue)

gera_pagina <- function(){
  mensagens <- readr::read_csv("mensagens.csv")
  pessoas <- readr::read_csv("pessoas.csv")
  
  trechos <- mensagens %>%
    left_join(pessoas, by = c("id_pessoa" = "id")) %>%
    transmute(trechos = glue("<h3>{nome} - {funcao} disse às {data}:
</h3><p>{texto}</p>"))
  
  pagina <- glue('<!DOCTYPE html>
<html>
<body style="background-color:powderblue;">
{paste0(trechos$trechos)}
</body>
</html>
')
  readr::write_lines(pagina, "conversa.html")
}