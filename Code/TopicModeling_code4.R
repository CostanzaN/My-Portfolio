setwd("C:/Users/Costanza Nizzi/Desktop")

library(reshape)
library(lda)
library(topicmodels)
library(tidytext)
library(tm)
library(tibble)
library(DT)
library (e1071)
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
              'one', 'america', 'can','said', 'told','going', 'want', 'like', 'sls')
corpus_clean <- tm_map(corpus_clean, removeWords,MyStopwords)
corpus_clean= tm_map(corpus_clean, stemDocument)
corpus_clean <- tm_map(corpus_clean, gsub, 
                     pattern = 'payments', 
                    replacement = 'payment')
corpus_clean

# compute document term matrix with terms >= minimumFrequency
minimumFrequency <- 5
DTM <- DocumentTermMatrix(corpus_clean, control = list(bounds = list(global = c(minimumFrequency, Inf))))
# have a look at the number of documents and terms in the matrix
dim(DTM)

# due to vocabulary pruning, need to remove empty rows from the
# DTM and the metadata

sel_idx <- slam::row_sums(DTM) > 0
DTM <- DTM[sel_idx, ]
textdata <- mortgage[sel_idx, ]

# number of topics set =15
K <- 15
# set random number generator seed
set.seed(9161)
# compute the LDA model, inference via 500 iterations of Gibbs sampling
topicModel <- LDA(DTM, K, method="Gibbs", control=list(iter = 500, verbose = 25))

# have a look a some of the results (posterior distributions)
tmResult <- posterior(topicModel)
tmResult

topic_15 <- tidy(topicModel,matrix = "beta")
# choose 5 words with highest beta from each topic
top_terms_5 <- topic_15 %>%
  group_by(topic) %>%
  top_n(5,beta) %>% 
  ungroup() %>%
  arrange(topic,-beta)


# plot the topic and words for easy interpretation
plot_topic_15 <- top_terms_5 %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip() +
  scale_x_reordered()

plot_topic_15

# choose 10 words with highest beta from each topic
top_terms_10 <- topic_15 %>%
  group_by(topic) %>%
  top_n(10,beta) %>% 
  ungroup() %>%
  arrange(topic,-beta)

top10=(top_terms_10 %>%
  select(term,topic)%>%
  group_by(topic))

top10
###############

#wordcloud for each topic (first 50 words)
topic1=posterior(topicModel)$terms[1, ]
topwords1 = head(sort(topic1, decreasing = T), n=50)

wc1=wordcloud(names(topwords1), topwords1)
wc1
##same per topic 2
topic2=posterior(topicModel)$terms[2, ]
topwords2 = head(sort(topic2, decreasing = T), n=50)

wc2=wordcloud(names(topwords2), topwords2)
wc2
##same per topic 15
topic15=posterior(topicModel)$terms[15, ]
topwords15 = head(sort(topic15, decreasing = T), n=50)

wc15=wordcloud(names(topwords15), topwords15)
wc15

#########
## try see optimal number of topic between 2 and 15
library("ldatuning")

result <- FindTopicsNumber(
  DTM,
  topics = seq(from = 2, to = 15, by = 1),
  metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"),
  method = "Gibbs",
  control = list(seed = 77),
  verbose = TRUE
)

gtopic=FindTopicsNumber_plot(result)
