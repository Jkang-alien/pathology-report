library(shiny)
library(glue)

histology_choices <- list("Invasive ductal carcinoma",
                          "Invasive lobular carcinoam",
                          "Mucinous carcinoma")
LN_Choices <- list("Negative for malignancy",
                   "Metastasis")

breastInvasiveInput <- function(id, label = "BreastInvasive") {
  ns <- NS(id)
  tagList(
    radioButtons(ns("histology"),
                 label = h5("Histology"), 
                 choiceNames = histology_choices,
                 choiceValues = histology_choices,
                 selected = "Invasive ductal carcinoma",
                 inline = TRUE),
    radioButtons(ns("LN"),
                 label = h5("LN"), 
                 choices = LN_Choices,
                 selected = "Negative for malignancy",
                 inline = TRUE),
    numericInput(ns("size_l"), 
                 label = h5("Largest tumor size"),
                 2.0, 
                 step = 0.1,
                 width = '100px'),
    verbatimTextOutput(ns("out"))
        )
}

breastInvasive <- function(input, output, session) {
  output$out <- renderText({
    start <- glue('Breast, right, wide excision')
    
    s22 <- "   "
    diagnosis <- glue('{s22}{input$histology}
                   {s22}{input$LN}')
    micro <- glue('Microscopic findings
                  {s22}Largest tumor size:{input$size_l}cm')
    glue('{start}\n {diagnosis}\n\n {micro}')
  })
  text
}

ui <- fluidPage(
  breastInvasiveInput("Breast Invasive", "Breast Invasive"),
)


server <- function(input, output, session) {
  callModule(breastInvasive, "Breast Invasive")
}

shinyApp(ui, server)