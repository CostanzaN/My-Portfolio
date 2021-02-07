##code to get the DB updating in automatic
#these libraries are necessary 
library(readxl)
library(httr) 
#create the URL where the dataset is stored with automatic updates every day url 
url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-",format(Sys.time(), "%Y-%m-%d"), ".xls", sep = "") 
#download the dataset from the website to a local temporary file 
GET(url, authenticate(":", ":", type="ntlm"), write_disk(tf <- tempfile(fileext = ".xls"))) 
#read the Dataset sheet into "R" data 
covid <- read_excel(tf)

#read DB

covid=read.csv(file='COVID-19-geographic-disbtribution-worldwide (1).csv', header = TRUE,sep = ',')


##DATA exploration - CLEANSING AND PREPARATION

str(covid)
head(covid)
summary(covid$geoId)
xtabs(~covid$geoId)

covid$dateRep=as.Date(covid$dateRep,format="%d/%m/%Y")
covid$countriesAndTerritories=as.character(covid$countriesAndTerritories)
covid$geoId=as.factor(covid$geoId)
covid$countryterritoryCode=as.character(covid$countryterritoryCode)
#missing values check

covid[!complete.cases(covid),]

## country code for Namibia is erraneous coded as na: missing value
##Assign state code to Code column:
covid$geoId=as.character(covid$geoId)
covid[is.na(covid$geoId) & covid$countriesAndTerritories == "Namibia",'geoId']= "NA"
covid$geoId=as.factor(covid$geoId)

#Order by date and add cumulate values
library(dplyr)

covid= covid[(order(covid$dateRep)),]
covid=covid%>%
  group_by(geoId)%>%
  mutate(Totalcases = cumsum(cases))%>%
  mutate(Totaldeaths = cumsum(deaths))


## Mapping total cases
install.packages('ggmap')
install.packages('maps')
library(ggmap)
library(maps)
world_map=map_data('world')
str(world_map)


# create a subset of covid DB
Cum_cases= covid %>%
  select(dateRep,cases,deaths,geoId,countriesAndTerritories) %>%
  group_by(countriesAndTerritories)%>%
  mutate(Totalcases= sum(cases))%>%
  mutate(Totaldeaths= sum(deaths))

#return values non matching and change it

nomatch=world_map$region[!world_map$region %in% Cum_cases$countriesAndTerritories]
unique(nomatch)


Cum_cases$countriesAndTerritories[Cum_cases$countriesAndTerritories=='United_States_of_America']='USA'
Cum_cases$countriesAndTerritories[Cum_cases$countriesAndTerritories=='United_Kingdom']='UK'
Cum_cases$countriesAndTerritories[Cum_cases$countriesAndTerritories=='South_Africa']='South Africa'
Cum_cases$countriesAndTerritories[Cum_cases$countriesAndTerritories=='Saudi_Arabia']='Saudi Arabia'
Cum_cases$countriesAndTerritories[Cum_cases$countriesAndTerritories=='New_Zealand']='New Zealand'
Cum_cases$countriesAndTerritories[Cum_cases$countriesAndTerritories=='Democratic_Republic_of_the_Congo']='Democratic Republic of the Congo'




library(ggmap)
library(ggplot2)
library(dplyr) 

##insert column Totalcases
world_map = world_map[Cum_cases$countriesAndTerritories %in% Cum_cases$countriesAndTerritories, ]
world_map$value = Cum_cases$Totalcases[match(world_map$region, Cum_cases$countriesAndTerritories)]

Countries = unique(world_map$region)
CDF = data.frame(label1=Countries)
for(i in CDF){
  world_map$Totalcases = ifelse(world_map$region %in% CDF$label1[i], (Cum_cases$Totalcases), world_map$value)
}

ggplot(world_map, aes(x=long, y=lat, group = group, fill = value)) + 
  geom_polygon(colour = "white") +
  scale_fill_gradient(low ='blue',
                      high = "red",
                      guide="colorbar")+
  theme_bw()  +
  labs(fill = "N. of cases" ,title = "Cumulative N. of cases worlwide", x="", y="") +
  scale_y_continuous(breaks=c()) +
  scale_x_continuous(breaks=c()) +
  theme(panel.border =  element_blank())
##################################################################

##insert column Totaldeaths
world_map = world_map[Cum_cases$countriesAndTerritories %in% Cum_cases$countriesAndTerritories, ]
world_map$value = Cum_cases$Totaldeaths[match(world_map$region, Cum_cases$countriesAndTerritories)]

Countries = unique(world_map$region)
CDF = data.frame(label1=Countries)
for(i in CDF){
  world_map$Totaldeaths = ifelse(world_map$region %in% CDF$label1[i], (Cum_cases$Totaldeaths), world_map$value)
}

ggplot(world_map, aes(x=long, y=lat, group = group, fill = value)) + 
  geom_polygon(colour = "white") +
  scale_fill_gradient(low ='blue',
                      high = "red",
                      guide="colorbar")+
  theme_bw()  +
  labs(fill = "N. of deaths" ,title = "Cumulative N. of deaths worlwide", x="", y="") +
  scale_y_continuous(breaks=c()) +
  scale_x_continuous(breaks=c()) +
  theme(panel.border =  element_blank())
##################################################################



##find top 10 countries with more cases
Cum_cases=covid %>%
  select(countriesAndTerritories, cases) %>%
  group_by(geoId) %>%
  summarise(Totalcases= sum(cases))

##order countries by total n. of cases
Cum_cases= Cum_cases[rev(order(Cum_cases$Totalcases)),]
head(Cum_cases,10) ##add to report

#CREATE A SUBSET FOR TOP10 COUNTRIES PER N. OF COMULATIVE CASES
Top10= subset(covid,covid$geoId %in% Cum_cases$geoId[1:10])

#average daily increase in number of cases
library(dplyr)
Top10%>%
  select(dateRep,cases,deaths,geoId)%>%
  group_by(geoId)%>%
  summarise(avgdailyIncrease= mean(cases))

#total number of cases

library(dplyr)
Totalcases=Top10 %>%
  select(dateRep,cases,deaths,geoId) %>%
  group_by(geoId) %>%
  summarise(Totalcases= sum(cases))

#total number of deaths
Top10 %>%
  select(dateRep,cases,deaths,geoId) %>%
  group_by(geoId) %>%
  summarise(Totaldeath = sum(deaths))

Top10[rev(order(Top10$Totaldeaths)),]
 
#oder by date
Top10= Top10[(order(Top10$dateRep)),]

#calculate cumulative number of cases and deaths
Top10= Top10 %>%
  select(dateRep,cases,deaths,geoId) %>%
  group_by(geoId) %>%
  mutate(Totalcases = cumsum(cases))%>%
  mutate(Totaldeaths = cumsum(deaths))

##create animated graph

library(lubridate)
install.packages("gganimate")
install.packages("gifski")
install.packages("av")
library(gganimate)
library(gifski)
library(av)
library(ggplot2)


ggplot(data = Top10, mapping = aes(x = dateRep, y = Totalcases, color = geoId)) +
  geom_line(alpha= 5)+
  geom_point(size=1.5)+
  theme_bw()+
  labs(title= "N. Cumulative cases - Top10 countries",
       xlab= "time in days",
       ylab= "N. of cases")+
  transition_reveal(Totalcases)
anim_save('totalcases')
##youtubeChannelDr. Bharatendra Rai

##for total deaths

ggplot(data = Top10, mapping = aes(x = dateRep, y = Totaldeaths, color = geoId)) +
  geom_line(alpha= 5)+
  geom_point(size=1.5)+
  theme_bw()+
  labs(title= "N. Cumulative deaths - Top10 countries",
       xlab= "time in days",
       ylab= "N. deaths cases")+
  transition_reveal(Totaldeaths)

anim_save('cumulativedeaths')
##youtubeChannelDr. Bharatendra Rai

# daily multiplier for n of cases and deaths
library(dplyr)
Top10= Top10 %>%
  select(dateRep,cases,deaths,geoId) %>%
  group_by(geoId) %>%
  mutate(dailycasesinc=cases/lag(cases))%>%
  mutate(dailymultideath=deaths/lag(deaths))

Top10 %>%
  select(geoId,dailymultideath)%>%
  group_by(geoId) %>%
  filter(dailymultideath != Inf)%>%
  summarise(MaxgrowthRate= max(dailymultideath))

Top10 %>%
  select(geoId,dailycasesinc)%>%
  group_by(geoId) %>%
  filter(dailycasesinc != Inf)%>%
  summarise(MaxgrowthRate= max(dailycasesinc))


## graph for daily mult n of cases to see peak
library(ggplot2)
library(dplyr)

#graph for daily death multiplier by country
ggplot(data = Top10 %>%
         filter(dateRep > '2020-02-01'),
       mapping = aes(x = dateRep, y = dailymultideath, color = geoId)) +
  geom_line() +
  facet_grid(rows = vars(geoId))


library(ggplot2)
ggplot(data = Top10, mapping = aes(x = dateRep, y = cases, color = geoId)) +
  geom_line() +
  facet_wrap(vars(geoId)) +
  labs(title = "Daily increase in n. of Cases",
       x = "Date",
       y = "Daily change in Number of cases") +
  theme_bw() +
  theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(colour = "grey20", size = 12),
        text = element_text(size = 16))

##https://datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html#customization


# it is said that as per exponential growth, the log increase could be fitt

AU=subset(covid, geoId=='AU')
AU$cases[AU$cases==0]= NA
AU= AU[(order(AU$dateRep)),]

library(dplyr)
AU= AU %>%
  select(dateRep,cases,deaths,geoId,Totaldeaths,Totalcases) %>%
  filter(cases> 0)%>%
  arrange(dateRep)%>%
  mutate(index_time = 1:nrow(AU %>%filter(cases> 0))) %>%
  mutate(dailycasesinc=cases/lag(cases))
  
AU$log_totcases=log(AU$Totalcases)

#fitting model

model=lm(log_totcases~index_time, AU)

summary(model)

ggplot(data = AU,
       mapping = aes(x = index_time, y = Totaldeaths)) +
  geom_line(col= 'red')+
  labs(title= 'Total cumulative cases- AUSTRALIA')+
  theme_bw() +
  theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(colour = "grey20", size = 12),
        text = element_text(size = 16))

##https://datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html#customization


plot(AU$index_time,AU$log_totcases,
     pch=21,       
     bg=c("red"),
     main="Regression model",
     ylab="Log n. of cases",
     xlab="n. of days")
abline(model)


# predict total number of cases after 40, 60 and 80 days
testdata= c(40,60,80)
newdf <- data.frame(index_time=testdata)
modresult=predict(model, newdf)


AU[40,'log_totcases']

AU[60,'log_totcases']




##test hypothesis

#italy subset
IT=subset(covid, covid$geoId== 'IT')

#sort df by date
IT= IT[rev(order(IT$dateRep)),]

##test Cina vs. Italy
CN=subset(covid, geoId== 'CN')



IT.CN=rbind(IT, CN)
ggplot(data = IT.CN, mapping = aes(x = dateRep, y = deaths)) +
  geom_point(alpha = 4, aes(color = geoId))+
  labs(title="Daily deaths increase ")


t.test(data= IT.CN,deaths ~  geoId)

ggplot(data = IT.CN, mapping = aes(x = dateRep, y = Totaldeaths)) +
  geom_point(alpha = 4, aes(color = geoId))+
  labs(title="Total cumulative Deaths ")

ggplot(data = IT.CN, mapping = aes(x = dateRep, y = Totalcases)) +
  geom_point(alpha = 4, aes(color = geoId))+
  labs(title="Total cumulative cases")

