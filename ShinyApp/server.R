suppressPackageStartupMessages(c(
    library(shinythemes),
    library(shiny),
    library(tm),
    library(stringr),
    library(markdown),
    library(stylo)))

source("./inputCleaner.R")
fivegram <- readRDS(file="./data/fivegram-10%.RData")
quadgram <- readRDS(file="./data/quadgram-20%.RData")
trigram <- readRDS(file="./data/trigram-20%.RData")
bigram <- readRDS(file="./data/bigram-20%.RData")


shinyServer(function(input, output) {
    
    wordPrediction <- reactive({
        text <- input$text
        textInput <- cleanInput(text)
        wordCount <- length(textInput)
        wordPrediction <- nextWordPrediction(wordCount,textInput) 
                            
                            })
    

    
    output$predictedWord <- renderPrint(wordPrediction())

    
    output$enteredWords <- renderText({ input$text }, quoted = FALSE)
})