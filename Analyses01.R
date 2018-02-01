library(dplyr)
library(here)
## create a data frame of your installed packages

## keep the variables
##   * Package
##   * LibPath
##   * Version
##   * Priority
##   * Built

## write it to data/installed-packages.csv
## YES overwrite the file that is there now
## that came from me (Jenny)
## it an example of what yours should look like

## when this script works, stage & commit it and the csv file
## PUSH!


myPacs <- installed.packages() %>%
  as_tibble %>%
  select(Package, LibPath, Version, Priority, Built)

write.csv(myPacs,here("data","installed.packages.csv"))

