Capstone Presentation
========================================================
author: Ali Asghar
font-family: 'Helvetica'
width: 1440
height: 900
date: January 22 2016

Objective
========================================================

The main objective of this Capstone project is to develop a shiny application that accepts a series of words and outputs a predicted next word. This application involved utilizing a large corpus of Blog, News and Twitter feeds which was obtained from [HC Corpora](http://www.corpora.heliohost.org/) database. 


All text mining and natural language processing was done with the usage of a variety of well-known R packages including "tm", "stringr" and "stylo".

<div align="center"><img src="images/shiny.png" width=1200 height=500 /></div>

Methodology - Data Processing
========================================================

Since the size of the HC Corpora data was large, 20% of the corpus was sampled for further processing. This sample was cleaned by conversion to lowercase, removing punctuation,links, white space, numbers, profane words and all kinds of special characters.
This data sample was then tokenized into n-grams using the "stylo" package. 

Consequently unigram, bigram, trigram, quadgram and fivegram term frequency matrices were transferred into frequency dictionaries.

The resulting data.frames are ordered and used in this application to predict the next word when a user inputs certain text. 


Methodology - How Model predicts
========================================================

<small>The prediction is chosen by using a 'Stupid Back-off' model ([Brants et al 2007](http://www.cs.columbia.edu/~smaskey/CS6998-0412/supportmaterial/langmodel_mapreduce.pdf)). Based on the number of words entered, it checks if the highest number n-gram (fivegram is the highest) is detected.If it is not, the algorithm 'backs-off' to a lower level until it finds a matching n-gram. A prediction is chosen from the found n-gram.</small>

 
<div align="center"><img src="images/sbm2.png" width=1200 height=650 /></div>

 

Application - How does it work 
========================================================
The Shiny application is purposely made to be very simple to use. 

1. The user is asked to enter a sequence of words in a text box at the top of the screen
2. The user is shown the input that has been entered
3. A prediction is shown at the bottom of the screen based on the previously described prediciton model. 

<div align="center"><img src="images/app.png" width = 1200 height = 550 /></div>




Further Information
========================================================

The Shiny App can be found on the following link:   [https://aasghar.shinyapps.io/DataScience_Capstone/](https://aasghar.shinyapps.io/DataScience_Capstone/) 

The R files for processing and developing this Shiny App can be found on the following GitHub link: [https://github.com/aasghar/DataScience-Capstone](https://github.com/aasghar/DataScience-Capstone)

