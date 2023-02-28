library("tidyverse")
library("shiny")

homerange <- readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")

library(shiny)

ui <- fluidPage(
  radioButtons("x", "Select Fill Variable", choices = c("trophic.guild", "thermoregulation"), 
               selected = "trophic.guild"),
  plotOutput("plot", width="500px",height="400px")
  
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    ggplot(data=homerange, aes_string(x="locomotion", fill=input$x))+
      geom_bar(position = "dodge", color="black")+
      theme_light(base_size=18)+
      labs(x=NULL, y=NULL, title= "Distribution of Locomotion Sorted By")
  })
}

shinyApp(ui, server)