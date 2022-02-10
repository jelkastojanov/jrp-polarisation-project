taskVers1 <- read.csv("task1.csv")
taskVers2 <- read.csv("task2.csv")
taskVers3 <- read.csv("task3.csv")
taskVers4 <- read.csv("task4.csv")
taskVers5 <- read.csv("task5.csv")
taskVers6 <- read.csv("task6.csv")
taskVers7 <- read.csv("task7.csv")
taskVers8 <- read.csv("task8.csv")

#lets bind
library(dplyr)
task <- bind_rows(taskVers1, taskVers2, taskVers3, taskVers4, taskVers5, taskVers6, taskVers7, taskVers8)

task <- task[, c('Participant.Private.ID', "Trial.Number", "Screen.Number", 'Zone.Name', "Zone.Type",'randomiser.ltur', 'Response')]
task <- task %>% 
  dplyr::filter(Zone.Name %in% c('selfOpinion', 'liberalOpinion', "conservativeOpinion", "socialViews", "economiclViews")))

task <- task %>% 
  dplyr::filter(Zone.Type %in% c('response_slider_endValue'))

library(maditr)
taskFinal <- dcast(setDT(task),  Trial.Number+ Zone.Name  ~ Participant.Private.ID ,
                   value.var = 'Response')


# I have 48 participants: and 138 answers from every participants (together 138*48 = 6624)
ID<- task$Participant.Private.ID[seq(1, 6624, by=138)]

#transpose the matrix
a<-as.data.frame(as.matrix(t(taskFinal)))
a
#decide on names
pf <- paste(a[2,], a[1,], sep = "")
pf

#change the names
names(a) <- as.list(pf)

#erase the 1st 2 rows
a<-a[-c(1,2),]

#transform into numeric
a$conservativeOpinion1 <- as.numeric(a$conservativeOpinion1)

data_task<-as.data.frame(apply(a , 2, as.numeric))

data_task$ID<- ID
data_task


#how much right-wing participants do we have?
length(data_task$economiclViews1[data_task$economiclViews1>=50])
length(data_task$economiclViews1[data_task$socialViews1>=50])

#a measure of political preference
data_task$politicalView<- data_task$economiclViews1 + data_task$socialViews1

#lets categorise liberal vs. conservative
data_task$liberals <- ifelse(data_task$politicalView<100, 1, 0)
table(data_task$liberals)

# means for liberals
round(apply(data_task[data_task$liberals==1], 2, mean),2)

# means for conservatives
round(apply(data_task[data_task$liberals==0], 2, mean),2)

#diff: look for biggest difference in selfOpinions
difference.means<-as.data.frame(round(apply(data_task[data_task$liberals==1], 2, mean),2)-round(apply(data_task[data_task$liberals==0], 2, mean),2))
diffrence.means


