test_that("get_x_data: check output", {
  # create temporary data set
  path <- tempfile(fileext = ".csv")
  n <- 20
  df <- data.frame(
    control = rnorm(n),
    treatment = rnorm(n, mean = 0.8)
  )
  utils::write.csv(df, path, row.names = FALSE)
  # create user input
  input <- list(
    long_data = FALSE,
    x_name_long_false = "control",
    x_name_long_true = "treatment"
  )
  # tests
  expect_equal(
    get_x_data(input, df),
    df[,"control"]
  )
  input$long_data = TRUE
  expect_equal(
    get_x_data(input, df),
    df[,"treatment"]
  )
})


test_that("get_y_data: long_data false", {
  # create temporary data set
  path <- tempfile(fileext = ".csv")
  n <- 20
  df <- data.frame(
    control = rnorm(n),
    treatment = rnorm(n, mean = 0.8)
  )
  utils::write.csv(df, path, row.names = FALSE)
  # create user input
  input <- list(
    long_data = FALSE,
    y_name_long_false = "(None)"
  )
  # tests
  expect_equal(
    get_y_data(input, df),
    NULL
  )
  input$y_name_long_false = "control"
  expect_equal(
    get_y_data(input, df),
    df[,"control"]
  )
})


test_that("get_y_data: long_data true", {
  # create temporary data set
  path <- tempfile(fileext = ".csv")
  n <- 20
  df <- data.frame(
    control = rnorm(n),
    treatment = rnorm(n, mean = 0.8)
  )
  utils::write.csv(df, path, row.names = FALSE)
  # create user input
  input <- list(
    long_data = TRUE,
    y_name_long_true = "treatment"
  )
  # tests
  expect_equal(
    get_y_data(input, df),
    as.factor(df[,"treatment"])
  )
  input$y_name_long_true = "(None)"
  expect_error(
    get_y_data(input, df),
    "The 'Long Data Format' is selected"
  )
})

