# TEST 1 -----------------------------------------------------------------------
test_that("server: test 1", {
  # create temporary data set
  set.seed(333)
  n <- 20
  df <- data.frame(
    control = rnorm(n),
    treatment = rnorm(n, mean = 0.8)
  )
  path <- tempfile(fileext = ".csv")
  utils::write.csv(df, path, row.names = FALSE)
  testServer(server, {
    session$setInputs(
      upload = list(datapath = path),
      seperator = ",",
      load_example_data = FALSE,
      N_reduction = FALSE,
      long_data = FALSE,
      x_name_long_false = "control",
      y_name_long_false = "treatment",
      N = NULL,
      id = FALSE,
      mu = 0,
      d = 0.3,
      paired = FALSE,
      alternative = "two.sided",
      alpha = 0.05,
      power = 0.95,
      na_rm = TRUE,
      verbose = TRUE
    )
    test <- output$seq_ttest_results
    
    path_expected <- tempfile(fileext = ".txt")
    sink(path_expected)
    sprtt::seq_ttest(
      df$control,
      df$treatment,
      d = 0.3
    )
    sink(file = NULL) # STOP sink
    expected <- scan(file = path_expected, what = character(), sep = NULL)
    #test consistency
    expect_snapshot(test)
    #test expectations
    testthat::local_edition(2)
    expect_known_output(test, path_expected)
    testthat::local_edition(3)
    expect_snapshot_output(test, cran = FALSE)
    
  })
})

# TEST 2 -----------------------------------------------------------------------
test_that("server: test 2", {
  # create temporary data set
  set.seed(333)
  n <- 40
  df <- data.frame(
    control = rnorm(n),
    treatment = rnorm(n, mean = 0.3)
  )
  path <- tempfile(fileext = ".csv")
  utils::write.csv(df, path, row.names = FALSE)
  testServer(server, {
    session$setInputs(
      upload = list(datapath = path),
      seperator = ",",
      load_example_data = FALSE,
      N_reduction = FALSE,
      long_data = FALSE,
      x_name_long_false = "control",
      y_name_long_false = "treatment",
      N = NULL,
      id = FALSE,
      mu = 1,
      d = 0.2,
      paired = FALSE,
      alternative = "less",
      alpha = 0.05,
      power = 0.95,
      na_rm = TRUE,
      verbose = TRUE
    )
    test <- output$seq_ttest_results
    
    path_expected <- tempfile(fileext = ".txt")
    sink(path_expected)
    sprtt::seq_ttest(
      df$control,
      df$treatment,
      d = 0.2,
      mu = 1,
      alternative = "less"
    )
    sink(file = NULL) # STOP sink
    expected <- scan(file = path_expected, what = character(), sep = NULL)
    #test consistency
    expect_snapshot(test)
    #test expectations
    testthat::local_edition(2)
    expect_known_output(test, path_expected)
    testthat::local_edition(3)
    expect_snapshot_output(test, cran = FALSE)
    
  })
})

# TEST 3 only Snapshots---------------------------------------------------------
test_that("server: test 3 (only snapshots)", {
  # create temporary data set
  set.seed(333)
  df <- data.frame(
    gender = as.factor(rep(c("w", "m"), 15)),
    income = rnorm(30, mean = 3.000)
  )
  path <- tempfile(fileext = ".csv")
  utils::write.csv(df, path, row.names = FALSE)
  testServer(server, {
    session$setInputs(
      upload = list(datapath = path),
      seperator = ",",
      load_example_data = FALSE,
      N_reduction = FALSE,
      long_data = TRUE,
      x_name_long_true = "income",
      y_name_long_true = "gender",
      N = NULL,
      id = FALSE,
      mu = 0,
      d = 0.2,
      paired = FALSE,
      alternative = "two.sided",
      alpha = 0.05,
      power = 0.95,
      na_rm = TRUE,
      verbose = TRUE
    )
    test <- output$seq_ttest_results
    #test consistency
    expect_snapshot(test)
  })
})
