test_that("load_data: no data", {
  input <- list(
    upload = NULL,
    seperator = ",",
    header = TRUE,
    load_example_data = FALSE
  )
  expect_equal(
    load_data(input),
    NULL
  )
})

test_that("load_data: upload data", {
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
    upload = list(datapath = path),
    seperator = ",",
    header = TRUE,
    load_example_data = FALSE
  )
  # test
  expect_equal(
    load_data(input),
    df
  )
})

test_that("load_data: examplary data", {
  input <- list(
    upload = NULL,
    seperator = ",",
    header = TRUE,
    load_example_data = TRUE,
    example_data = "df_stress"
  )
  expect_equal(
    load_data(input),
    sprtt::df_stress
  )
})

test_that("load_data: upload data & select examle data", {
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
    upload = list(datapath = path),
    seperator = ",",
    header = TRUE,
    load_example_data = TRUE,
    example_data = "df_stress"
  )
  # test
  expect_equal(
    load_data(input),
    sprtt::df_stress
  )
})