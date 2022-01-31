33jnv2tc

library(xlsxjars)
library(rJava)
library(maditr)
library(ggplot2)
library(dplyr)
library(xlsx)

options(scipen = 999)
`%notin%` <- Negate(`%in%`)

task1 <- read.xlsx("Political issues_Pilot 1_UK con-lib-self.xlsx", 1)
task2 <- read.xlsx("Political issues_Pilot 1_UK con-self-lib.xlsx", 1)
task3 <- read.xlsx("Political issues_Pilot 1_UK lib-con-self.xlsx", 1)
task4 <- read.xlsx("Political issues_Pilot 1_UK lib-self-con.xlsx", 1)
task5 <- read.xlsx("Political issues_Pilot 1_UK self-con-lib.xlsx", 1)
task6 <- read.xlsx("Political issues_Pilot 1_UK self-lib-con.xlsx", 1)

tasks <- bind_rows(task1, task2, task3, task4, task5, task6)

tasksHalfClean <- tasks %>% dplyr::filter(tasks$'Zone.Type' == "response_slider_endValue")
#tasksHalfClean <- tasksHalfClean %>% dplyr::filter(tasksHalfClean$'Participant.Status' == 'complete')

tasksClean <- tasksHalfClean[,c('Participant.Public.ID', 'Participant.Private.ID', 
                                'randomiser.k5qe', 'Zone.Name', 'Response','sliderText', 
                                'Spreadsheet.Row')]

tasksFinal <- dcast(setDT(tasksClean), Participant.Public.ID + 
                      Participant.Private.ID ~ Zone.Name + Spreadsheet.Row, 
                    value.var = "Response")

tasksFinal <- arrange(tasksFinal, Participant.Public.ID, 
                      Participant.Private.ID)



demographics <- read.xlsx('Demographics.xlsx', 1)

demographicsClean <- demographics %>% dplyr::filter(demographics$'Event.Index' == 1)
#demographicsClean <- demographics %>% dplyr::filter(demographics$'Participant.Status' == 'complete')

demographicsClean <- demographicsClean[, c('Participant.Public.ID', 
                                           'Participant.Private.ID', 
                                           'age', 'gender', 
                                           'gender.quantised', 
                                           'education', 
                                           'employment', 'employment.text', 
                                           'UKnationality', 
                                           'firstLanguage', 
                                           'firstLanguage.text', 'SES')]

demographicsClean$gender <- if_else(is.na(
  demographicsClean$gender.quantised), "Non-binary", demographicsClean$gender)

demographicsClean$firstLanguage <- if_else(
  demographicsClean$firstLanguage == "Yes", 'English', demographicsClean$firstLanguage.text)

demographicsClean$employment <- if_else(
  demographicsClean$employment == "Other (Please specify)", demographicsClean$employment.text, 
  demographicsClean$employment)

demographicsClean <- demographicsClean[, -11]
demographicsClean <- demographicsClean[, -8]
demographicsClean <- demographicsClean[, -5]

demographicsClean <- arrange(demographicsClean, 
                             Participant.Public.ID, 
                             Participant.Private.ID)



politicalPartySupport <- read.xlsx('Political Party Support.xlsx', 1)

politicalPartySupportClean <- politicalPartySupport %>% dplyr::filter(politicalPartySupport$'Event.Index' == 1)

politicalPartySupportClean <- politicalPartySupportClean[, c('Participant.Public.ID', 
                                                             'Participant.Private.ID', 
                                                             'politicalParty', 'politicalParty.text')]

politicalPartySupportClean$politicalParty <- if_else(is.na(
  politicalPartySupportClean$politicalParty.text), 
  politicalPartySupportClean$politicalParty, 
  politicalPartySupportClean$politicalParty.text)

politicalPartySupportClean <- politicalPartySupportClean[, -4]

politicalPartySupportClean <- arrange(politicalPartySupportClean, 
                                      Participant.Public.ID, 
                                      Participant.Private.ID)



politicalIdeology <- read.xlsx('Political Ideology_Pilot 1_UK.xlsx', 1)

politicalIdeologyClean <- politicalIdeology %>% dplyr::filter(
  politicalIdeology$Zone.Type == 'response_slider_endValue')

politicalIdeologyClean <- politicalIdeologyClean[, c('Participant.Public.ID', 
                                                     'Participant.Private.ID', 'Zone.Name',
                                                     'Response')]

politicalIdeologyClean <- dcast(setDT(politicalIdeologyClean),
                                Participant.Private.ID + Participant.Public.ID ~ 
                                  Zone.Name, value.var = "Response")

politicalIdeologyClean <- arrange(politicalIdeologyClean, 
                                  Participant.Public.ID, 
                                  Participant.Private.ID)

politicalIdeologyClean <- as.data.frame(politicalIdeologyClean)



cleanData <- merge(tasksFinal, 
                   politicalPartySupportClean[,c("Participant.Public.ID", setdiff(
                     colnames(politicalPartySupportClean), colnames(tasksFinal)))],
                   by="Participant.Public.ID")

cleanData <- merge(cleanData, 
                   politicalIdeologyClean[,c("Participant.Public.ID", setdiff(
                     colnames(politicalIdeologyClean), colnames(cleanData)))],
                   by = "Participant.Public.ID")

cleanData <- merge(cleanData, 
                   demographicsClean[,c("Participant.Public.ID", setdiff(
                     colnames(demographicsClean), colnames(cleanData)))],
                   by="Participant.Public.ID")