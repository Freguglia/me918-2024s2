test_that("hello funciona", {
  expect_equal(hello("a", "b"), "Olá, a b!")
  expect_type(hello("a", "b"), "character")
})
