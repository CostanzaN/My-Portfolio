Predicting Credit Card default

Abstract

The aim of this report is to test the predictive power of the logistic regression model applied to a dataset containing variables related to credit card default.

Introduction

Credit Card default is a phenomenon which has been for a while under the spotlight. Especially in US, where consumer debt still plays a relevant percentage of the average American household. 
Even though according to FED at the end of 2019 the Delinquency rate for Credit Card was only 2.61%, after having reached its peak in 2009 (6.77%), it started to slowly but steady increasing again since 2014.
The effort from the research to determine a model to assess the probability of credit card default, relies on the economic concepts of information asymmetry and its financial consequences in terms of risk assessment and the related provisions needed.  Especially after the financial crisis, credit institutions had to put in place every tool available to assess, as close as possible, all the potential risks, with special focus on credit risk.
In this context the application of algorithms based on predictive models such as logistic regression, decision trees and artificial neural networks used for machine learning have found their way in supporting decision making and risk assessment process.

Literature Review

The possibility to assess the likelihood of default for credit card holder is one of the fields where statistical and data analysis tools have been proven to be useful for assessing customer’ credit risk.  The literature is quite rich in the application of logistical regression model for assessing probability of occurrence of a certain event, especially in the credit and finance field. In this specific context, over the last two decades, research has focus both on assessing the probability of fraud and default for Credit Card; as a matter of fact, for both aspects, the same underlying ratio can be applied. 
In some instances, academics tried to establish the most suitable model, as different methodology and classification algorithms (i.e. RandomTree, RandomForest and IBK) have been applied to this field performing with good accuracy thus achieving the objective of the study ( A. et al, 2016).



Dataset

The dataset has been retrieved from UCI – Machine learning repository website.
It consists of 30.000 records and 24 attributes (+1 row ID). There are no missing values. Data have been collected for the period between April(n-5) and September (n) 2005.
Datatype is integer for each variable. Detailed R output is provided in the appendix.

default payment next month	Y	Response variable: default payment Yes = 1, No = 0
LIMIT_BAL	X1	Total amount of credit granted in Dollars
SEX	X2	1= male; 2=female
EDUCATION	X3	1 = graduate school; 2 = university; 3 = high school; 4 = others
MARRIAGE	X4	1 = married; 2 = single; 3 = others
AGE	X5	In years

PAY_0	X6	repayment status month n	-1 = pay duly;
 1 = payment delay for one month;
2 = payment delay for two months; . . .; 8 = payment delay for eight months; 9 = payment delay for nine months and above.
PAY_2	X7	repayment status month n-1	
PAY_3	X8	repayment status month n-2	
PAY_4	X9	repayment status month n-3	
PAY_5	X10	repayment status month n-4	
PAY_6	X11	repayment status month n-5	


BILL_AMT1	X12	Amount in Bill statement month n
BILL_AMT2	X13	Amount in Bill statement month n-1
BILL_AMT3	X14	Amount in Bill statement month n-2
BILL_AMT4	X15	Amount in Bill statement month n-3
BILL_AMT5	X16	Amount in Bill statement month n-4
BILL_AMT6	X17	Amount in Bill statement month n-5
PAY_AMT1	X18	Amount paid month n
PAY_AMT2	X19	Amount paid month n-1
PAY_AMT3	X20	Amount paid month n-2
PAY_AMT4	X21	Amount paid month n-3
PAY_AMT5	X22	Amount paid month n-4
PAY_AMT6	X23	Amount paid month n-5

Looking at the structure of the dataset and at the variables, it is possible to observe some inconsistencies between the variable definitions provided by the website and the actual data observed.
The variable MARRIAGE, according to the definition above, should be equal to either 1,2 or 3. While looking at the data the following can be observed:

MARRIAGE
    0     1     2     3 
   54 13659 15964   323 

Same occurred for the variable PAY_0, for which the value -2 is not defined 

PAY_0
   -2    -1     0     1     2     3     4     5     6     7 
 2759  5686 14737  3688  2667   322    76    26    11     9 
    8 
   19 

As these values cannot be defined and considering the sample size, it is decided to remove these rows.

After sub-setting, the final sample size is 27241 obs.
We can see than in the dataset, the number of observations which defaulted are 6636, while 23364 did not default.

default.payment.next.month
    0     1 
21141  6051 

We can also observe than the gender of the majority is female
SEX
    1     2 
10905 16287 


Moreover, as previously stated, the data type is integer for every variable, however there are some categorical variables for which the datatype needs to be modified from integer to factor.

The dataset has been divided in two subsets: 80% of the observations have been included in the train data, while the rest on the test data.
The idea behind this is that the model is going to be run with the train dataset and then its “goodness of fit” is going to be tested on the test dataset.

Methodology

Logistic regression, also known as logit model, is a statistical tool which is able to model binary dependent variable. Once the parameters have been estimated this model gives as output the probability that event 1 occurs over the probability that event 0 occurs, this is known as log odds. 
The model is defined as follow:

Y*= ln(p/(1-p))= B0+B1X1(t-y)+B2X2(t-y)+…+BKXK(t-y)+ e

In this context, the dependent variable is default.payment.next.month while other selected attributes are going to be used as independent variables, in order to identify which of them is actually significant.

After some attempts, from the summary table we can see that the variables which proved to be significant in predicting the probability of default are the following:


Call:
glm(formula = default.payment.next.month ~ LIMIT_BAL + SEX + 
    MARRIAGE + PAY_0 + BILL_AMT1 + BILL_AMT2 + PAY_AMT1 + PAY_AMT2, 
    family = binomial(), data = train_data)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-1.8504  -0.6038  -0.5241  -0.3093   3.4871  

Coefficients:
              Estimate Std. Error z value Pr(>|z|)    
(Intercept) -7.929e-01  6.044e-02 -13.118  < 2e-16 ***
LIMIT_BAL   -2.757e-06  1.893e-07 -14.564  < 2e-16 ***
SEX2        -1.889e-01  3.657e-02  -5.166 2.39e-07 ***
MARRIAGE2   -1.901e-01  3.666e-02  -5.184 2.17e-07 ***
MARRIAGE3   -5.576e-02  1.658e-01  -0.336  0.73658    
PAY_00      -5.794e-01  5.559e-02 -10.424  < 2e-16 ***
PAY_01       7.330e-01  5.846e-02  12.538  < 2e-16 ***
PAY_02       2.040e+00  6.764e-02  30.164  < 2e-16 ***
PAY_03       2.299e+00  1.524e-01  15.085  < 2e-16 ***
PAY_04       1.956e+00  2.933e-01   6.670 2.57e-11 ***
PAY_05       1.250e+00  4.792e-01   2.609  0.00909 ** 
PAY_06       1.091e+00  6.389e-01   1.708  0.08764 .  
PAY_07       2.116e+00  8.208e-01   2.579  0.00992 ** 
PAY_08       1.127e+00  5.218e-01   2.161  0.03073 *  
BILL_AMT1   -3.194e-06  1.264e-06  -2.526  0.01153 *  
BILL_AMT2    5.681e-06  1.308e-06   4.344 1.40e-05 ***
PAY_AMT1    -1.243e-05  2.401e-06  -5.180 2.22e-07 ***
PAY_AMT2    -9.339e-06  2.298e-06  -4.064 4.83e-05 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 23489  on 21755  degrees of freedom
Residual deviance: 19519  on 21738  degrees of freedom
AIC: 19555

Number of Fisher Scoring iterations: 5

-	LIMIT_BAL, significant at >99%, the coefficient is negative meaning that as Limit balance increase, the Log Odds of the probability of default decrease.
-	SEX. Significant at 99%, coefficient is quite large and negative. This as well suggests that being female, the log odds of the probability of defaulting decrease compared to be a male. 
-	MARRIAGE: Married status is the baseline, hence being single (MARRIAGE=2) compared to being married has a decreasing effect in the log odds of the probability of default. 
-	PAY_0: baseline is “paid on time”, as the number of payment’s month increase, increase also the log odds of the probability of default. PAY_00 is considered to be as there is not data available about previous month as that is the first month, hence in this case, the log odds of the probability of default decreases
-	BILL_AMT1, significant at 95%, as the bill statement for the first month increases, the log odds of the probability of default decreases.
-	BILL_AMT2, significant at >99%, as the bill statement for the second month increases, the log odds of the probability of default increases.
-	PAY_AMT1, significant at >99%, as the bill statement for the second month increases, the log odds of the probability of default decreases.
-	PAY_AMT2, significant at >99%, as the bill statement for the second month increases, the log odds of the probability of default decreases.

 

The model accuracy obtained is equal to 81.5%; this has been determined applying the model to the test data, to see whether the model could correctly predict default of not.

Confusion matrix
log.prediction.rd    0    1
                0 4004  823
                1  181  430

Findings
According to our findings it is possible to identify some variables that can predict the impact in likelihood of default for the next month. 
In particular, it is interesting to see that for 1 unit increase in amount of credit granted, it is  expected a decrease of -2.76  in the expected log odds of default for the next month, given that all the other variables in the model are held constant. It is also interesting to notice that, according to these results, the log odds of default increases for being male compared to female, and for single compared to married people. The model’s accuracy scored is at 81,5%, which is considered to be a good result.




Bibliography
     
A, A., Venkatesh, A. and Gracia, S. (2016) ‘Prediction of Credit-Card Defaulters: A Comparative Study on Performance of Classifiers’, International Journal of Computer Applications, 145(7), pp. 36–41. doi: 10.5120/ijca2016910702.


Ma, Y. (2020) ‘Prediction of Default Probability of Credit-Card Bills’, Open Journal of Business and Management, 08, pp. 231–244. doi: 10.4236/ojbm.2020.81014.


Yeh, I. C., & Lien, C. H. (2009). ‘The comparisons of data mining techniques for the predictive accuracy of probability of default of credit card clients’. Expert Systems with Applications, 36(2), 2473-2480.


Sharma, S. and Mehra, V. (2018) Default Payment Analysis of Credit Card Clients. doi: 10.13140/RG.2.2.31307.28967.

https://archive.ics.uci.edu/ml/datasets/default+of+credit+card+clients#

