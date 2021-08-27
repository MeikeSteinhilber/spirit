load_data <- function(input) {
  if (is.null(input$upload) && input$load_example_data == FALSE) {
    return(NULL)
    
  } else if (!is.null(input$upload) && input$load_example_data == FALSE) {
    load_data_frame(input)

  } else if (input$load_example_data == TRUE) {
    if (input$example_data == "df_stress") {
      sprtt::df_stress
    } else if (input$example_data == "df_cancer") {
      sprtt::df_cancer
    } else if (input$example_data == "df_income") {
      sprtt::df_income
    }
  }
}