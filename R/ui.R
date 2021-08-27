ui <- function(request) {
  fluidPage(
    h1("Spirit"),
    strong("App to Calculate Sequential t-Tests"),
    uiOutput("description_text"),
    br(),
    tabsetPanel(
      tab_1,
      tab_2
    )
  )
}
