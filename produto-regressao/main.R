library(yaml)
library(readr)
library(glue)
library(jsonlite)

source("R/funcoes.R")

config <- read_yaml("configuracao.yaml")

dados <- read_csv(glue("dados/{config$tabela}"))

for(i in 1:length(config$pares)){
  resultado <- modelo(dados,
                      config$pares[[i]]$y,
                      config$pares[[i]]$x)
  write(jsonlite::toJSON(resultado),
        file = glue("resultados/betas{i}.json"))
}

