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
                    hr(),
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
                    "Please specify the variables for the test by the
                    column name and adjust the data format, if necessary."
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
                    verbatimTextOutput("seq_ttest_results"),
                    dataTableOutput("test")
                )
            )
        ) 
    )
)


# Define server ----------------------------------------------------------------
server <- function(session, input, output) {
    # Allow upload files with 10 MB
    options(shiny.maxRequestSize = 10 * 1024^2)
    
    data <- reactive({
        preprocess_data(input)
    })
    
    observe_colnames <- reactive({
        list(input$upload
             , input$seperator
             , input$id
             , input$load_example_data
             , input$example_data
        )
    })

    observeEvent(
        observe_colnames() 
        , { colnames <- c("(None)", colnames(data()))
            updateSelectInput(session, "x_name_long_false", choices = colnames)
            updateSelectInput(session, "y_name_long_false", choices = colnames)
            updateSelectInput(session, "x_name_long_true", choices = colnames)
            updateSelectInput(session, "y_name_long_true", choices = colnames)
        }
    )

    output$data <- renderDataTable({
        data()
    })
    
    output$seq_ttest_results <- renderPrint({
        data <- data()
        if (input$long_data == TRUE) {
            x <- get_x_data(input, data)
            y <- get_y_data(input, data)
            
            sprtt::seq_ttest(x ~ y
                             , data = data()
                             , mu = input$mu
                             , d = input$d
                             , paired = input$paired
                             , alternative = input$alternative
                             , na.rm = input$na.rm
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
                             , na.rm = input$na.rm
                             , verbose = input$verbose
            )
        }
    })
}

# Run the application ----------------------------------------------------------
shinyApp(ui = ui, server = server)


