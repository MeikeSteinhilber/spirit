preprocess_data <- function(input) {
  data <- load_data(input)
  
  # error handling: add ID without data -> ignore input
  if (is.null(data) && input$id == TRUE) {
    return(NULL)
  }
  
  data <- data_reduction(input, data)
  data <- add_id(input, data)
  data
}