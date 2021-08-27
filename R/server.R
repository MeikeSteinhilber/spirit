server <- function(input, output, session) {
  # allow upload files with max 10 MB
  options(shiny.maxRequestSize = 10 * 1024^2)
  
  output$tooltips <- renderUI({
    tagList(
      bsTooltip("na_rm", title = "Test", placement = "top")
    )
  })
  
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