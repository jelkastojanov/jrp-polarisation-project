
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
comparison_self<-as.data.frame(cbind(tbl_left_self$mean,tbl_right_self$mean, tbl_left_self$mean-tbl_right_self$mean, tbl_left_self$vars, tbl_right_self$vars))
names(comparison_self)<-c("left", "right", "difference", "vars_l", "vars_r")
comparison_self
#potentials in var: 27, 33, 39, 45, 51, 54, 60, 102, 108, 120, 123, 126, 132, 135, 141

length(subset(pilot1_slo, politicalCategory=="moderate")$ID)

#means of metaperceptions: left perception
tbl_left_meta_data<-pilot1_slo[,-c(1:18)]
tbl_left_meta_data<-tbl_left_meta_data[,c(seq(2,140,3))]
tbl_left_meta<-as.data.frame(describe(tbl_left_meta_data))
tbl_left_meta

#means of metaperceptions: right perception
tbl_right_meta_data<-pilot1_slo[,-c(1:18)]
tbl_right_meta_data<-tbl_right_meta_data[,c(seq(1,140,3))]
tbl_right_meta<-as.data.frame(describe(tbl_right_meta_data))
tbl_right_meta

#comparison of meta means of the right and the left
comparison_meta<-as.data.frame(cbind(tbl_left_meta$mean,tbl_right_meta$mean, tbl_left_meta$mean-tbl_right_meta$mean, tbl_left_meta$vars, tbl_right_meta$vars))
names(comparison_meta)<-c("left", "right", "difference", "vars_l", "vars_r")
comparison_meta


