load_data_frame <- function(input) {
  file_extension <- tools::file_ext(input$upload$datapath)
  
  if (file_extension == "csv") {
    data <- read.csv(input$upload$datapath
                     , sep = input$seperator
                     , header = TRUE
    )
  } else if (file_extension == "xlsx") {
    data <- readxl::read_excel(input$upload$datapath
                               , col_names = TRUE
    )
  }else if (file_extension == "txt") {
    data <- read.csv(input$upload$datapath
                     , sep = input$seperator
                     , header = TRUE
    )
  }
  as.data.frame(data)
}