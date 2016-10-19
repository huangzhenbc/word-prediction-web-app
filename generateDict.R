library(RWeka)
library(tm)
library(stringr)
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

generate <- function(data, sparcity = 0.9999, n) {
    Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min=n, max=n))
    data = str_replace_all(data, "'", " ") # I'm -> I m. This punctuation is special
    data <- sapply(data, str_replace_all, pattern = "[^a-zA-z ]", replacement = "")
        # Other punctuation just remove
    
    vc <- VCorpus(VectorSource(data)) # construct corpus
    vc <- tm_map(vc, tolower) # to lower case
    vc <- tm_map(vc, stripWhitespace) # strip space
    vc <- tm_map(vc, PlainTextDocument) # convert to plain text
    
    tdm <- TermDocumentMatrix(vc, control = list(tokenize = Tokenizer)) # construct tdm
    tdm <- removeSparseTerms(tdm, sparcity) # remove sparse terms
    mat <- as.matrix(tdm) # convert to matrix
    series <- sort(rowSums(mat), decreasing = TRUE) # sort according to value
    df <- data.frame(word = names(series), freq = series) # convert to data frame
    rm(tdm, mat, series)
    
    return (df)
}

generateDict <- function(sourceFile, distFile, n, sparcity = 0.9999, size = 100000) {
    con <- file(sourceFile, "r")
    data <- readLines(con)
    close(con)
    
    splitted <- split(data, ceiling(seq_along(data)/size))
    results <- lapply(splitted, generate, sparcity, n)
    merged <- Reduce(function(...) merge(..., by="word", all=TRUE), results)
    
    merged[is.na(merged)] <- 0
    merged["freq"] = rowSums(merged[,-1])
    merged = merged[,c("word", "freq")]
    merged = merged[with(merged, order(-freq)),]
    rm(results, splitted, data)
    
    write.csv(merged, distFile, row.names = FALSE)
}

# Example: 
# Source this script and type: 
# generateDict("en_US/en_US.twitter.txt", "twitter2.csv", n=2, sparcity = 0.999)
# into R console you will get twitter2.csv as 2-gram for en_US.twitter.txt dataset

