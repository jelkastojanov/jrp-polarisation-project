taskVers1 <- read.xlsx("task1.xlsx")
taskVers2 <- read.xlsx("task2.xlsx")
taskVers3 <- read.xlsx("task3.xlsx")
taskVers4 <- read.xlsx("task4.xlsx")
taskVers5 <- read.xlsx("task5.xlsx")
taskVers6 <- read.xlsx("task6.xlsx")
taskVers7 <- read.xlsx("task7.xlsx")
taskVers8 <- read.xlsx("task8.xlsx")

#lets bind
library(dplyr)
task <- bind_rows(taskVers1, taskVers2, taskVers3, taskVers4, taskVers5, taskVers6, taskVers7, taskVers8)

task <- task[,c('Participant.Private.ID', 
                 "Screen.Number", 
                 'Zone.Name', 
                 "Zone.Type",
                 'Response',
                 "sliderText")]
task <- task %>% 
  dplyr::filter(Zone.Name %in% c('selfOpinion', 'liberalOpinion', "conservativeOpinion", "socialViews", "economiclViews"))

View(task)
task <- task %>% 
  dplyr::filter(Zone.Type %in% c('response_slider_endValue'))


library(maditr)
taskFinal <- dcast(setDT(task),  sliderText + Zone.Name  ~ Participant.Private.ID ,
                   value.var = 'Response')

# I have 48 participants: and 138 answers from every participants (together 138*48 = 6624)
ID<- task$Participant.Private.ID[seq(1, 6624, by=138)]

a<-as.data.frame(as.matrix(t(taskFinal)))
a
pf <- paste(a[2,], a[1,], sep = "")
pf

#change the names
names(a) <- as.list(pf)

#erase the 1st 2 rows
a<-a[-c(1,2),]

#transform into numeric
a$conservativeOpinion1 <- as.numeric(a$conservativeOpinion1)

data_task<-as.data.frame(apply(a , 2, as.numeric))

data_task$ID<-ID
data_task
