## make a barchart from the frequency table in data/add-on-packages-freqtable.csv
library(tidyverse)

ipt <- read.csv(here("data","add-on-packages-freqtable.csv"))
barplot(ipt$prop)

## read that csv into a data frame, then ...

## if you use ggplot2, code like this will work:
myplot <- ggplot(apt_freqtable, aes(x = Built, y = n)) +
  geom_bar(stat = "identity")

## write this barchart to figs/built-barchart.png
## if you use ggplot2, ggsave() will help

ggsave(here("plots","barplot01.jpg"), height=3)

ggsave(paste0("C:/Users/Eric.Krantz/Dropbox (RESPEC)/R",
              "/",
              "barplot01.jpg", sep = ""), height=3)

## YES overwrite the file that is there now
## that came from me (Jenny)

## when this script works, stage & commit it and the png file
## PUSH!
