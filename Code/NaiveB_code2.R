# load packages
library(tm)
library(tibble)
library(DT)
library(e1071)
library(gmodels)
library(caret)
library(dplyr)
library(ggplot2)
library(wordcloud)
library(RColorBrewer)
library(SnowballC)
## ------------------------------------------------------------------------
# Load the data
mortgage = read.csv("Mortgage.csv")

# explore the data
str(mortgage)

# show classes we have
table(mortgage$Issue)

# create a corpus from the complaint text
complaint_corpus = Corpus(VectorSource(mortgage$Consumer.complaint.narrative))
# filter/clean the text
# change the text to lower case
corpus_clean <- tm_map(complaint_corpus, content_transformer(tolower))

corpus_clean = tm_map(corpus_clean, removeNumbers) # remove all numbers
corpus_clean = tm_map(corpus_clean, removeWords, stopwords()) # remove stop words
corpus_clean = tm_map(corpus_clean, removePunctuation) # remove punctuation
corpus_clean = tm_map(corpus_clean, stripWhitespace) # trim whitespaces in strings
MyStopwords=c('xxxxxxxx','xxxx','also', 'just', 's', 'us', 'will','say',
              'make', 'get', 'got', 'know', 'cfpb', 'wells', 'fargo', 'bank',
              'one', 'america', 'can','said', 'told','going', 'want', 'like')
#remove additional stopwords
corpus_clean <- tm_map(corpus_clean, removeWords,MyStopwords)
# create term-document matrix
mtg_dtm = DocumentTermMatrix(corpus_clean)

## ------------------------------------------------------------------------

findFreqTerms(mtg_dtm, lowfreq = 5000)

#Creating Training and Test data set
set.seed(123)  # To get the same random sample
# Split data into training (70%) and validation (30%)
dt = sort(sample(nrow(mortgage), nrow(mortgage)*.7))
mortgage_train<-mortgage[dt,]
mortgage_test= mortgage[-dt,] 
# Check number of rows in training data set
nrow(mortgage_train)
nrow(mortgage_test)

dtm = sort(sample(nrow(mtg_dtm), nrow(mtg_dtm)*.7))
mtg_dtm_train<-mtg_dtm[dtm,]
mtg_dtm_test<-mtg_dtm[-dtm,]

complaint_corpus_train = corpus_clean[1:20346]
complaint_corpus_test = corpus_clean[20347:(20346+8720)]

## ------------------------------------------------------------------------
mtg_dict = findFreqTerms(mtg_dtm_train, 50) # find 50 most frequent terms
mtg_train = DocumentTermMatrix(complaint_corpus_train, list(dictionary = mtg_dict))
mtg_test = DocumentTermMatrix(complaint_corpus_test, list(dictionary = mtg_dict))

# convert term frequencies into binary factors (word exist / word does not exist)
convert_counts = function(x){
  x = ifelse (x > 0, 1, 0)
  x = factor(x, levels = c(0,1), labels = c("No", "Yes"))
  return(x)
}

# and apply to all instances
mtg_train = apply(mtg_train, MARGIN = 2, convert_counts)
mtg_test  = apply(mtg_test, MARGIN = 2, convert_counts)

## ------------------------------------------------------------------------
# Build model on train data
mtg_classifier = naiveBayes(mtg_train, mortgage_train$Issue)
mtg_test_pred = predict(mtg_classifier, newdata=mtg_test)

###
# results
(CrossTable(mtg_test_pred, mortgage_test$Issue,
           prop.chisq = FALSE, 
           prop.t = FALSE,
           dnn = c('predicted', 'actual')))


##confusion matrix
cfm <-confusionMatrix(mtg_test_pred,mortgage_test$Issue)
cfm
cfm$overall
##accuracy*100

# show results in a table
cfm$byClass %>% data.frame() %>%
  select (Sensitivity, Specificity, Balanced.Accuracy) %>%
  rownames_to_column(var = 'topic') %>%
  mutate(topic = gsub('Class: ','', topic)) %>%
  mutate_if(is.numeric, round, 2) %>%
  DT::datatable(options = list(pageLength = 17,dom = 't', scrollX = TRUE),
                rownames = FALSE, width="100%", escape=FALSE)


