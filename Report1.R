mydb=read.csv(file='report1.csv', header=TRUE, sep = ',', skip = 1)
#analyse DB structure
str(mydb)
summary(mydb)
dim(mydb)
head(mydb)
tail(mydb)
#check if there are missing values 
mydb[!complete.cases(mydb),]
introduce(mydb)
#there are no missing value, however it seems two variables have 0 which are not categorized in the dataset descriprions, hence we treat them as missing values

xtabs(~ MARRIAGE, data=mydb)
xtabs(~ PAY_0, data=mydb3)

#subsetting dataset to remove not defianed variables
mydb2=subset(mydb, mydb$MARRIAGE != 0)
nrow(mydb2)

mydb3=subset(mydb2, mydb2$PAY_0 != -2)
nrow(mydb3)


#transform variables into factors
mydb3$default.payment.next.month=as.factor(mydb3$default.payment.next.month)
mydb3$SEX=as.factor(mydb3$SEX)
mydb3$EDUCATION=as.factor(mydb3$EDUCATION)
mydb3$MARRIAGE=as.factor(mydb3$MARRIAGE)
mydb3$PAY_0=as.factor(mydb3$PAY_0)
mydb3$PAY_2=as.factor(mydb3$PAY_2)
mydb3$PAY_3=as.factor(mydb3$PAY_3)
mydb3$PAY_4=as.factor(mydb3$PAY_4)
mydb3$PAY_5=as.factor(mydb3$PAY_5)
mydb3$PAY_6=as.factor(mydb3$PAY_6)


str(mydb3)

xtabs(~ default.payment.next.month, data=mydb3)
xtabs(~ SEX, data=mydb3)

#graph for correlaton bewteen the explanatory variables
install.packages("DataExplorer")
library(DataExplorer)
plot_correlation(na.omit(mydb), maxcat = 5L)

plot_histogram(mydb)

#split DB into training and test
install.packages("caTools")
library(caTools)
set.seed(123)


data_sample = sample.split(mydb3$default.payment.next.month,SplitRatio=0.80)
train_data = subset(mydb3,data_sample==TRUE)
test_data = subset(mydb3,data_sample==FALSE)
dim(train_data)
dim(test_data)
#first attempt
Model=glm(default.payment.next.month~ LIMIT_BAL+SEX+ MARRIAGE+PAY_0+BILL_AMT1+ BILL_AMT2+PAY_AMT1+PAY_AMT2,train_data,family=binomial())
summary(Model)


exp(Model$coefficients[-1])

# fare grafici


plot(Model, main="Credit Card Default", 
     col="Blue", pch=19)


##test predicted model
log.predictions <- predict(Model, test_data, type="response")
log.predictions

log.prediction.rd <- ifelse(log.predictions > 0.5, 1, 0)
log.prediction.rd
table(log.prediction.rd)


table(log.prediction.rd, test_data[,25])

##accuracy- confusion matrix

accuracy <- table(log.prediction.rd, test_data[,25])
sum(diag(accuracy))/sum(accuracy)

