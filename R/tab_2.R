tab_2 <- tabPanel(
  "Test Specification"
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