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
      summarize(
        total_confirmed = mean(total_confirmed, na.rm = TRUE),
        total_deaths = mean(total_deaths, na.rm = TRUE),
        total_recovered = mean(total_recovered, na.rm = TRUE),
        active_cases = mean(active_cases, na.rm = TRUE),
        serious_or_critical = mean(serious_or_critical, na.rm = TRUE)
      )

    covid_plot <- ggplot(data = filtered_df) +
      geom_bar(mapping = aes(x = continent, 
                             y = .data[[input$user_selection]] / 100000),
               stat = "identity") +
      labs(
        title = "COVID-19 Statistics by Continent",
        x = "Continents",
        y = "Number of People in Millions",
        color = "Legend Title"
      ) +
      theme_minimal()
    return(covid_plot)
  })

  output$covid_tracker <- renderPlotly({
      filtered_daily_df <- covid_daily_df %>%
        mutate(date = as.Date(date)) %>% 
        filter(country %in% input$country_selection)
      
      covid_tracker <- ggplot(data = filtered_daily_df, 
                              aes(x = date, y = daily_new_cases)) +
        geom_line() + labs(title = "COVID-19 Tracker by Country", x = "Date",
                           y = "Daily New Cases") + theme_minimal()
    return(covid_tracker)
  })
  
}
