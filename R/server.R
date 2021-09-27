server <- function(input, output, session) {
  # allow upload files with max 10 MB
  # options(shiny.maxRequestSize = 10 * 1024^2)
  
  # create text for the UI
  
  output$description_text <- renderUI({
    tagList(
      "This is the web shiny app to the",
      a("sprtt", href = "https://meikesteinhilber.github.io/sprtt/"),
      "package on CRAN."
    )
  })
  
  output$developer_information_text <- renderUI({
    tagList(
      "Developed by",
      a("Meike Steinhilber", href = "https://methoden.amd.psychologie.uni-mainz.de/steinhilber/"),
      " (2021)",
      br(),
    a(img(src = "github.png", height = 31, width = 31), href = "https://github.com/MeikeSteinhilber"),
    a(img(src = "twitter.png", height = 27, width = 27), href = "https://twitter.com/M_Steinhilber")
    )
  })
  
  # output$github_pic <- renderImage({
  #   list(src = "github.png",
  #        contentType = 'image/png',
  #        width = 30,
  #        height = 30,
  #        alt = "This is alternate text")
  # }, deleteFile=FALSE)

  # output$tooltips <- renderUI({
  #   tagList(
  #     bsTooltip("na_rm", title = "Test", placement = "top")
  #   )
  # })
  
  # create data() function
  data <- reactive({
    preprocess_data(input)
  })
  
  # input options that could change column names
  observe_colnames <- reactive({
    list(input$upload
         , input$seperator
         , input$id
         , input$load_example_data
         , input$example_data
    )
  })
  # updates the column names, if they could have changed
  observeEvent(
    observe_colnames(), {
      colnames <- c("(None)", colnames(data()))
      updateSelectInput(session, "x_name_long_false", choices = colnames)
      updateSelectInput(session, "y_name_long_false", choices = colnames)
      updateSelectInput(session, "x_name_long_true", choices = colnames)
      updateSelectInput(session, "y_name_long_true", choices = colnames)
    }
  )
  # data as output
  output$data <- renderDataTable({
    data()
  })
  
  # performs the sequential t-test
  output$seq_ttest_results <- renderPrint({
    data <- data()
    calc_seq_ttest(input, data)
  })
}