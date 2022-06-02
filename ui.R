library(plotly)
library(bslib)
library("htmlwidgets")
library("markdown")

covid_df <- read.csv("worldometer_coronavirus_summary_data.csv")
covid_daily_df <- read.csv("worldometer_coronavirus_daily_data.csv")

features <- c("total confirmed", "total deaths", "total recovered", "active cases", "serious or critical")

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
    h3("Takeaway #1"),
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
    h3("Takeaway #2"),
    h3("Takeaway #3"),
    p("From the chart, it is quite clear to see that the inflection points and the 
    trends of the epidemic situation in each country are not exactly the same. To be 
    more specific, China and Germany both reached the peak in December (about 113 and 71887),
    while Japan reached the peak in September (about 18797). The daily change in the UK
    is relatively more complex: it experienced a sharp drop from January to February, but 
    rebounded from July and reached the peak in December as well. Among them, the number of
    daily increase cases in the United States is much higher than that in other countries
    (even larger than the sum). The most important insight from my analysis is China's 'case
    cleraing' epidemic prevention policy makes their overall cases and daily new increase far 
    lower than that of other countries. When we point to other countries, all points in China
    seem to be on the coordinate axis. Therefore, China deserves to be called 'the safest
    epidemic situation in the world at present'. Once we check the USA, the points of other
    countries are all below the US and there is a large difference between them. With those
    in mind, we can also explain this relative amount through different epidemic policies
    in those countries. For the broader implications of this chart, I would say I chose to 
    study these five countries since they are the world's top five economies and the conclusions
    drawn from them is fairly applicable to other countries.")
  )
)
############

sidebar_panel_widget3 <- sidebarPanel(
  
  checkboxGroupInput(
    inputId = "country_selection",
    label = "Select Your Country(ies)",
    choices = c("USA", "China", "Japan", "Germany", "UK"),
    selected = "China"
  )
  
)

main_panel_plot3 <- mainPanel(
  plotlyOutput(outputId = "covid_country_plot"),
  p("This chart attempts to show the trends of daily new Covid cases for the world's top five
    economics throughout 2021. In this chart, you can select one or more country you would
    like to explore the patterns and draw conclusion by comparing them together.")
)


page_3 <- tabPanel(
  "Covid Stats by Country",
  sidebarLayout(
    sidebar_panel_widget3,
    main_panel_plot3,
  )
) 

##########
ui <- navbarPage(
  "Worldwide COVID-19 Statistics",
  intro_tab,
  page_1,
  page_3,
  theme = my_theme,
  summary_tab
)
