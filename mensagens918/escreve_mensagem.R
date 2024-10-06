source("gera_pagina.R")

escreve_mensagem <- function(id_pessoa, texto) {
  mensagens <- readr::read_csv("mensagens.csv",
                               show_col_types = FALSE)
  id <- ifelse(is.numeric(mensagens$id),
               max(mensagens$id) + 1,
               1)
  mensagens <- rbind(mensagens, 
                     data.frame(id = id,
                                id_pessoa = id_pessoa,
                                data = lubridate::now(),
                                texto = texto))
  readr::write_csv(mensagens, file = "mensagens.csv")
  gera_pagina()
}