tab_1 <- tabPanel(
  title = "Select Data"
  , value = "tab_1"
  , br()
  , fluidRow(
    column(4,
           "Upload a data file or use the given examplary data
                       frames."
           , checkboxInput("load_example_data", "Load Examplary Data", value = FALSE)
    ),
    column(3, 
           conditionalPanel(
             condition = "input.load_example_data == true",
             radioButtons(
               "example_data"
               , "Select Data Frame"
               , choices = list("df_cancer", "df_stress", "df_income")
             )
           )
    )
  )
  , sidebarLayout(
    sidebarPanel(
      fileInput("upload"
                , "Upload File (.csv, .xlsx, .txt)"
                , accept = ".csv, .xlsx, .txt"
      ),
      radioButtons(
        "seperator"
        , "Select Seperator String"
        , choices = list(
          "Semicolon" = ";"
          , "Empty Space" = ""
          , "Tab" = "\t"
          , "Comma" = ","
        )
      ),
      "Specify the variables for the test by the
                    column name and adjust the data format, if necessary.",
      checkboxInput("long_data", "Long Data Format", value = FALSE),
      conditionalPanel(
        condition = "input.long_data == false"
        , selectInput("x_name_long_false"
                      , "Colum Name of Group 1 (numeric variable)"
                      , choices = ""
        )
        , selectInput("y_name_long_false"
                      , "Colum Name of Group 2 (numeric variable)"
                      , choices = ""
        )
      ),
      conditionalPanel(
        condition = "input.long_data == true"
        , selectInput("x_name_long_true"
                      , "Colum Name of of x (numeric variable)"
                      , choices = ""
        )
        , selectInput("y_name_long_true"
                      , "Colum Name of y (factor variable)"
                      , choices = ""
        )
      ),
      checkboxInput("na_rm", "Remove Missing Values", value = TRUE),
      checkboxInput("N_reduction", "Reduce the Sample Size", value = FALSE),
      conditionalPanel(
        condition = "input.N_reduction == true", 
        numericInput("N", "Number of Rows", value = 2)
      )
    ),
    # Show test results and the data
    mainPanel(
      checkboxInput("display_data", "Show Data Table", value = TRUE),
      checkboxInput("id", "Add Row Numbers (ID)", value = FALSE),
      conditionalPanel(
        condition = "input.display_data == true",
        dataTableOutput("data")
      )
    )
  )
)
