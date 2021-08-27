test_that("preprocess_data: uploaded data", {
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
    load_example_data = FALSE,
    N_reduction = FALSE,
    N = NULL,
    id = FALSE
  )
  # test
  expect_equal(
    preprocess_data(input),
    df
  )
})

test_that("preprocess_data: ID no syst. crash", {
  # create user input
  input <- list(
    upload = NULL,
    seperator = ",",
    header = TRUE,
    load_example_data = FALSE,
    N_reduction = FALSE,
    N = NULL,
    id = TRUE
  )
  # test
  expect_equal(
    preprocess_data(input),
    NULL
  )
})

test_that("preprocess_data: add ID", {
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
    load_example_data = FALSE,
    N_reduction = FALSE,
    N = NULL,
    id = TRUE
  )
  ID <- 1:nrow(df)
  # test
  expect_equal(
    preprocess_data(input),
    data.frame(ID, df)
  )
})

test_that("preprocess_data: reduce data", {
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
    load_example_data = FALSE,
    N_reduction = TRUE,
    N = 10,
    id = FALSE
  )
  # test
  expect_equal(
    preprocess_data(input),
    df[1:10, ]
  )
})