library(plumber)
library(readr)
library(dplyr)
library(glue)

options("plumber.port" = 7593)

arq_pessoas <- "../pessoas.csv"
arq_mensagens <- "../mensagens.csv"

#* @apiTitle API de Mensagens ME918

#* Página com todas as mensagens
#' @serializer html
#* @get /
function(usuario = NULL) {
  mensagens <- read_csv(arq_mensagens)
  pessoas <- read_csv(arq_pessoas)
  
  if(!is.null(usuario)) mensagens <- filter(mensagens, id_pessoa == usuario)
  
  trechos <- mensagens %>%
    left_join(pessoas, by = c("id_pessoa" = "id")) %>%
    transmute(trechos = glue("<h3>{nome} - {funcao} disse às {data}:
</h3><p>{texto}</p>"))
  
  pagina <- glue('<!DOCTYPE html>
<html>
<body style="background-color:powderblue;">
{paste0(trechos$trechos, collapse = "\n")}
</body>
</html>
')
  return(pagina)
}

#* Registra um novo usuário
#* @param nome Nome do usuário.
#* @param funcao Função do usuário.
#* @post /registroUsuario
function(nome, funcao) {
  pessoas <- read_csv(arq_pessoas, show_col_types = FALSE)
  id <- ifelse(is.numeric(pessoas$id), max(pessoas$id) + 1, 1)
  pessoas <- rbind(pessoas, 
                   data.frame(id = as.integer(id),
                              nome = nome,
                              funcao = funcao))
  readr::write_csv(pessoas, file = arq_pessoas)
  print(glue("Adicionado {nome} - {funcao}."))
}

#* Registra uma nova mensagem
#* @parser json
#* @post /registroMensagem
function(req) {
  mensagens <- readr::read_csv(arq_mensagens,
                               show_col_types = FALSE)
  id <- ifelse(is.numeric(mensagens$id),
               max(mensagens$id) + 1,
               1)
  id_pessoa <- req$body$id_pessoa
  texto <- req$body$texto
  mensagens <- rbind(mensagens, 
                     data.frame(id = as.integer(id),
                                id_pessoa = as.integer(id_pessoa),
                                data = lubridate::now(),
                                texto = texto))
  readr::write_csv(mensagens, file = arq_mensagens)
  print(glue("Mensagem escrita para o usuário {id_pessoa}."))
}

#* Retorna o total de mensagens escritas
#* @parser json
#* @serializer unboxedJSON
#* @get /totalMensagens
function() {
  mensagens <- readr::read_csv(arq_mensagens,
                               show_col_types = FALSE)
  list(total_mensagens = length(unique(mensagens$id)))
}