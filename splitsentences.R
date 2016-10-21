library(tm)
library(openNLP)

convert_text_to_sentences <- function(text, lang = "en") {
    # Credit: http://stackoverflow.com/questions/18712878/r-break-corpus-into-sentences
    
    # Function to compute sentence annotations using the Apache OpenNLP Maxent sentence detector employing the default model for language 'en'. 
    sentence_token_annotator <- Maxent_Sent_Token_Annotator(language = lang)
    
    # Convert text to class String from package NLP
    text <- as.String(text)
    
    # Sentence boundaries in text
    sentence.boundaries <- annotate(text, sentence_token_annotator)
    
    # Extract sentences
    sentences <- text[sentence.boundaries]
    
    # return sentences
    return(sentences)
}

splitsentences <- function(sourceFile, distFile, size = 50000) {
    con <- file(sourceFile, "r")
    data <- readLines(con, encoding = "UTF-8")
    close(con)
    
    splitted <- split(data, ceiling(seq_along(data)/size))
    results <- lapply(splitted, convert_text_to_sentences)
    merged <- Reduce(function(...) c(...), results)
    
    con <- file(distFile, "w")
    writeLines(merged, con)
    close(con)
}

#

# 