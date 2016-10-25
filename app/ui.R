# The ui

source("global.R")
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    titlePanel("Automatic Text Completion"),
    
    textAreaInput("sentences", "Type some text here:",
                  width = "1200px", height = "300px"),
    
    fluidRow(
        column(6,
               
               fluidRow(
                   column(8,
                          radioButtons("word", "Select a word:",
                                       choices = c(""))
                   )
               ),
               
               fluidRow(
                   column(3,
                          actionButton("fill", "Add to text")
                   )
               ),
               
               fluidRow(
                   column(8,
                          selectInput("select", "Language:", 
                                      choices = c("English"))
                          
                   )
               ), 
               
               fluidRow(
                   column(8,
                          selectInput("ngrams", 
                                      "ngrams: (n-1 words will be used to predict)", 
                                      choices = c("2"))
                          
                   )
               ),
               
               fluidRow(
                   sliderInput("maxwords", "Max Words Shown:", 3, 20, 5)
               )
        ),
        
        column(6,
               fluidRow(
                   # Explaining Text
                   h4("User guide:"),
                   p("1. This is a shiny app to predict the next word you want to enter"),
                   p("2. The main algorithm is called n-gram, which predicts the next word based only on previous n-1 words"),
                   p("3. We will make predictions as you entering the text, but it is possible that no predictions are available"),
                   p("4. Select a predition and click \"Add to text\" to add that word to the text area"),
                   p("5. If you think no predictions are good, just continue typing and we will try our best to predict :)"),
                   p("6. Enjoy this app")
               )
        )
        
        # column(6,
        #        h4("Statistics of the selected dataset:"),
        #        tabsetPanel(
        #            tabPanel("Word Cloud", 
        #                     fluidRow(
        #                         plotOutput("wordcloud")
        #                     ),
        #                     
        #                     fluidRow(column(6, offset = 3,
        #                                     sliderInput("wcnum",
        #                                                 "Number of words shown:",
        #                                                 min = 50, max = 100, value = 75, step = 5)
        #                     ))
        #            ), 
        #            tabPanel("Bar Plot", 
        #                     plotOutput("bar")
        #            )
        #        )
        # )
    )
    
    
))
