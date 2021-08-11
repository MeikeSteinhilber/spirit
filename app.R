library(shiny)

# Define UI --------------------------------------------------------------------
ui <- fluidPage(

    # Application title
    titlePanel("Sequential t-test example"),
    
    # Data Input
    sidebarLayout(
        sidebarPanel(
            fileInput("upload"
                      , "Select File"
                      , accept = ".csv, .rds"
            ),
            checkboxInput("na.rm", "remove missing values", value = TRUE),
            checkboxInput("N_reduction", "Reduce the sample size", value = FALSE),
            conditionalPanel(
                condition = "input.N_reduction == true",
                    sliderInput("N",
                                "Sample Size:",
                                min = 0,
                                max = 200,
                                value = 3)
            ),
            numericInput("x_position", "Column of group 1 (data x)", value = NULL),
            numericInput("y_position", "Column of group 2 (data y)", value = NULL),
            checkboxInput("paired", "paired data"),
            sliderInput("d",
                        "Cohen's d:",
                        min = 0,
                        max = 1,
                        value = 0.3,
                        step = 0.05
            ),
            numericInput("mu", "mean", value = 0),
            numericInput("alpha", "alpha", value = 0.05),
            numericInput("power", "power", value = 0.95),
            radioButtons("alternative"
                         , "specification of the alternative hypothesis"
                         , choices = list("two-sided" = "two.sided"
                                          , "greater (one-sided)" = "greater"
                                          , "less (one-sided)" = "less")),
        checkboxInput("verbose", "verbose output", value = TRUE),
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            verbatimTextOutput("seq_ttest_results"),
            dataTableOutput("data")
        )
    )
)

# Define server ----------------------------------------------------------------
server <- function(input, output) {
    # Allow upload files with 10 MB
    options(shiny.maxRequestSize = 10 * 1024^2)
    
    reactive({
        req(input$upload)
        req(input$x_position)
        req(input$y_position)
    })


    output$data <- renderDataTable({
        if (is.null(input$upload))
            return(NULL)
        
        # load(input$upload$datapath)
       df <- read.csv(input$upload$datapath)
       if (input$N_reduction == TRUE) {
           df[1:input$N, ]
       } else{
           df
       }
    })
    
    output$seq_ttest_results <- renderPrint({
        df <-  read.csv(input$upload$datapath)
        if (input$N_reduction == TRUE) {
            x <- df[1:input$N, input$x_position]
        } else{
            x <- df[ , input$x_position]
        }
        
        if (!is.na(input$y_position)) {
            if (input$N_reduction == TRUE) {
                y <- df[1:input$N, input$y_position]
            } else{
                y <- df[ , input$y_position]
            }
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
