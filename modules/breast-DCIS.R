library(shiny)
library(glue)

breastDCISInput <- function(id, label = "BreastDCIS") {
  ns <- NS(id)
  tagList(
    textInput(ns("ID"), label = "Surgical ID"), 
    radioButtons(ns("histology"),
                 label = h5("Histology"), 
                 choices = list("DCIS" = "Ductal carcinoma in situ, NOS",
                                "Aocrine" = "Ductal carcinoma in situ, apocrine variant"),
                 selected = "Ductal carcinoma in situ, NOS",
                 inline = TRUE),
    numericInput(ns("size_l"), 
                 label = h5("Largest tumor size"),
                 2.0, 
                 step = 0.1,
                 width = '100px'),
    verbatimTextOutput(ns("out")),
    actionButton(ns("submit")," submit")
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
  
  observeEvent(input$submit, {
    entryValues <- data.frame(ID = input$ID,
                              histology = input$histology,
                              size_l = input$size_l)
    db_insert_into(pool, "Breast,DCIS", entryValues)
  })
}
