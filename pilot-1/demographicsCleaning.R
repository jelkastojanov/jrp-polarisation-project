library(xlsxjars)
library(rJava)
library(maditr)
library(ggplot2)
library(dplyr)
library(xlsx)


options(scipen = 999)
`%notin%` <- Negate(`%in%`)

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