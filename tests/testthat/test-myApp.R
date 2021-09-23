test_that("myApp: snapshot", {
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  set.seed(4657)
  
  path <- tempfile()
  app <- shinytest::ShinyDriver$new(myApp(ui, server))
  
  # Save screenshot to temporary file
  app$takeScreenshot(path, "plot")
  # 
  expect_snapshot_file(path, "plot-init.png")
  
  app$setValue(x = 2)
  app$takeScreenshot(path, "plot")
  expect_snapshot_file(path, "plot-update.png")

})
