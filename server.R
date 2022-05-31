library(ggplot2)
library(plotly)
library(dplyr)

covid_df <- read.csv("worldometer_coronavirus_summary_data.csv")
covid_daily_df <- read.csv("worldometer_coronavirus_daily_data.csv")

server <- function(input, output) {

  output$covid_plot <- renderPlotly({

    plot <- NULL

    return(plot)
  })

}
