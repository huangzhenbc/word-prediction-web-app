# The server

source("global.R")
library(shiny)
library(wordcloud)
library(ggplot2)
library(stringr)

shinyServer(function(input, output, session) {
    
    observeEvent(input$sentences, {
        # This part is for capitalize first letter
        words <- predictwords(input$sentences, input$select, as.numeric(input$ngrams))
        selected <- head(words, input$maxwords)
        processed = gsub("[[:space:]]", "", input$sentences)
        if(processed == "" || str_sub(processed, start = -1L) == ".") {
            selected <- lapply(selected, capitalize)
        }
        updateRadioButtons(session, "word", choices = selected,
                           selected = words[1]) # default: select the first prediction
    })
    
    observeEvent(input$maxwords, {
        # This part is for capitalize first letter
        words <- predictwords(input$sentences, input$select, as.numeric(input$ngrams))
        selected <- head(words, input$maxwords)
        processed = gsub("[[:space:]]", "", input$sentences)
        if(input$sentences == "" || str_sub(processed, start = -1L) == ".") {
            selected <- lapply(selected, capitalize)
        }
        updateRadioButtons(session, "word", choices = selected,
                           selected = words[1]) # default: select the first prediction
    })
    
    observeEvent(input$fill, {
        # Judging whether adding space or not
        if(length(input$sentences) == 0) {
            updateTextInput(session, "sentences",
                            value = paste(input$sentences, input$word, sep = ""))
        } else {
            last = nchar(input$sentences)
            if(substr(input$sentences, last, last) == " ") {
                updateTextInput(session, "sentences",
                                value = paste(input$sentences, input$word, sep = ""))
            } else { # This condition add space 
                updateTextInput(session, "sentences",
                                value = paste(input$sentences, input$word, sep = " "))
            }
        }
    })
    
    words <- eventReactive(input$select, {
        if(input$select == "English")
            eng
    })
    
    output$wordcloud <- renderPlot({
        wc <- words()
        wordcloud(wc$word, wc$freq, c(15,1.2), max.words = input$wcnum, 
                  random.order = FALSE, colors = brewer.pal(8, "Dark2"))
    })
    
    output$bar <- renderPlot({
        wh <- words()
        wh <- head(wh, 40)
        g <- ggplot(wh, aes(x=reorder(word, freq), y=freq)) +
            geom_bar(stat = "identity") +  coord_flip() +
            theme(legend.title=element_blank()) +
            xlab("Word") + ylab("Frequency")
        g
    })
    
})
