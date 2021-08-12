data_reduction <- function(input, data) {
  if (input$N_reduction == TRUE) {
    data <- data[1:input$N, ]
  }
  data
}