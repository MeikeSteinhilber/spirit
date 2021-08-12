add_id <- function(input, data) {
  if (input$id == TRUE) {
    ID <- 1:nrow(data)
    data <- data.frame(ID, data)
  }
  data
}