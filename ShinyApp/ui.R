suppressPackageStartupMessages(c(
    library(shinythemes),
    library(shiny),
    library(tm),
    library(stringr),
    library(markdown),
    library(stylo)))

shinyUI(navbarPage("Coursera Data Science Capstone", 
                   
                   theme = shinytheme("united"),
                   
                   ############################### ~~~~~~~~1~~~~~~~~ ##############################  
                   ## Tab 1 - Prediction
                   
                   tabPanel("Next Word Prediction",
                            
                            tags$head(includeScript("./js/ga-shinyapps-io.js")),
                            
                            fluidRow(
                                
                                column(3),
                                column(6,
                                       tags$div(textInput("text", 
                                                          label = h3("Enter your text here:"),
                                                          value = ),
                                                tags$span(style="color:coral",("Please type in Engligh only.")),
                                                
                                          
                                                br(),
                                                tags$hr(),
                                                h4("Word Sequence Entered:"),
                                                br(),
                                                tags$em(style = "color: purple",
                                                        tags$h4(textOutput("enteredWords"))),
                                                
                                                br(),
                                                br(),
                                                
                                                tags$hr(),
                                                h4("Next word Prediction:"),
                                                tags$span(style="color:darkblue",
                                                          tags$strong(tags$h2(textOutput("predictedWord"))) ),
                                                
                                                align="center")
                                ),
                                column(3)
                            )
                   ),
                   
                   
                   ## Tab 2 - About 
                   
                   tabPanel("About This Application",
                            fluidRow(
                                column(2,
                                       p("")),
                                column(8,
                                       includeMarkdown("./about/about.Rmd")),
                                column(2,
                                       p(""))
                            )
                   ),
                   
                   
                   
                   # Footer
                   
                   tags$hr(),
                   
                   tags$br(),
                   
                   tags$span(style="color:grey", 
                             tags$footer(("Either write something worth reading about or do something worth writing about - "), 
                                         tags$a(
                                             target="_blank",
                                             "Benjamin Franlkin"), 
                                         tags$br(),
                                         
                                         align = "center",
                             
                             tags$br()
                   )
)
))
