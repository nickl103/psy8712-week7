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





#Visualization
week7_tbl%>%
  select(q1:q10) %>%
  ggpairs
(week7_tbl %>%
    ggplot(aes(timeStart, q1)) +
    geom_point() +
    labs(x= "Date of Experiment", y= "Q1 Score")) %>%
  ggsave(filename="../figs/fig1.png")



(week7_tbl %>% 
    ggplot(aes(q1,q2, color=gender)) +
    geom_jitter() +
    labs(x="q1",y="q2", color="Participant Gender")) %>%
  ggsave(filename="../figs/fig2.png")

(week7_tbl %>% 
    ggplot(aes(q1,q2,)) +
    geom_jitter() +
    facet_grid(col=vars(gender),scales="free_x")) %>%
  ggsave(filename="../figs/fig3.png")



(week7_tbl %>%
    ggplot(aes(gender,timeSpent)) +
    geom_boxplot() +
    labs(x="Gender", y="Time Elapsed(mins)")) %>%
  ggsave(filename="../figs/fig4.png")


(week7_tbl %>%
    ggplot(aes(q5,q7, color=condition)) +
    geom_jitter() +
    geom_smooth(method="lm",se=F) +
    labs(x="Score on Q5", y="Score on Q7", color="Experimental Condition") +
    theme(legend.position= "bottom", legend.background= element_rect(fill = "#E0E0E0"))) %>%
  ggsave(filenam="../figs/fig5.png")