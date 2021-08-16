library(shiny)
library(dplyr)
library(tools)
library(readxl)
library(bslib)
# Help Functions ---------------------------------------------------------------
# look at R/ Folder

get_colum_names <- function(input) {
    data <- load_data(input)
    names <- colnames(data)
    names
}


# Define UI --------------------------------------------------------------------
ui <- fluidPage(
    # Application title
    titlePanel("Sequential t-tests"),
    
    tabsetPanel( 
        # 1. Panel -------------------------------------------------------------
        tabPanel(
            "Data"
            , br()
            , fluidRow(
                column(4,
                    "Please upload a data file or use the given examplary data
                       frames."
                       ),
                column(3, checkboxInput("load_example_data", "Load Examplary Data", value = FALSE))
            )
            , sidebarLayout(
                sidebarPanel(
                    fileInput("upload"
                              , "Upload File (.csv, .xlsx, .txt)"
                              , accept = ".csv, .xlsx, .txt"
                    ),
                    checkboxInput("header", "Header", value = TRUE),
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

                    hr(),
                    checkboxInput("na.rm", "Remove Missing Values", value = TRUE),
                    checkboxInput("N_reduction", "Reduce the Sample Size", value = FALSE),
                    conditionalPanel(
                        condition = "input.N_reduction == true",
                        sliderInput("N",
                                    "Sample Size:",
                                    min = 2,
                                    max = 200,
                                    value = 3)
                    ),
                    checkboxInput("long_data", "Long Data Format", value = FALSE),
                    conditionalPanel(
                        condition = "input.long_data == false",
                        numericInput("x_group_long_false"
                                     , "Column Number of Group 1 (Data x)"
                                     , value = NULL),
                        numericInput("y_group_long_false"
                                     , "Column Number of Group 2 (Data y)"
                                     , value = NULL),
                    ),
                    conditionalPanel(
                        condition = "input.long_data == true",
                        numericInput("x_group_long_true"
                                     , "Column Number of x (numeric variable)"
                                     , value = NULL),
                        numericInput("y_group_long_true"
                                     , "Column Number of y (factor variable)"
                                     , value = NULL),
                        
                    ),
                    
                ),
                
                # Show test results and the data
                mainPanel(
                    conditionalPanel(
                        condition = "input.load_example_data == true",
                        radioButtons(
                            "example_data"
                            , "Select Data Frame"
                            , choices = list("df_cancer", "df_stress", "df_income")
                        )
                    ),
                    checkboxInput("display_data", "Show Data Table", value = TRUE),
                    checkboxInput("id", "Add Row Numbers (ID)", value = FALSE),
                    conditionalPanel(
                        condition = "input.display_data == true",
                        dataTableOutput("data")
                    )
                )
            )
        )
        # 2. Panel -------------------------------------------------------------
        , tabPanel(
            "Test Specification"
            , br()
            , "contents"
            , br()
            , br()
            , sidebarLayout(
                sidebarPanel(
                    checkboxInput("paired", "Paired Data (Repeated Measures)"),
                    sliderInput("d",
                                "Cohen's d:",
                                min = 0,
                                max = 1,
                                value = 0.3,
                                step = 0.05
                    ),
                    numericInput("mu", "Mean", value = 0),
                    numericInput("alpha", "Alpha", value = 0.05, min = 0, max = 1, step = 0.01),
                    numericInput("power", "Power", value = 0.95, min = 0, max = 1, step = 0.01),
                    radioButtons("alternative"
                                 , "Specification of the Alternative Hypothesis"
                                 , choices = list(
                                     "two-sided" = "two.sided"
                                    , "greater (one-sided)" = "greater"
                                    , "less (one-sided)" = "less"
                                )
                    ),
                ),
                
                # Show test results and the data
                mainPanel(
                    checkboxInput("verbose", "Verbose Output", value = TRUE),
                    verbatimTextOutput("seq_ttest_results")
                )
            )
        ) 
    )
)


# Define server ----------------------------------------------------------------
server <- function(input, output) {
    # Allow upload files with 10 MB
    options(shiny.maxRequestSize = 10 * 1024^2)
    
    reactive({
        # req(input$upload)
        # req(input$x_group)
        # req(input$y_group)
    })

    output$data <- renderDataTable({
        preprocess_data(input)
    })
    
    output$seq_ttest_results <- renderPrint({
        data <- preprocess_data(input)

        if (input$long_data == TRUE) {
            x <- data[, input$x_group_long_true]
            y <- as.factor(data[, input$y_group_long_true])
            sprtt::seq_ttest(x ~ y
                             , data = data
                             , mu = input$mu
                             , d = input$d
                             , paired = input$paired
                             , alternative = input$alternative
                             , na.rm = input$na.rm
                             , verbose = input$verbose
            )
        } else if ((input$long_data == FALSE)) {
            x <- data[, input$x_group_long_false]
            
            if (!is.na(input$y_group_long_false)) {
                y <- data[, input$y_group_long_false]
            } else{
                y <- NULL
            }
            sprtt::seq_ttest(x = x
                             , y = y
                             , mu = input$mu
                             , d = input$d
                             , paired = input$paired
                             , alternative = input$alternative
                             , na.rm = input$na.rm
                             , verbose = input$verbose
            )
        }
    })
}

# Run the application ----------------------------------------------------------
shinyApp(ui = ui, server = server)


