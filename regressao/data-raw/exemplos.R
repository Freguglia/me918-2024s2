set.seed(1)
exemploX <- cbind(
  1,
  runif(100),
  rnorm(100, mean = 3, sd = 3)
)

beta <- c(2, -0.3, 1.8)

exemploy <- rnorm(100, mean = exemploX%*%beta, sd = 0.8)

usethis::use_data(exemploX, overwrite = TRUE)
usethis::use_data(exemploy, overwrite = TRUE)
