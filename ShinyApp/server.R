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
    
    wordPrediction1 <- reactive({
        text <- input$text
        textInput <- cleanInput(text)
        wordCount <- length(textInput)
        wordPrediction1 <- nextWordPrediction(wordCount,textInput) 
                            #nextWordPrediction(wordCount,textInput, 2)
                            #nextWordPrediction(wordCount,textInput, 3)
                            })
    
#    wordPrediction2 <- reactive({
#        text <- input$text
#        textInput <- cleanInput(text)
#        wordCount <- length(textInput)
#        wordPrediction2 <- nextWordPrediction(wordCount,textInput, 2)})
    
#    wordPrediction3 <- reactive({
#        text <- input$text
#        textInput <- cleanInput(text)
#        wordCount <- length(textInput)
#        wordPrediction3 <- nextWordPrediction(wordCount,textInput, 3)})
    
    output$predictedWord <- renderPrint(wordPrediction1())
#    output$predictedWord2 <- renderPrint(wordPrediction2())
#    output$predictedWord3 <- renderPrint(wordPrediction3())
    
    output$enteredWords <- renderText({ input$text }, quoted = FALSE)
})