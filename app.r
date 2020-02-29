library(shiny)
library(shinydashboard)
library(dplyr)
library(tibble)
library(pool)
library(rlang)

source("modules/breast-invasive.R")

ui <- dashboardPage(
  dashboardHeader(title = "Report"),
  dashboardSidebar(
    sidebarMenu(id = "tabs",
                menuItem("breastInvasive", tabName = "breastInvasive"))
    ),
  dashboardBody(
    tabItems(
      tabItem("breastInvasive",
              breastInvasiveInput("breastInvasive")
      )
    )
  )
)

server <- function(input, output, session) {
  callModule(breastInvasive, "breastInvasive")
}

shinyApp(ui, server)