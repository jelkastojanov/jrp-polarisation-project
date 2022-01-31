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

tasksFinal <- dcast(setDT(tasksClean), Participant.Private.ID + 
                      Participant.Public.ID ~ Zone.Name + Spreadsheet.Row, 
                    value.var = "Response")

tasksFinal <- arrange(tasksFinal, Participant.Public.ID, 
                                  Participant.Private.ID)