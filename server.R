library(ggplot2)
library(plotly)
library(dplyr)
library(bslib)

covid_df <- read.csv("worldometer_coronavirus_summary_data.csv")
covid_daily_df <- read.csv("worldometer_coronavirus_daily_data.csv")

filter_df <- covid_daily_df %>% filter(date %in%  c("2021-1-01", "2021-2-01", "2021-3-01", "2021-4-01", "2021-5-01",
                     "2021-6-01", "2021-7-01", "2021-8-01", "2021-9-01", "2021-10-01",
                     "2021-11-01", "2021-12-01"))

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
<<<<<<< HEAD
  
  output$covid_country_plot <- renderPlotly({
    filter_df <- filter_df %>% filter(country %in% c(input$country_selection)) %>% group_by(country) 
    
    covid_plot_2 <- ggplot(data = filter_df) + geom_point(aes(x = date, y = daily_new_cases, color = country)) +
      scale_x_discrete(labels = c("2021-1-01" = "Jan 1", "2021-2-01" = "Feb 1", "2021-3-01" = "Mar 1",
                                  "2021-4-01" = "Apr 1", "2021-5-01" = "May 1", "2021-6-01" = "Jun 1",
                                  "2021-7-01" = "Jul 1", "2021-8-01" = "Aug 1", "2021-9-01" = "Sep 1",
                                  "2021-10-01" = "Oct 1", "2021-11-01" = "Nov 1", "2021-12-01" = "Dec 1")) + 
      labs(title = "Daily New Cases in World's Top Five Economies 2021", x = "Months (1st)", 
           y = "Daily New Cases", color = "Countries") + theme(legend.position = "right") + 
      theme(plot.title = element_text(hjust = 0.5)) 
    
    return(covid_plot_2)
=======

  output$covid_tracker <- renderPlotly({
      filtered_daily_df <- covid_daily_df %>%
        mutate(date = as.Date(date)) %>% 
        filter(country %in% input$country_selection)
      
      covid_tracker <- ggplot(data = filtered_daily_df, 
                              aes(x = date, y = daily_new_cases)) +
        geom_line() + labs(title = "COVID-19 Cases Tracker", x = "Date",
                           y = "Daily New Cases") + theme_minimal()
    return(covid_tracker)
>>>>>>> 4092722dad57243c4cf99f7118ebd5f21efbfb59
  })
  
}
