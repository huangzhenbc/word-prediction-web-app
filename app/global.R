# Main algorithms implemented here
# TODO: concatenate two list together

eng2 <- read.csv("eng2.csv")

predictwords <- function(sentence, dataset, n) {
    data <- eng2
    if(dataset == "English" && n == 2) {
        data <- eng2
    } 
    
    processed <- preprocess(sentence, n)
    words <- strsplit(processed, " ")[[1]]
    l <- length(words)
    ngrampredict(paste(tail(words, n-1), collapse = " "), data)
        
}

ngrampredict <- function(words, data) {
    predict <- data[data$ngram == words,]
    return (predict[with(predict, order(-prop)), ]$prediction)
}

preprocess <- function(sentence, n) {
    library(stringr)
    processed <- sapply(sentence, str_replace_all, pattern = "[^a-zA-z' ]", replacement = "")
    processed <- sapply(processed, tolower)
    processed <- format(processed, n)
    return (gsub("\\s+"," ",processed))
}

format <- function(str, n) {
    paste(c(rep("<s>", n-1), str), collapse = " ")
}

capitalize <- function(str) {
    # Credit: http://stackoverflow.com/questions/18509527/first-letter-to-upper-case
    str <- as.character(str)
    paste(toupper(substr(str, 1, 1)), substr(str, 2, nchar(str)), sep="")
}

# Depreciated Functions:

# predict1 <- function(word, dict) {
#     dictwords <- dict$word
#     wordlist <- list()
#     j <- 0
#     for (i in 1:length(dictwords)) {
#         bi <- strsplit(as.character(dictwords[i]), " ")[[1]]
#         if(bi[1] == word) {
#             wordlist[j] = bi[2]
#             j = j + 1
#         }
#         if(j == 5) {
#             break
#         }
#     }
#     
#     return (wordlist)
# }
# 
# predict2 <- function(word1, word2, dict) {
#     dictwords <- dict$word
#     wordlist <- list()
#     j <- 0
#     for (i in 1:length(dictwords)) {
#         tri <- strsplit(as.character(dictwords[i]), " ")[[1]]
#         if(tri[1] == word1 && tri[2] == word2) {
#             wordlist[j] = tri[3]
#             j = j + 1
#         }
#         if(j == 5) {
#             break
#         }
#     }
#     
#     return (wordlist)
#     
# }
# 
# predict3 <- function(word1, word2, word3, dict) {
#     dictwords <- dict$word
#     wordlist <- list()
#     j <- 0
#     for (i in 1:length(dictwords)) {
#         quad <- strsplit(as.character(dictwords[i]), " ")[[1]]
#         if(quad[1] == word1 && quad[2] == word2 && quad[3] == word3) {
#             wordlist[j] = quad[4]
#             j = j + 1
#         }
#         if(j == 5) {
#             break
#         }
#     }
#     
#     return (wordlist)
# }

