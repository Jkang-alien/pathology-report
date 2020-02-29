library(shiny)
library(glue)

histology_choices <- list("Ductal carcinoma in situ, NOS",
                          "Ductal carcinoma in situ, apocrine variant")

breastDCISInput <- function(id, label = "BreastDCIS") {
  ns <- NS(id)
  tagList(
    radioButtons(ns("histology"),
                 label = h5("Histology"), 
                 choiceNames = histology_choices,
                 choiceValues = histology_choices,
                 selected = "Ductal carcinoma in situ, NOS",
                 inline = TRUE),
    numericInput(ns("size_l"), 
                 label = h5("Largest tumor size"),
                 2.0, 
                 step = 0.1,
                 width = '100px'),
    verbatimTextOutput(ns("out"))
  )
}

breastDCIS <- function(input, output, session) {
  output$out <- renderText({
    start <- glue('Breast, right, wide excision')
    
    s22 <- "   "
    diagnosis <- glue('{s22}{input$histology}')
    micro <- glue('Microscopic findings
                  {s22}Largest tumor size:{input$size_l}cm')
    glue('{start}\n {diagnosis}\n\n {micro}')
  })
  text
}
