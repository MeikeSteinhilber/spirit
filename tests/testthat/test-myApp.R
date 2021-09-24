test_that("myApp: snapshot", {
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  set.seed(333)

  path <- tempfile(pattern = "TEST-", fileext = ".png")
  app <- shinytest::ShinyDriver$new(myApp(ui, server))

  # Save screenshot to temporary file
  # Tab 1 ---
  app$takeScreenshot(path)
  expect_snapshot_file(path, "tab1_plot.png")
  # Tab 2 ---
  app$setInputs(tabs_id = "Test Specification")
  app$setInputs(mu = 2)
  app$setInputs(na_rm = FALSE)
  app$takeScreenshot(path)
  expect_snapshot_file(path, "tab2_plot.png")
  # app$listWidgets()
})
