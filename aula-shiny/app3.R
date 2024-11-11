

ui <- fluidPage(
  sliderInput(inputId = "n", "n", min = 5, max = 100,
              step = 1, value = 25),
  plotOutput(outputId = "histograma"),
  plotOutput(outputId = "densidade")
)

server <- function(input, output, session) {
  amostra <- reactive(rnorm(input$n))
  output$histograma <- renderPlot({
    hist(amostra())
  })
  output$densidade <- renderPlot({
    plot(density(amostra()))
  })
}

shinyApp(ui, server)

