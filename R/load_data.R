load_data_frame <- function(input) {
  file_extension <- file_ext(input$upload$datapath)
  
  if (file_extension == "csv") {
    data <- read.csv(input$upload$datapath
                     , sep = input$seperator
                     , header = input$header
            )
  # } else if (file_extension == "rda") {
  #   data <- load(input$upload$datapath)
  } else if (file_extension == "xlsx") {
    library(readxl)
    data <- read_excel(input$upload$datapath
                       , col_names = input$header
            )
  }else if (file_extension == "txt") {
    data <- read.csv(input$upload$datapath
                     , sep = input$seperator
                     , header = input$header
            )
  }
  data
}


load_data <- function(input) {
  if (is.null(input$upload) && input$load_example_data == FALSE) {
    return(NULL)
  } else if (!is.null(input$upload) && input$load_example_data == FALSE) {
    df <- load_data_frame(input)

    if (input$N_reduction == TRUE) {
      df[1:input$N, ]
    } else{
      df
    }
  } else if (input$load_example_data == TRUE) {
    if (input$example_data == "df_stress") {
      df <- sprtt::df_stress
      df
    } else if (input$example_data == "df_cancer") {
      df <- sprtt::df_cancer
      df
    } else if (input$example_data == "df_income") {
      df <- sprtt::df_income
      df
    }
  } else{
    return(NULL)
  }
}