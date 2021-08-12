load_data <- function(input) {
  if (is.null(input$upload) && input$load_example_data == FALSE) {
    return(NULL)
  } else if (!is.null(input$upload) && input$load_example_data == FALSE) {
    df <- read.csv(input$upload$datapath)
    if (input$N_reduction == TRUE) {
      df[1:input$N, ]
    } else{
      df
    }
  } else if (input$load_example_data == TRUE) {
    if (input$example_data == "df_stress") {
      # df <- read.csv("data/df_stress.csv")
      df <- sprtt::df_stress
      df
    } else if (input$example_data == "df_cancer") {
      # df <- read.csv("data/df_cancer.csv")
      df <- sprtt::df_cancer
      df
    } else if (input$example_data == "df_income") {
      # df <- read.csv("data/df_income.csv")
      df <- sprtt::df_income
      df
    }
  } else{
    return(NULL)
  }
}