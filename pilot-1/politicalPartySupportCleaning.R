library(xlsxjars)
library(rJava)
library(maditr)
library(ggplot2)
library(dplyr)
library(xlsx)


options(scipen = 999)
`%notin%` <- Negate(`%in%`)

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