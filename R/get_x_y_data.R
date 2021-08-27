get_x_data <- function(input, data) {
  if (input$long_data == FALSE) {
    data <- data[, input$x_name_long_false]
  } else if (input$long_data == TRUE) {
    data <- data[, input$x_name_long_true]
  }
}

get_y_data <- function(input, data) {
  if (input$long_data == FALSE && input$y_name_long_false == "(None)") {
      NULL
  } else if (input$long_data == FALSE && input$y_name_long_false != "(None)") {
      data[, input$y_name_long_false]
  } else if (input$long_data == TRUE && input$y_name_long_true != "(None)") {
    as.factor(data[, input$y_name_long_true])
  } else if (input$long_data == TRUE && input$y_name_long_true == "(None)") {
    stop("The 'Long Data Format' is selected.
         Please select a column name for x and y."
    )
  }
}