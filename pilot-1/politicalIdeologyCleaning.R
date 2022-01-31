library(xlsxjars)
library(rJava)
library(maditr)
library(ggplot2)
library(dplyr)
library(xlsx)

options(scipen = 999)
`%notin%` <- Negate(`%in%`)

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