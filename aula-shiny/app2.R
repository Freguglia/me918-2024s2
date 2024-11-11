ui <- fluidPage(
  sliderInput(inputId = "n1", "n1", min = 5, max = 100,
              step = 1, value = 25),
  sliderInput(inputId = "n2", "n2", min = 5, max = 100,
              step = 1, value = 25),
  textInput(inputId = "titulo", label = "Titulo"),
  plotOutput(outputId = "histograma")
)

server <- function(input, output, session) {
  amostra <- reactive(rnorm(input$n1 + input$n2 ))
  output$histograma <- renderPlot({
    hist(amostra(), main = input$titulo)
  })
}

shinyApp(ui, server)