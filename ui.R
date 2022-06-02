library(plotly)
library(bslib)
library("htmlwidgets")
library("DT")

covid_df <- read.csv("worldometer_coronavirus_summary_data.csv")
covid_daily_df <- read.csv("worldometer_coronavirus_daily_data.csv")

features <- c("total confirmed", "total deaths", "total recovered", "active cases", "serious or critical")

my_theme <- bs_theme(
  bg = "#faf7f8",
  fg = "#4a3a40",
  primary = "#87495f"
)

sidebar_panel_widget <- sidebarPanel(
  selectInput(
    inputId = "user_selection",
    label = "COVID Stat Option",
    choices = c(
      "Total Confirmed" = "total_confirmed",
      "Total Deaths" = "total_deaths",
      "Total Recovered" = "total_recovered",
      "Active Cases" = "active_cases",
      "Serious or Critical" = "serious_or_critical"
    ),
    selected = "United States"
  )
)

main_panel_plot <- mainPanel(
  plotlyOutput(outputId = "covid_plot"),
  p("This plot attempts to show how each continent is affected by COVID-19
    differently. It shows different stats like deaths, recoveries, new cases,
    critical conditions and total cases and compares it with the other
    continents.")
)

############ Tabpanels
intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    includeMarkdown("introductory.md")
  )
)

page_1 <- tabPanel(
  "Covid Stats by Continent",
  sidebarLayout(
    sidebar_panel_widget,
    main_panel_plot,
  ),
)

summary_tab <- tabPanel(
  "Summary Page",
  fluidPage(
    h1("Summary"),
    h3("Summary Takeaway 1"),
    p("As you can see from the Covid stats by continent, Africa and
    Australia/Oceania were affected by COVID-19 the least. They had the least
    deaths, confirmed cases, critical cases, and active cashes. On the other
    hand, South America and Europe were affected the most by having the most
    deaths, active cases, confirmed cases, and critical cases. With each feature
    you can predict insights that could potentially explain what was going on
    with each country. For example, the high active cases within Europe could
    indicate that there were not enough regulations and traveling restrictions.
    Meanwhile, a high total death count and critical personnel in South America
    could show a lack of medical attention or technological advancements."),
    h3("Summary Takeaway 2"),
    h3("Summary Takeaway 3"),
  )
)
############

ui <- navbarPage(
  "Worldwide COVID-19 Statistics",
  intro_tab,
  page_1,
  theme = my_theme,
  summary_tab
)
