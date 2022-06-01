library(plotly)
library(bslib)

covid_df <- read.csv("worldometer_coronavirus_summary_data.csv")
covid_daily_df <- read.csv("worldometer_coronavirus_daily_data.csv")

features <- c("total_confirmed", "total_deaths", "total_recovered", "active_cases", "serious_or_critical")

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    h1("My app here"),
    p("This is a demo web app!")
  )
)


sidebar_panel_widget <- sidebarPanel(
  selectInput(
    inputId = "user_selection",
    label = "Country Options",
    choices = features,
    selected = "United States"
  ))



main_panel_plot <- mainPanel(
  plotlyOutput(outputId = "covid_plot"),
  p("this plot is good because yes")
)

Page_1 <- tabPanel(
  "covid stats by continent",
  sidebarLayout(
    sidebar_panel_widget,
    main_panel_plot
  )
)

summary_tab <- tabPanel(
  "Summary Page",
  fluidPage(
    h1("Summary"),
    p("summary info")
  )
)


ui <- navbarPage(
  "Climate Change",
  intro_tab,
  page_1,
  summary_tab
)

