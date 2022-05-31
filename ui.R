library(plotly)

covid_df <- read.csv("worldometer_coronavirus_summary_data.csv")
covid_daily_df <- read.csv("worldometer_coronavirus_daily_data.csv")

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    h1("My app here"),
    p("This is a demo web app!")
  )
)


sidebar_panel_widget <- sidebarPanel(
  # selectInput(
  #   inputId = "user_selection",
  #   label = "YOUR CODE HERE",
  #   choices = climate_df$country,
  #   multiple = F, 
  # )
)

main_panel_plot <- mainPanel(
  plotlyOutput(outputId = "covid_plot")
)

climate_tab <- tabPanel(
  "Climate Viz",
  sidebarLayout(
    sidebar_panel_widget,
    main_panel_plot
  )
)


ui <- navbarPage(
  "Climate Change",
  intro_tab,
  climate_tab
)
