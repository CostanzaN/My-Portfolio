# load required libraries
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

# from the summary, we can see that 'issue' is a factor variable
table(mortgage$Issue)

# create a corpus from the complaint text
complaint_corpus = Corpus(VectorSource(mortgage$Consumer.complaint.narrative))
# filter/clean the text
# change the text to lower case
corpus_clean <- tm_map(complaint_corpus, content_transformer(tolower))
corpus_clean = tm_map(corpus_clean, removeNumbers) # remove all numers
corpus_clean = tm_map(corpus_clean, removeWords, stopwords()) # remove stop words
corpus_clean = tm_map(corpus_clean, removePunctuation) # remove punctuation
corpus_clean = tm_map(corpus_clean, stripWhitespace) # trim whitespaces in strings
MyStopwords=c('xxxxxxxx','xxxx','also', 'just', 's', 'us', 'will','say',
              'make', 'get', 'got', 'know', 'cfpb', 'wells', 'fargo', 'bank',
              'one', 'america', 'can','said', 'told','going', 'want', 'like')
corpus_clean <- tm_map(corpus_clean, removeWords,MyStopwords)
##corpus_clean= tm_map(corpus_clean, stemDocument)
##corpus_clean <- tm_map(corpus_clean, gsub, 
  #                     pattern = 'payments', 
   #                    replacement = 'payment')
corpus_clean
# create term-document matrix
mtg_dtm = DocumentTermMatrix(corpus_clean)

## ------------------------------------------------------------------------

findFreqTerms(mtg_dtm, lowfreq = 5000)

tdm_sparse <- removeSparseTerms(mtg_dtm, 0.90) # remove sparse terms

tdm_dm <- as.data.frame(as.matrix(tdm_sparse)) # count matrix

tdm_df <- as.matrix((tdm_dm > 0) + 0) # binary instance matrix

tdm_df <- as.data.frame(tdm_df)

tdm_df <- cbind(tdm_df, mortgage$Issue) # append label column from original dataset

levels(mortgage$Issue)
### splitting test and training
# replace class with numbers for easier readability
levels(tdm_df[,149])
levels(tdm_df[,149]) <- c("1", "2", "3","4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15")
set.seed(123)
s <- sample(1:nrow(tdm_df), nrow(tdm_df)*(0.70), replace = FALSE) # random sampling

train <- tdm_df[s,] # training set

test <- tdm_df[-s,] # testing set

table(train$`mortgage$Issue`) # class instances in train data


###Build Random forest model using repeated crossvalidation
require(caret)  # Load caret package

ctrl <- trainControl(method = "cv", number = 7) # 10-fold CV

train[,c(1:148)]
train[,149]
set.seed(100)  

rf.tfidf <- train(train[,c(1:148)], train[,149],
                  method = "rpart", trControl = ctrl)  # train random forest

rf.tfidf

###Predict
pred <- predict(rf.tfidf, newdata = test)  # Predicted values on test set


summary(predict(rf.tfidf, newdata = test))

conf <-confusionMatrix(pred,test[,149])
conf
conf$overall

