test_that("Comportamento do Bhaskara é o esperado", {
  expect_equal(bhaskara(4, 4, 1), -0.5)
  expect_equal(bhaskara(1, 2, 0), c(0, -2))
  expect_type(bhaskara(4, 4, 1), "double")
  expect_error(bhaskara("string", 1, 2))
  expect_error(bhaskara(0, 1, 2))
})
