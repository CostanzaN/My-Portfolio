#load needed packages
library(dplyr)
library(textrank)
library(xml2)
library(rvest)
library(lexRankr)
library(tidyverse)
library(LSAfun)

# import dataset

mortgage=read.csv(file="Mortgage.csv", header = TRUE, sep = ",")
str(mortgage)


## text summarisation
#transform into character
mortgage$Consumer.complaint.narrative=as.character(mortgage$Consumer.complaint.narrative)

# see original complaint
mortgage$Consumer.complaint.narrative[7]
# apply text summarisation with genericSummary
genericSummary(mortgage$Consumer.complaint.narrative[7],k=3,split=c(".","!","?"),min=5,breakdown=FALSE)
# apply text summarisation with lexRank

lexRank(mortgage$Consumer.complaint.narrative[7],docId = "create", threshold = 0.2, n = 3,
         returnTies = TRUE, usePageRank = TRUE, damping = 0.85,
         continuous = FALSE, sentencesAsDocs = FALSE, removePunc = TRUE,
         removeNum = TRUE, toLower = TRUE, stemWords = TRUE,
         rmStopWords = TRUE, Verbose = TRUE)