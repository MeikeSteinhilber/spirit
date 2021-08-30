# CSV --------------------------------------------------------------------------
test_that("calc_seq_ttest: csv & longformat", {
  # create temporary data set
  path <- tempfile(fileext = ".csv")
  n <- 20
  df <- data.frame(
    stress = rnorm(n),
    treatment = as.factor(rep(c("control", "tretment"), n/2, ))
  )
  utils::write.csv(df, path, row.names = FALSE)
  input <- list(
    mu = 0,
    d = 0.3,
    paired = FALSE,
    alternative = "two.sided",
    alpha = 0.05,
    power = 0.95,
    na_rm = TRUE,
    verbose = TRUE
  )
  
  input$long_data <- TRUE
  input$x_name_long_true <- "stress"
  input$y_name_long_true <- "treatment"
  
  shiny_result <- calc_seq_ttest(input, df)
  sprtt_result <- sprtt::seq_ttest(stress~treatment,
                                   data = df,
                                   mu = input$mu,
                                   d = input$d
                  )
  shiny_result@data_name <- sprtt_result@data_name
  expect_equal(shiny_result, sprtt_result)
})

test_that("calc_seq_ttest: csv & wideformt", {
  # create temporary data set
  path <- tempfile(fileext = ".csv")
  n <- 20
  df <- data.frame(
    control = rnorm(n),
    treatment = rnorm(n)
  )
  utils::write.csv(df, path, row.names = FALSE)
  input <- list(
    mu = 0,
    d = 0.3,
    paired = FALSE,
    alternative = "two.sided",
    alpha = 0.05,
    power = 0.95,
    na_rm = TRUE,
    verbose = TRUE
  )
  
  input$long_data <- FALSE
  input$x_name_long_false <- "control"
  input$y_name_long_false <- "treatment"
  
  shiny_result <- calc_seq_ttest(input, df)
  sprtt_result <- sprtt::seq_ttest(df$control,
                                   df$treatment,
                                   mu = input$mu,
                                   d = input$d
  )
  shiny_result@data_name <- sprtt_result@data_name
  expect_equal(shiny_result, sprtt_result)
})

# txt --------------------------------------------------------------------------
test_that("calc_seq_ttest: txt & longformat", {
  # create temporary data set
  path <- tempfile(fileext = ".csv")
  n <- 20
  df <- data.frame(
    stress = rnorm(n),
    treatment = as.factor(rep(c("control", "tretment"), n/2, ))
  )
  utils::write.table(df, path, sep = ",", row.names = FALSE)
  input <- list(
    mu = 0,
    d = 0.3,
    paired = FALSE,
    alternative = "two.sided",
    alpha = 0.05,
    power = 0.95,
    na_rm = TRUE,
    verbose = TRUE
  )
  
  input$long_data <- TRUE
  input$x_name_long_true <- "stress"
  input$y_name_long_true <- "treatment"
  
  shiny_result <- calc_seq_ttest(input, df)
  sprtt_result <- sprtt::seq_ttest(stress~treatment,
                                   data = df,
                                   mu = input$mu,
                                   d = input$d
  )
  shiny_result@data_name <- sprtt_result@data_name
  expect_equal(shiny_result, sprtt_result)
})

test_that("calc_seq_ttest: txt & wideformt", {
  # create temporary data set
  path <- tempfile(fileext = ".csv")
  n <- 20
  df <- data.frame(
    control = rnorm(n),
    treatment = rnorm(n)
  )
  utils::write.table(df, path, sep = ",", row.names = FALSE)
  input <- list(
    mu = 0,
    d = 0.3,
    paired = FALSE,
    alternative = "two.sided",
    alpha = 0.05,
    power = 0.95,
    na_rm = TRUE,
    verbose = TRUE
  )
  
  input$long_data <- FALSE
  input$x_name_long_false <- "control"
  input$y_name_long_false <- "treatment"
  
  shiny_result <- calc_seq_ttest(input, df)
  sprtt_result <- sprtt::seq_ttest(df$control,
                                   df$treatment,
                                   mu = input$mu,
                                   d = input$d
  )
  shiny_result@data_name <- sprtt_result@data_name
  expect_equal(shiny_result, sprtt_result)
})

# xlsx -------------------------------------------------------------------------
test_that("calc_seq_ttest: xlsx & longformat", {
  # create temporary data set
  path <- tempfile(fileext = ".csv")
  n <- 20
  df <- data.frame(
    stress = rnorm(n),
    treatment = as.factor(rep(c("control", "tretment"), n/2, ))
  )
  writexl::write_xlsx(df, path)
  input <- list(
    mu = 0,
    d = 0.3,
    paired = FALSE,
    alternative = "two.sided",
    alpha = 0.05,
    power = 0.95,
    na_rm = TRUE,
    verbose = TRUE
  )
  
  input$long_data <- TRUE
  input$x_name_long_true <- "stress"
  input$y_name_long_true <- "treatment"
  
  shiny_result <- calc_seq_ttest(input, df)
  sprtt_result <- sprtt::seq_ttest(stress~treatment,
                                   data = df,
                                   mu = input$mu,
                                   d = input$d
  )
  shiny_result@data_name <- sprtt_result@data_name
  expect_equal(shiny_result, sprtt_result)
})

test_that("calc_seq_ttest: xlsx & wideformt", {
  # create temporary data set
  path <- tempfile(fileext = ".csv")
  n <- 20
  df <- data.frame(
    control = rnorm(n),
    treatment = rnorm(n)
  )
  writexl::write_xlsx(df, path)
  input <- list(
    mu = 0,
    d = 0.3,
    paired = FALSE,
    alternative = "two.sided",
    alpha = 0.05,
    power = 0.95,
    na_rm = TRUE,
    verbose = TRUE
  )
  
  input$long_data <- FALSE
  input$x_name_long_false <- "control"
  input$y_name_long_false <- "treatment"
  
  shiny_result <- calc_seq_ttest(input, df)
  sprtt_result <- sprtt::seq_ttest(df$control,
                                   df$treatment,
                                   mu = input$mu,
                                   d = input$d
  )
  shiny_result@data_name <- sprtt_result@data_name
  expect_equal(shiny_result, sprtt_result)
})

# No Data: Text  ---------------------------------------------------------------
test_that("calc_seq_ttest: no data selected -> show text", {
  df <- NULL
  input <- list(
    mu = 0,
    d = 0.3,
    paired = FALSE,
    alternative = "two.sided",
    alpha = 0.05,
    power = 0.95,
    na_rm = TRUE,
    verbose = TRUE
  )
  
  input$long_data <- FALSE
  input$x_name_long_false <- "control"
  input$y_name_long_false <- "treatment"

  expect_equal(
    calc_seq_ttest(input, df),
    cat("No data available.
        Upload you own data or select an examplary data set.")
  )
})
