library(shiny)
library(glue)
library(colourpicker)

style_choices <- c("none", "dotted", "dashed", "solid", "double")
histology_choices <- list("Invasive ductal carcinoma",
                          "Invasive lobular carcinoam",
                          "Mucinous carcinoma")
LN_Choices <- list("Negative for malignancy",
                   "Metastasis")

ui <- fluidPage(theme = "theme.css",
                titlePanel("Button Styler"),
                
                sidebarLayout(
                  sidebarPanel(
                    
                    helpText("Style your buttons!"),
                    
                    radioButtons("Histology",
                                       label = h5("Histology"), 
                                       choiceNames = histology_choices,
                                       choiceValues = histology_choices,
                                       selected = "Invasive ductal carcinoma",
                                       inline = TRUE),
                    
                    radioButtons("LN",
                                       label = h5("LN"), 
                                       choices = LN_Choices,
                                       selected = "Negative for malignancy",
                                       inline = TRUE),
                    numericInput("size_l", 
                                 label = h5("Largest tumor size"),
                                 2.0, 
                                 step = 0.1,
                                 width = '100px'),
                    
                    # Label
                    textInput("label", "Select text form button", "Label"),
                    
                    # Text color
                    colourInput("color", "Select text colour", "black"),
                    
                    # Text size
                    numericInput("font_size", "Select text size", 18, min = 1, max = 50),
                    
                    # Background color
                    colourInput("background", "Select background colour", "white"),
                    
                    # Border color
                    colourInput("border_color", "Select border color", "gray"),
                    
                    # Border style
                    selectInput("border_style", "Select border style", style_choices, "solid"),
                    
                    # Border size
                    numericInput("border_width", "Select border width", 1, min = 1, max = 10),
                    
                    # Border radius
                    sliderInput("border_radius", "Select border radius", 5, min = 0, max = 100)
                  ),
                  
                  mainPanel(
                    h2("Code"),
                    verbatimTextOutput("text")
                  )
                )
)

server <- function(input, output) {
  
  output$text <- renderText({
    start <- glue('Breast, right, wide excision')
    
    s22 <- "   "
    diagnosis <- glue('{s22}{input$Histology}
                   {s22}{input$LN}')

    
    micro <- glue('Microscopic findings
                  {s22}Largest tumor size:{input$size_l}cm')
    
    glue('{start}\n {diagnosis}\n\n {micro}')
  })
  
}

shinyApp(ui, server)
