ui <- fluidPage(
  sliderInput(inputId = "n", "n", min = 5, max = 100,
              step = 1, value = 25),
  actionButton(inputId = "botao", label = "Reamostrar"),
  plotOutput(outputId = "histograma")
)

server <- function(input, output, session) {
  amostra <- eventReactive(c(input$botao, input$n), {
    rnorm(input$n)
  })
  output$histograma <- renderPlot({
    hist(amostra())
  })
}

shinyApp(ui, server)