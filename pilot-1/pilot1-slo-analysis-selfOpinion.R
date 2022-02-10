
#mean comparison according to indicator of mean political view
load(pilot_slo.RData)

#how much right-wing participants do we have?
length(pilot1_slo$economiclViews1[pilot1_slo$economiclViews1>50])
length(pilot1_slo$economiclViews1[pilot1_slo$socialViews1>50])

#a measure of political preference
pilot1_slo$politicalView<- (pilot1_slo$economiclViews1 + pilot1_slo$socialViews1)/2
pilot1_slo$politicalView
hist(pilot1_slo$politicalView)

#let's categorise liberal vs. conservative
pilot1_slo$politicalCategory <- ifelse(pilot1_slo$politicalView<50, "left",
                             ifelse(pilot1_slo$politicalView>50, "right", "moderate"))
#frequencies of each category
table(pilot1_slo$politicalCategory)

#descriptiv stats. for left-wing participants
library(psych)
tbl_left<-as.data.frame(describe(subset(pilot1_slo, politicalCategory=="left")))
tbl_left<-tbl_left[-c(1:12),]
tbl_left

#selfOpinion descriptive stats. for left-wing participants
tbl_left_self<-tbl_left[-c(1:6),]
tbl_left_self<-tbl_left_self[c(seq(3,137,3)),]
tbl_left_self

#descriptive stats. for right-wing participants
library(psych)
tbl_right<-as.data.frame(describe(subset(pilot1_slo, politicalCategory=="right")))
tbl_right<-tbl_right[-c(1:12),]
tbl_right

#selfOpinion descriptiv stats. for left-wing participants
tbl_right_self<-tbl_right[-c(1:6),]
tbl_right_self<-tbl_right_self[c(seq(3,137,3)),]
tbl_right_self

#comparison of means of the right and the left
comparison<-as.data.frame(cbind(tbl_left_self$mean,tbl_right_self$mean, tbl_left_self$mean-tbl_right_self$mean, tbl_left_self$vars, tbl_right_self$vars))
names(comparison)<-c("left", "right", "difference", "vars_l", "vars_r")
comparison
#potentials in var: 27, 33, 39, 45, 51, 54, 60, 102, 108, 120, 123, 126, 132, 135, 141
