test_that("load_data_frame: check input csv", {
  path <- tempfile(fileext = ".csv")
  n <- 20
  df <- data.frame(
    control = rnorm(n),
    treatment = rnorm(n, mean = 0.8)
  )
  utils::write.csv(df, path, row.names = FALSE)
  input <- list(
    upload = list(datapath = path),
    seperator = ",",
    header = TRUE
  )
  expect_equal(load_data_frame(input), df)
})

test_that("load_data_frame: check input xlsx", {
  path <- tempfile(fileext = ".xlsx")
  n <- 20
  df <- data.frame(
    control = rnorm(n),
    treatment = rnorm(n, mean = 0.8)
  )
  writexl::write_xlsx(df, path)
  input <- list(
    upload = list(datapath = path),
    seperator = ",",
    header = TRUE
  )
  expect_equal(load_data_frame(input), df)
})

test_that("load_data_frame: check input txt", {
  path <- tempfile(fileext = ".txt")
  n <- 20
  df <- data.frame(
    control = rnorm(n),
    treatment = rnorm(n, mean = 0.8)
  )
  utils::write.table(df, path, sep = "\t", col.names = TRUE, row.names = FALSE)
  input <- list(
    upload = list(datapath = path),
    seperator = "\t",
    header = TRUE
  )
  expect_equal(load_data_frame(input), df)
})
