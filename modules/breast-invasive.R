library(shiny)
library(pool)
library(glue)

pool <- dbPool(RSQLite::SQLite(), dbname = "report.sqlite")

breastInvasiveInput <- function(id, label = "BreastInvasive") {
  ns <- NS(id)
  tagList(
    radioButtons(ns("histology"),
                 label = h5("Histology"), 
                 choices = list("IDC" = "Invasive ductal carcinoma",
                                "ILC" = "Invasive lobular carcinoam",
                                "Mucinous" = "Mucinous carcinoma"),
                 selected = "Invasive ductal carcinoma",
                 inline = TRUE),
    radioButtons(ns("LN"),
                 label = h5("LN"), 
                 choices = list("Negative" = "Negative for malignancy",
                                "Metastasis" = "Metastasis"),
                 selected = "Negative for malignancy",
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

breastInvasive <- function(input, output, session, pool) {
  pool <- dbPool(RSQLite::SQLite(), dbname = "report.sqlite")
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
  
  observeEvent(input$submit, {
    entryValues <- data.frame(histology = input$histology, LN = input$LN, size_l = input$size_l)
    db_insert_into(pool, "Breast,Invasive", entryValues)
  })
}
