get_x_data <- function(input, data) {
  if (input$long_data == FALSE) {
    data[, input$x_name_long_false]
  } else if (input$long_data == TRUE) {
    data[, input$x_name_long_true]
  }
}

get_y_data <- function(input, data) {
  if (input$long_data == FALSE) {
    if (input$y_name_long_false == "(None)") {
      NULL
    } else{
      data[, input$y_name_long_false]

    }
    
  } else if (input$long_data == TRUE) {
    as.factor(data[, input$y_name_long_true])
  }
}