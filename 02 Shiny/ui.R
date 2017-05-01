#ui.R

require(shiny)
require(shinydashboard)

dashboardPage(
  dashboardHeader(title = "State Elementary Spending"
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Spending to Bachelors", tabName = "spendtobach", icon = icon("dashboard")),
      menuItem("Spending by State", tabName = "sps", icon = icon("dashboard")),
      menuItem("Spending per Child", tabName="dingy",icon = icon("dashboard")),
      menuItem("Spending Per Child Boxplot",tabName="dingy2",icon=icon("dashboard"))
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
                
              )),
      tabItem(tabName="dingy",
              fluidPage(
                plotOutput("plot5"), br()
                
              )),
      tabItem(tabName="dingy2",
              fluidPage(
                plotOutput("plot6"), br()
              ))

      
    )
  ))