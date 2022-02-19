library(interactions)
library(afex)
library(tidyverse) 
library(dplyr)
library(readxl)
library(ggplot2)
library(lme4) 
library(lmerTest)
library(readr)
library(maditr)
library(patchwork)
library(janitor)
library(openxlsx)
library(Routliers)
library(lsmeans)
library(Hmisc)
library(car)
library(MPsychoR)
library(eigenmodel)
library(rmcorr)
options(scipen = 999) # Remove scientific notation
`%notin%` <- Negate(`%in%`) # Define %notin% function

# Rename dataframes
taskVers1 <- read.xlsx("task1.xlsx")
taskVers2 <- read.xlsx("task2.xlsx")
taskVers3 <- read.xlsx("task3.xlsx")
taskVers4 <- read.xlsx("task4.xlsx")
taskVers5 <- read.xlsx("task5.xlsx")
taskVers6 <- read.xlsx("task6.xlsx") #politicalIdeology
taskVers7 <- read.xlsx("task7.xlsx")
taskVers8 <- read.xlsx("task8.xlsx")

taskCombined <- bind_rows(taskVers1, taskVers2, taskVers3, taskVers4, taskVers5, taskVers7, taskVers8)

names(taskCombined)
taskCombined <- taskCombined[, c('Participant.Private.ID', "randomiser-ltur", 'Trial.Number', 'Zone.Name', 'Zone.Type', 'Reaction.Time', 'Response', 'display', 'sliderText')]# Rename columns to manipulate them easier
taskCombined
names(taskCombined)[3] <- 'trialNumber'
names(taskCombined)[4] <- 'zoneName'
names(taskCombined)[5] <- 'zoneType'
names(taskCombined)[6] <- 'reactionTime'
names(taskCombined)[7] <- 'response'

taskCombined <- taskCombined %>%
  dplyr::filter(display != 'instructions' & zoneType == 'response_slider_endValue')

# Cleaned task data
taskFinal <- taskCombined[, c('Participant.Private.ID', 'randomiser-ltur', 'trialNumber', 'zoneName', 'reactionTime', 'response', 'sliderText')]

names(taskFinal)[4] <- 'perspective'
names(taskFinal)[7] <- 'policyGoal'
table(taskFinal$perspective)

# taskVers6 is politicalIdeology
# Clean political ideology
politicalIdeologyFinal <- taskVers6 %>%
  dplyr::filter(taskVers6$`Zone.Type` == 'response_slider_endValue')

politicalIdeologyFinal <- politicalIdeologyFinal[, c('Participant.Private.ID', 'Zone.Name', 'Response')]
# Cleaned political ideology
politicalIdeologyFinal <- dcast(politicalIdeologyFinal,
                                Participant.Private.ID ~ `Zone.Name`,
                                value.var = 'Response')
# Combine all datasets
pilot1Data_slo <- left_join(taskFinal, politicalIdeologyFinal, by = "Participant.Private.ID")

# Export data into a .csv file
write.csv(pilot1Data_slo, 'pilot1Data.csv')


