party<- read.delim2(pipe("pbpaste"))

quest1 <- merge(demografija, party, by="Participant.Public.ID", all=TRUE)
total_ques<- merge(quest1, libertarism, by="Participant.Public.ID", all=TRUE)

