

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Sequential t-test example"),
    
    
    # Data Input
    sidebarLayout(
        sidebarPanel(
            fileInput("upload"
                      , "Select File"
                      , accept = ".csv, .rds"
                     )
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            verbatimTextOutput("seq_ttest_results")
        )
    ),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("N",
                        "Sample Size:",
                        min = 1,
                        max = 50,
                        value = 120)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            dataTableOutput("data")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    # Allow upload files with 10 MB
    options(shiny.maxRequestSize = 10 * 1024^2)
    
    reactive({
        req(input$upload)
    })

    output$data <- renderDataTable({
        
        if (is.null(input$upload))
            return(NULL)
        
        # load(input$upload$datapath)
       df <- read.csv(input$upload$datapath)
       df[1:input$N, ]
    })
    
    set.seed(333)
    output$seq_ttest_results <- renderPrint({
        # x <- rnorm(input$N, mean = 110, sd = 15)
        df <-  read.csv(input$upload$datapath)
        x <- df[1:input$N, 3]
        d <- 0.30
        
        # sprtt::seq_ttest(x = x, mu = 120, d = d)
        sprtt::seq_ttest(x = x , mu = 7, d = d)
    })
    

}

# Run the application 
shinyApp(ui = ui, server = server)
