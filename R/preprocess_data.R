preprocess_data <- function(input) {
  data <- load_data(input)
  data <- data_reduction(input, data)
  data <- add_id(input, data)
  data
}