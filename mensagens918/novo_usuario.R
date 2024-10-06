novo_usuario <- function(nome, funcao) {
  pessoas <- readr::read_csv("pessoas.csv",
                               show_col_types = FALSE)
  id <- ifelse(is.numeric(pessoas$id),
               max(pessoas$id) + 1,
               1)
  pessoas <- rbind(pessoas, 
                     data.frame(id = id,
                                nome = nome,
                                funcao = funcao))
  readr::write_csv(pessoas, file = "pessoas.csv")
}
