library(shiny)
library(gapminder)
library(ggplot2)
library(dplyr)
library(plotly)

ui <- fluidPage(
  fluidRow(
    column(3,
           selectInput(inputId = "continente",
                       label = "Escolha o Continente:",
                       choices = unique(gapminder$continent)),
           selectInput(inputId = "variavel",
                       label = "Escolha a variável",
                       choices = c("lifeExp", "pop", "gdpPercap"))),
    column(9,
           plotlyOutput(outputId = "grafico"))
  )
)

server <- function(input, output, session){
  output$grafico <- renderPlotly({
    a <- gapminder %>%
      filter(continent == input$continente) %>%
      ggplot(aes_string(x = "year", y = input$variavel, 
                        color = "country")) +
      geom_line()
    ggplotly(a)
  })
}

shinyApp(ui, server)