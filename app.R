# This file is necessary for the publication on shinyapps.io
# However, it is ignored for building the package
# pkgload::load_all(".")
# myApp()

library(shiny)
# ui <- fluidPage(
#   "Hello, world!"
# )
server <- function(input, output, session) {
}
shinyApp(ui, server)
