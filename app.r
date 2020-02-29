library(shiny)
library(shinydashboard)
library(dplyr)
library(tibble)
library(pool)
library(rlang)

source("modules/breast-invasive.R")
source("modules/breast-DCIS.R")

ui <- dashboardPage(
  dashboardHeader(title = "Report"),
  dashboardSidebar(
    sidebarMenu(id = "tabs",
                menuItem("Breast, Invasive", tabName = "breastInvasive"),
                menuItem("Breast, DCIS", tabName = "breastDCIS"))
    ),
  dashboardBody(
    tabItems(
      tabItem("breastInvasive", breastInvasiveInput("breastInvasive")),
      tabItem("breastDCIS", breastDCISInput("breastDCIS"))
      )
  )
)

server <- function(input, output, session) {
  callModule(breastInvasive, "breastInvasive")
  callModule(breastDCIS, "breastDCIS")
}

shinyApp(ui, server)