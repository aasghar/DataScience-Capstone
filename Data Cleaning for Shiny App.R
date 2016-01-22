##### Data Cleaning for ShinyApp Corpus ######

setwd("C:/Users/Ali/Documents/Capstone Project")

#### Libraries to use #####
library(tm)
library(dplyr)
library(SnowballC)
library(stylo)
library(stringi)
library(stringr)



file <- file.path(".", "final", "en_US")
corpus <- Corpus(DirSource(file))
saveRDS(corpus, "./wholeTDM.RData")
system.time(corpus <- readRDS("./wholeTDM.RData"))

set.seed(1000)
length(corpus[[1]][[1]])

corpus[[1]][[1]] = sample(corpus[[1]][[1]], 0.2*length(corpus[[1]][[1]]))
corpus[[2]][[1]] = sample(corpus[[2]][[1]], 0.2*length(corpus[[2]][[1]]))
corpus[[3]][[1]] = sample(corpus[[3]][[1]], 0.2*length(corpus[[3]][[1]]))

saveRDS(corpus, "./20%TDM.RData")
rm(corpus)

### Clean file ####

system.time(clean_corpus <- readRDS("./20%TDM.RData"))

#convert to lower case

clean_corpus <- tm_map(clean_corpus, content_transformer(tolower))


clean_corpus <- tm_map(clean_corpus, content_transformer(PlainTextDocument))


clean_corpus <- tm_map(clean_corpus, content_transformer(function(x) iconv(x, "latin1", "ASCII", sub="")))

#remove urls

removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) 
clean_corpus <- tm_map(clean_corpus, content_transformer(removeURL))

#remove punctuation

clean_corpus <- tm_map(clean_corpus, content_transformer(removePunctuation))
clean_corpus <- tm_map(clean_corpus, content_transformer(function(x) gsub("[^a-z\ ]", "", x)))

#remove numbers

clean_corpus <- tm_map(clean_corpus, content_transformer(removeNumbers))

#remove white space

clean_corpus <- tm_map(clean_corpus, stripWhitespace)

#remove profanity. We get list of profane words from: https://code.google.com/p/badwordslist/downloads/detail?name=badwords.txt


pf<- readLines("./badwords.txt")
pf<- gsub("[[:punct:]]", " ", pf)

profanityWords <- data.frame(pf)

clean_corpus <- tm_map(clean_corpus, removeWords, profanityWords[, 1])

#Stem document

#clean_corpus <- tm_map(clean_corpus, stemDocument)

#remove white space

clean_corpus <- tm_map(clean_corpus, stripWhitespace)

#Save final file. This is the final file we use for tokenizing

saveRDS(clean_corpus, file = "./20%cleancorpus.RData")

rm(clean_corpus, sample_corpus, pf, cname, profanityWords, removeURL, cleanGrammar)



########## Tokenizing ##########

system.time(finalCorpus <- readRDS("./10%cleancorpus.RData"))

x <- unlist(str_split(as.character(finalCorpus[[1]])," "))
y <- unlist(str_split(as.character(finalCorpus[[2]])," "))
z <- unlist(str_split(as.character(finalCorpus[[3]])," "))

allWords <- c(x, y, z)

rm(x, y, z, finalCorpus)


system.time(unigram <- make.ngrams(allWords, 1))
saveRDS(unigram, "./unigram-20%.RData")
rm(unigram)

system.time(count <- as.data.frame(table(unigram)))
count <- filter(count, Freq > 1)
count <- count[order(-count$Freq),]
system.time(unigram <- data.frame(unigram = word(count$unigram, -1), frequency = count$Freq))
saveRDS(unigram, "./ShinyApp/data/unigram-20%.RData")
rm(unigram, count, x)


options(mc.cores = 2)
system.time(bigram <- make.ngrams(allWords, 2))
saveRDS(bigram, "./bigram-20%.RData")

system.time(count <- as.data.frame(table(bigram)))
count <- filter(count, Freq > 1)
count <- count[order(-count$Freq),]
system.time(bigram <- data.frame(unigram = word(count$bigram, 1), bigram = word(count$bigram,-1), frequency = count$Freq))
saveRDS(bigram, "./ShinyApp/data/bigram-20%.RData")
rm(bigram, count, x)



system.time(trigram <- make.ngrams(allWords, 3))
saveRDS(trigram, "./trigram-20%.RData")

system.time(count <- as.data.frame(table(trigram)))
count <- filter(count, Freq > 2)
count <- count[order(-count$Freq),]
system.time(trigram <- data.frame(unigram = word(count$trigram, 1), bigram = word(count$trigram, 2), trigram = word(count$trigram, -1), frequency = count$Freq))
saveRDS(trigram, "./ShinyApp/data/trigram-20%.RData")
rm(trigram, count, x)



system.time(quadgram <- make.ngrams(allWords, 4))
saveRDS(quadgram, "./quadgram-20%.RData")

quadgram <- readRDS("./quadgram-20%.RData")
system.time(count <- as.data.frame(table(quadgram)))
count <- filter(count, Freq > 1)
count <- count[order(-count$Freq),]
system.time(quadgram <- data.frame(unigram = word(count$quadgram, 1), bigram = word(count$quadgram, 2), trigram = word(count$quadgram, 3), quadgram = word(count$quadgram, -1), frequency = count$Freq))
saveRDS(quadgram, "./ShinyApp/data/quadgram-20%.RData")
rm(quadgram, count, x)




system.time(fivegram <- make.ngrams(allWords, 5))
saveRDS(fivegram, "./fivegram-10%.RData")
fivegram <- readRDS("./fivegram-10%.RData")

system.time(count <- as.data.frame(table(fivegram)))
count <- filter(count, Freq > 1)
count <- count[order(-count$Freq),]
system.time(fivegram <- data.frame(unigram = word(count$fivegram, 1), bigram = word(count$fivegram, 2), trigram = word(count$fivegram, 3), quadgram = word(count$fivegram, 4), fivegram = word(count$fivegram, -1), frequency = count$Freq))
saveRDS(fivegram, "./ShinyApp/data/fivegram-10%.RData")
rm(quadgram, count, x)




