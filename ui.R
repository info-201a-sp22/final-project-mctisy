library(plotly)
library(bslib)
library("htmlwidgets")
library("DT")
library("markdown")

covid_df <- read.csv("worldometer_coronavirus_summary_data.csv")
covid_daily_df <- read.csv("worldometer_coronavirus_daily_data.csv")

features <- c("total confirmed", "total deaths", "total recovered", 
              "active cases", "serious or critical")

############ Beautification and CSS formating
my_theme <- bs_theme(
  bg = "#faf7f8",
  fg = "#4a3a40",
  primary = "#87495f"
) %>% bs_add_rules(sass::sass_file("my_style.scss"))


############


sidebar_panel_widget <- sidebarPanel(
  selectInput(
    inputId = "user_selection",
    label = "COVID-19 Stat Option",
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

############

sidebar_panel_widget2 <- sidebarPanel(
  selectInput(
    inputId = "country_selection",
    label = "Select a Country",
    choices = covid_df$country,
    selected = "USA")
)

main_panel_plot2 <- mainPanel(
  plotlyOutput(outputId = "covid_tracker"),
  p("This chart attempts to clearly display trends regarding the number of 
    daily new COVID-19 cases in each country. By allowing the user to select 
    any country, they can easily compare and contrast the effects of COVID-19 
    on different places across the globe over time.")
)


############ Tabpanels
intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    includeMarkdown("introductory.md")
  )
)

page_1 <- tabPanel(
  "COVID-19 Stats by Continent",
  sidebarLayout(
    sidebar_panel_widget,
    main_panel_plot,
  ),
)

page_2 <- tabPanel(
  "COVID-19 New Cases Tracker by Country",
  sidebarLayout(
    sidebar_panel_widget2,
    main_panel_plot2,
  ),
)

summary_tab <- tabPanel(
  "Summary Page",
  fluidPage(
    h1("Summary"),
    h3("Takeaway #1"),
    p("As you can see from the COVID-19 stats by continent, Africa and
    Australia/Oceania were affected by COVID-19 the least. They had the least
    deaths, confirmed cases, critical cases, and active cashes. On the other
    hand, South America and Europe were affected the most by having the most
    deaths, active cases, confirmed cases, and critical cases. With each feature
    you can predict insights that could potentially explain what was going on
    with each country. For example, the high active cases within Europe could
    indicate that there were not enough regulations and traveling restrictions.
    Meanwhile, a high total death count and critical personnel in South America
    could show a lack of medical attention or technological advancements."),
    h3("Takeaway #2"),
    p("Upon observing various countries through the new COVID-19 cases tracker, 
      a clear pattern emerges of many countries' largest spike in daily new 
      cases occuring around the end of 2021 and beginning of 2022--the height 
      of the Omicron variant. This can be seen across many countries, for 
      instance in Slovenia, daily new cases never eclipsed 5000 until the 
      Omicron variant in early 2022, when they surpassed even 20000 daily new 
      cases. Monitoring the trends of when these spikes occur can allow us to
      detect new variants of the disease, like Omicron, and further understand
      what causes COVID-19 to spread faster--ultimately allowing us to stay
      better protected and work towards a post-COVID world."),
    h3("Takeaway #3"),
  )
)
############

ui <- navbarPage(
  "Worldwide COVID-19 Statistics",
  intro_tab,
  page_1,
  page_2,
  theme = my_theme,
  summary_tab
)
