#ui.R

require(shiny)
require(shinydashboard)

dashboardPage(
  dashboardHeader(title = "State Elementary Spending"
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Spending to Bachelors", tabName = "spendtobach", icon = icon("dashboard")),
      menuItem("Spending by State", tabName = "sps", icon = icon("dashboard"))
      #menuItem("Income Per State", tabName = "rvs", icon = icon("dashboard"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "spendtobach",
              fluidPage(

                
                
                plotOutput("plot1"), br(),
                plotOutput("plot2")
                
                
                
                
              )
      ),
      tabItem(tabName="sps",
              fluidPage(
                plotOutput("plot3"), br(), plotOutput("plot4")
                
              ))

      )

      
    )
  )
