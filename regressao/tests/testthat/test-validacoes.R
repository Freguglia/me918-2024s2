test_that("Validações da matriz de covariáveis", {
  X <- cbind(exemploX, 2)
  expect_error(regressao(exemploy, X), "posto completo")

  y <- c(exemploy, 1)
  expect_error(regressao(y, exemploX), regexp = "igual ao comprimento")

  expect_error(regressao(exemploy[1], exemploX[1, , drop = FALSE]),
               regexp = "Ao menos 2")

  expect_warning(regressao(1:3, cbind(rep(1,3), 1:3)))

  expect_s3_class(regressao(exemploy, exemploX), "regressao")
})
