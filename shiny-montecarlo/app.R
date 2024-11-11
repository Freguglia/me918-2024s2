library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  
  titlePanel("Estimação Monte-Carlo"),
  
  tabsetPanel(
    tabPanel("Graficos",
             sidebarLayout(
               sidebarPanel(
                 numericInput("n_amostra",
                              "Número de amostras a serem geradas:",
                              value = 10000),
                 radioButtons("tipo_grafico", label = "Tipo de gráfico",
                              choices = c("Convergência", "Pontos"))
               ),
               
               mainPanel(
                 textOutput("texto_estimado"),
                 plotOutput("grafico_circ")
               )
             )
    ),
    tabPanel("Tabela",
             DT::DTOutput("tabela_estimativas"))
  )
  
)

server <- function(input, output, session) {
  amostra <- reactive({
    tabela <- data.frame(x = runif(input$n_amostra), 
                         y = runif(input$n_amostra))
    escrever <- data.frame(est = 4*mean((tabela$x^2 + tabela$y^2) <1),
                           n = input$n_amostra)
    readr::write_csv(escrever, file = "registro.csv", append = TRUE)
    tabela})
  
  output$texto_estimado <- renderText({
    dentro <- (amostra()$x^2 + amostra()$y^2)<1
    paste0("A estimativa de pi é ", mean(dentro*4))
  })
  
  output$grafico_circ <- renderPlot({
    if(input$tipo_grafico == "Pontos"){
      amostra() |>
        mutate(dentro = (x^2 + y^2)<1) |>
        ggplot(aes(x = x, y = y, color = dentro)) + geom_point()
    } else {
      tabela <- data.frame(t = seq_len(nrow(amostra())),
                           media_ac = 4*cumsum((amostra()$x^2 + amostra()$y^2) <1)/seq_len(nrow(amostra())))
      
      tabela |>  ggplot(aes(x = t, y = media_ac)) + geom_line() + 
        geom_hline(yintercept = pi, color = "red") +
        ylim(3, 3.2)
    }
  })
  
  fileData <- reactiveFileReader(1000, session, "registro.csv", 
                                 readr::read_csv)
  output$tabela_estimativas <- DT::renderDT({
    fileData()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
