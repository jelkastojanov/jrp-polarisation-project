party<- read.delim2(pipe("pbpaste"))
#merging all questinnaires, which were "cleaned" in excel

quest1 <- merge(demografija, party, by="Participant.Public.ID", all=TRUE)
total_ques<- merge(quest1, libertarism, by="Participant.Public.ID", all=TRUE)

names(total_ques$Participant.Public.ID)<-c("ID")
total_ques$ID<-total_ques$Participant.Public.ID
total_ques

#merging data from the tasks and the quest.
data_pilot1<- merge(total_ques, data_task, by="ID", all=TRUE)

data_pilot1<-data_pilot1[-8]
View(data_pilot1)
pilot1_slo <- data_pilot1
save(pilot1_slo, file = "pilot1_slo.RData")


task$ID<- task$Participant.Private.ID
data_long<- merge(total_ques, task, by="ID", all=TRUE)
View(data_long)
data_long

save(pilot1_slo_long, file = "pilot1_slo_long.RData")
save(pilot1_slo_long, file = "pilot1_slo_long.RData")

cor(data_task$economiclViews1, data_task$socialViews1)



political<-subset(data_task, select = c("economiclViews1", "socialViews1", "ID"))

pilot1_slo<-merge(political, pilot1_slo, by="ID")

save(pilot1_slo, file = "pilot1_slo.RData")










