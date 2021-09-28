ui <- function(request) {
  fluidPage(
    uiOutput("title_logo"),
    strong("App to Calculate Sequential t-Tests"),
    uiOutput("description_text"),
    br(),
    tabsetPanel(
      id = "tabs_id",
      tab_1,
      tab_2
    ),
    uiOutput("developer_information_text"),
    br()
  )
}
