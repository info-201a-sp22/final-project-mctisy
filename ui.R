library(plotly)
library(bslib)
library("htmlwidgets")
library("markdown")

covid_df <- read.csv("worldometer_coronavirus_summary_data.csv")
covid_daily_df <- read.csv("worldometer_coronavirus_daily_data.csv")

features <- c(
  "total confirmed", "total deaths", "total recovered",
  "active cases", "serious or critical"
)

############ Beautification and CSS formating
my_theme <- bs_theme(
  bg = "#faf7f8",
  fg = "#4a3a40",
  primary = "#87495f"
  # this scss file adds rounded border in all pictures, sets gradient for
  # the top bar and increases page left and right margins.
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
    selected = "USA"
  )
)

main_panel_plot2 <- mainPanel(
  plotlyOutput(outputId = "covid_tracker"),
  p("This chart attempts to clearly display trends regarding the number of
    daily new COVID-19 cases in each country. By allowing the user to select
    any country, they can easily compare and contrast the effects of COVID-19
    on different places across the globe over time.")
)


############

sidebar_panel_widget3 <- sidebarPanel(
  checkboxGroupInput(
    inputId = "checkbox_selection",
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

#############
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
  "COVID-19 Cases Tracker",
  sidebarLayout(
    sidebar_panel_widget2,
    main_panel_plot2,
  ),
)

page_3 <- tabPanel(
  "COVID-19 Stats by Country",
  sidebarLayout(
    sidebar_panel_widget3,
    main_panel_plot3,
  )
)

summary_tab <- tabPanel(
  "Summary",
  fluidPage(
    h1("Summary"),
    img(src = "summary.png", style = "width:180px"),
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
    p("Upon observing various countries through the COVID-19 cases tracker,
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

ui <- navbarPage(
  "Worldwide COVID-19 Statistics",
  intro_tab,
  page_1,
  page_2,
  page_3,
  theme = my_theme,
  summary_tab
)
