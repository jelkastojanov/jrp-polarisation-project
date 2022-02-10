party<- read.delim2(pipe("pbpaste"))
#merging all questinnaires, which were "cleaned" in excel
quest1 <- merge(demografija, party, by="Participant.Public.ID", all=TRUE)
total_ques<- merge(quest1, libertarism, by="Participant.Public.ID", all=TRUE)

names(total_ques$Participant.Public.ID)<-c("ID")
total_ques$ID<-total_ques$Participant.Public.ID
total_ques

#merging data from the tasks and the quest.
data_pilot1<- merge(total_ques, data_task, by="ID", all=TRUE)
View(data_pilot1)


