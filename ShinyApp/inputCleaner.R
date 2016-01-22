suppressPackageStartupMessages(c(
    library(shinythemes),
    library(shiny),
    library(tm),
    library(stringr),
    library(markdown),
    library(stylo)))

fivegram <- readRDS(file="./data/fivegram-10%.RData")
quadgram <- readRDS(file="./data/quadgram-20%.RData")
trigram <- readRDS(file="./data/trigram-20%.RData")
bigram <- readRDS(file="./data/bigram-20%.RData")

dataCleaner<-function(text){
    
    cleanText <- tolower(text)
    cleanText <- removePunctuation(cleanText)
    cleanText <- removeNumbers(cleanText)
    cleanText <- str_replace_all(cleanText, "[^[:alnum:]]", " ")
    cleanText <- stripWhitespace(cleanText)
    
    return(cleanText)
}

cleanInput <- function(text){
    
    textInput <- dataCleaner(text)
    textInput <- txt.to.words.ext(textInput, 
                                  language="English.all", 
                                  preserve.case = TRUE)
    
    return(textInput)
}


nextWordPrediction <- function(wordCount,textInput){
    
    if (wordCount>=4) {
        textInput <- textInput[(wordCount-3):wordCount] 
        
    }
    
    else if(wordCount==3) {
        textInput <- c(NA,textInput)   
    }
    
    else if(wordCount==2) {
        textInput <- c(NA,NA,textInput)
    }
    
    else {
        textInput <- c(NA,NA,NA,textInput)
    }
    
    
    
    ### 1 ###
    wordPrediction <- as.character(fivegram[fivegram$unigram==textInput[1] & 
                                                  fivegram$bigram==textInput[2] & 
                                                  fivegram$trigram==textInput[3] &
                                                  fivegram$quadgram==textInput[4],][1,]$fivegram)
    
    if(is.na(wordPrediction)) {
        wordPrediction <- as.character(quadgram[quadgram$unigram==textInput[2] & 
                                                    quadgram$bigram==textInput[3] & 
                                                    quadgram$trigram==textInput[4],][1,]$quadgram)
        
        if(is.na(wordPrediction)) {
            wordPrediction <- as.character(trigram[trigram$unigram==textInput[3] & 
                                                       trigram$bigram==textInput[4],][1,]$trigram)
            
            if(is.na(wordPrediction)) {
                wordPrediction <- as.character(bigram[bigram$unigram==textInput[4],][1,]$bigram)
                
            }
            
        }
    }
    
    
    print(wordPrediction)
   
}