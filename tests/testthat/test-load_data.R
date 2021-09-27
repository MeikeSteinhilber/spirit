# no data ----------------------------------------------------------------------
test_that("load_data: no data", {
  input <- list(
    upload = NULL,
    seperator = ",",
    load_example_data = FALSE
  )
  expect_equal(
    load_data(input),
    NULL
  )
})

# upload csv data --------------------------------------------------------------
test_that("load_data: upload data csv", {
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
    load_example_data = FALSE
  )
  # test
  expect_equal(
    load_data(input),
    df
  )
})

# examplary data selected ------------------------------------------------------
test_that("load_data: examplary data", {
  input <- list(
    upload = NULL,
    seperator = ",",
    load_example_data = TRUE,
    example_data = "df_stress"
  )
  expect_equal(
    load_data(input),
    sprtt::df_stress
  )
  input$example_data <- "df_cancer"
  expect_equal(
    load_data(input),
    sprtt::df_cancer
  )
  input$example_data <- "df_income"
  expect_equal(
    load_data(input),
    sprtt::df_income
  )
})
# multiple data sets -----------------------------------------------------------
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
    load_example_data = TRUE,
    example_data = "df_stress"
  )
  # test
  expect_equal(
    load_data(input),
    sprtt::df_stress
  )
})

# other data file formats ------------------------------------------------------
# THIS TESTS MAY BE DELETED -> same test on a lower level: load_data_frame
test_that("load_data: upload data txt", {
  # create temporary data set
  path <- tempfile(fileext = ".txt")
  n <- 20
  df <- data.frame(
    control = rnorm(n),
    treatment = rnorm(n, mean = 0.8)
  )
  utils::write.table(df, path, sep = ",", row.names = FALSE)
  # create user input
  input <- list(
    upload = list(datapath = path),
    seperator = ",",
    load_example_data = FALSE
  )
  # test
  expect_equal(
    load_data(input),
    df
  )
})

test_that("load_data: upload data xlsx", {
  # create temporary data set
  path <- tempfile(fileext = ".xlsx")
  n <- 20
  df <- data.frame(
    control = rnorm(n),
    treatment = rnorm(n, mean = 0.8)
  )
  writexl::write_xlsx(df, path)
  # create user input
  input <- list(
    upload = list(datapath = path),
    seperator = ",",
    load_example_data = FALSE
  )
  # test
  expect_equal(
    load_data(input),
    df
  )
})