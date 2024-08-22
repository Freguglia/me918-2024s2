modelo <- function(tabela, y, x){
  regression <- paste0(y, " ~ ", x)
  ajuste <- lm(as.formula(regression), data = tabela)
  return(list(beta0 = ajuste$coef[1], beta1 = ajuste$coef[2]))
}
