#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(GGally)



#Data Import and Cleaning
week7_tbl <- read_csv("../data/week3.csv") %>%
  mutate(timeStart=ymd_hms(timeStart)) %>%
  mutate(condition= factor(condition, levels=c("A","B","C"), labels=c("Block A","Block B","Control"))) %>%
  mutate(gender=factor(gender, levels=c("M","F"), labels=c("Male","Female"))) %>%
  filter(q6 == 1) %>%
  select(-q6) %>%
  mutate(timeSpent= timeEnd-timeStart)
