library(shiny)
library(dplyr)
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
    
    # Data Input
    sidebarLayout(
        sidebarPanel(
            fileInput("upload"
                      , "Upload File"
                      , accept = ".csv, .rds"
            ),
            checkboxInput("load_example_data", "Load Examplary Data", value = FALSE),
            conditionalPanel(
                condition = "input.load_example_data == true",
                radioButtons(
                    "example_data"
                    , "Select Data Frame"
                    , choices = list("df_cancer", "df_stress", "df_income")
                )
            ),
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
            numericInput("x_group", "Column Number of Group 1 (Data x)", value = NULL),
            numericInput("y_group", "Column Number of Group 2 (Data y)", value = NULL),
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
                         , choices = list("two-sided" = "two.sided"
                                          , "greater (one-sided)" = "greater"
                                          , "less (one-sided)" = "less")),
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            checkboxInput("verbose", "Verbose Output", value = TRUE),
            verbatimTextOutput("seq_ttest_results"),
            checkboxInput("display_data", "Show Data Table", value = TRUE),
            checkboxInput("id", "Add Row Numbers (ID)", value = FALSE),
            conditionalPanel(
                condition = "input.display_data == true",
                dataTableOutput("data")
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
        # req(input$x_position)
        # req(input$y_position)
    })


    output$data <- renderDataTable({
        preprocess_data(input)
    })
    
    
    output$seq_ttest_results <- renderPrint({
        data <- preprocess_data(input)
        
        x <- data[, input$x_group]
        # x <- data %>% select(input$x_group)
        
        if (!is.na(input$y_group)) {
            y <- data[, input$y_group]
        } else{
            y <- NULL
        }
        
        # sprtt::seq_ttest(x = x, mu = 120, d = d)
        sprtt::seq_ttest(x = x
                         , y = y
                         , mu = input$mu
                         , d = input$d
                         , paired = input$paired
                         , alternative = input$alternative
                         , na.rm = input$na.rm
                         , verbose = input$verbose
        )
    })
}

# Run the application ----------------------------------------------------------
shinyApp(ui = ui, server = server)


