# GENERAL SETTINGS -------------------------------------------------------------

  ## ERROR MESSAGES
  # show individual error message
  options(shiny.sanitize.errors = FALSE)

  ## DOCUMENTATION SETTINGS 
  #' @import shiny shinyBS tools bslib
  #' @importFrom utils read.csv
  #' @importFrom tibble tibble
  #' @importFrom writexl write_xlsx
  #' @importFrom shinyBS bsTooltip

# MAIN APP ---------------------------------------------------------------------

#' @title sprtt shiny app
#' @description Shiny weg app of the sprtt package to calculate sequential
#' t-tests.
#'
#' @param ... XXX
#'
#' @return Opens the Web App
#' @export
#'
myApp <- function(...) {
    shinyApp(ui = ui, server = server)
}


