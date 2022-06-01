library(ggplot2)
library(plotly)
library(dplyr)
library(bslib)

covid_df <- read.csv("worldometer_coronavirus_summary_data.csv")
covid_daily_df <- read.csv("worldometer_coronavirus_daily_data.csv")

server <- function(input, output) {

  output$covid_plot <- renderPlotly({
    filtered_df <- covid_df %>%
      group_by(continent) %>%
      summarize(total_confirmed = mean(total_confirmed, na.rm = TRUE),
                total_deaths = mean(total_deaths, na.rm = TRUE), 
                total_recovered = mean(total_recovered, na.rm = TRUE),
                active_cases = mean(active_cases, na.rm = TRUE),
                serious_or_critical = mean(serious_or_critical, na.rm = TRUE))
   
       
covid_plot <-  ggplot(data = filtered_df) +
      geom_bar(mapping = aes(x= continent, y = .data[[input$user_selection]] / 100000), stat = "identity") +
       labs(title = "COVID Statistics by Continent", 
           x = "Continents", 
           y = "Number of People in Millions",
           color = "Legend Title")
    
    
    
    return(covid_plot)
  })
}

