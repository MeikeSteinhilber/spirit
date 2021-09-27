test_that("myApp: snapshot", {
  skip_on_cran() # skip on CRAN checks
  skip_on_ci() # skip on continuous platforms like GitHub Actions
  skip("weird error message") # skip test
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  set.seed(333)

  path <- tempfile(pattern = "TEST-", fileext = ".png")
  app <- shinytest::ShinyDriver$new(myApp(ui, server))

  # Save screenshot to temporary file
  # Tab 1 ---
  app$takeScreenshot(path)
  testthat::expect_snapshot_file(path, "tab1_plot.png")
  # Tab 2 ---
  # app$setInputs(tabs_id = "Test Specification")
  # app$setInputs(mu = 2)
  # app$setInputs(na_rm = FALSE)
  # app$takeScreenshot(path)
  # testthat::expect_snapshot_file(path,
  #                                "tab2_plot.png",
  #                                compare = "compare_file_text"
  #                                )
  # app$listWidgets()
})
