test_that("server: ", {
  # create temporary data set
  testthat::local_edition(3)
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
    path_test <- tempfile(fileext = ".txt")
    write.csv(test, path_test, )
    
    path_expected <- tempfile(fileext = ".txt")
    expected <- sprtt::seq_ttest(
      df$control,
      df$treatment,
      d = 0.3
    )
    sink(path_expected)
    expected
    sink(file = NULL) # STOP sink
    # expected <- read.delim(file = path, as.is = character(), allowEscapes = TRUE)
    #test consistency
    expect_snapshot(test)
    #test expectations
    # expect_equal(test, expected)
    expect_output(test, )
    
  })
})
