calc_seq_ttest <- function(input, data) {
  if (is.null(data)) {
    cat("No data available. Upload you own data or select an examplary data set.")
  } else {
    if (input$long_data == TRUE) {
      x <- get_x_data(input, data)
      y <- get_y_data(input, data)
      
      sprtt::seq_ttest(x ~ y
                       , data = data()
                       , mu = input$mu
                       , d = input$d
                       , paired = input$paired
                       , alternative = input$alternative
                       , alpha = input$alpha
                       , power = input$power
                       , na.rm = input$na_rm
                       , verbose = input$verbose
      )
    } else if ((input$long_data == FALSE)) {
      x <- get_x_data(input, data)
      y <- get_y_data(input, data)
      
      sprtt::seq_ttest(x = x
                       , y = y
                       , mu = input$mu
                       , d = input$d
                       , paired = input$paired
                       , alternative = input$alternative
                       , alpha = input$alpha
                       , power = input$power
                       , na.rm = input$na_rm
                       , verbose = input$verbose
      )
    }
  }
}