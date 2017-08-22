library(shiny)
library(tidyverse)
library(plyr)
library(shinythemes)
library(RColorBrewer)
library(DT)
library(data.table)



bnch_data <- read_csv("bnch_dta_macrosttest.csv")
#get rid of NA values
bnch_data <- bnch_data[complete.cases(bnch_data$Value),]
#Tidy names
bnch_data$Time<- gsub("^14-15", "2014-15", bnch_data$Time)
bnch_data$Time<- gsub("^15-16", "2015-16", bnch_data$Time)
bnch_data$Time <- gsub("/", "-", bnch_data$Time)
bnch_data <- filter(bnch_data, !Time %in% c("1974", "2012", "2013"))
#remove data that is used only in calculation of the indicators
bnch_data <- filter(bnch_data, !is.na(`One is high`))
#arrange options in alphabetical order
bnch_data<- arrange(bnch_data, Domain, Title, Time)
##Tidy up the names for 
#The Gross Cost of \"Children Looked After\" in a Community Setting per Child per Week adjusted for inflation
bnch_data$Title <- gsub('\"', "", bnch_data$Title)
excl_Scotland <- filter(bnch_data, `Local Authority` != "Scotland")