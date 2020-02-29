library(shiny)
library(pool)
library(glue)

pool <- dbPool(RSQLite::SQLite(), dbname = "report.sqlite")

breastInvasiveInput <- function(id, label = "BreastInvasive") {
  ns <- NS(id)
  tagList(
    textInput(ns("ID"), label = "Surgical ID",
              value = "S20-000000"),
    actionButton('id', "Find ID"),
    fluidRow(
      tabBox(title = "Gross",
        tabPanel("Tumor",
          radioButtons(ns("side"),
                     label = h5("Side"), 
                     choices = list("Rt" = "right",
                                    "Lt" = "left"),
                     selected = "right",
                     inline = TRUE),
          textInput(ns("location"), label = "Tumor location",
                  value = "1hr"),
          radioButtons(ns("surgery"),
                     label = h5("Surgery type"), 
                     choices = list("Wide exision" = "wide excision",
                                    "SSM" = "skin sparing mastectomy"),
                     selected = "wide excision",
                     inline = TRUE),
          numericInput(ns("size_l"), 
                       label = h5("Largest tumor size"),
                       2.0, 
                       step = 0.1,
                       width = '100px')),
        tabPanel("Margin distance",
                 textInput(ns("superior"), label = "Superior",
                           value = "1.0cm"),
                 textInput(ns("inferior"), label = "Inferior",
                           value = "1.0cm"),
                 textInput(ns("medial"), label = "Medial",
                           value = "1.0cm"),
                 textInput(ns("lateral"), label = "Lateral",
                           value = "1.0cm")
                 )
      ),
      
      tabBox(title = "Micro",
             tabPanel("Histology",
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
                                   inline = TRUE)),
             tabPanel("Grade", id = "grade")
      )
      ),

    fluidRow(
      box(title = "Report", status = "primary",
          verbatimTextOutput(ns("out"))))
    )
        
}

breastInvasive <- function(input, output, session, pool) {
  pool <- dbPool(RSQLite::SQLite(), dbname = "report.sqlite")
  output$out <- renderText({
    start <- glue('Breast, {input$side}, {input$surgery}')
    
    s22 <- "   "
    diagnosis <- glue('{s22}{input$histology}
                   {s22}{input$LN}')
    micro <- glue('Microscopic findings
                  {s22}Largest tumor size:{input$size_l}cm')
    glue('{start}\n {diagnosis}\n\n {micro}')
  })
  text
  
  observeEvent(input$id, {
    # surgical_id <- input$id
    entryValues <- data.frame(ID = input$id)
    db_insert_into(pool, "Breast,Invasive", entryValues)
  })

  
  observeEvent(input$submit, {
    entryValues <- data.frame(ID = input$ID,
                              side = input$side,
                              surgery = input$surgery,
                              histology = input$histology,
                              LN = input$LN,
                              size_l = input$size_l)
    db_insert_into(pool, "Breast,Invasive", entryValues)
  })
}
