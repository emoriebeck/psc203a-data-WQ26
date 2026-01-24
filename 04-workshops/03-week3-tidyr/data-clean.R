library(psych)
library(plyr)
library(tidyverse)

wd <- "https://github.com/emoriebeck/R-tutorials/raw/master/07_descriptives"

# load the codebook
(codebook <- url(sprintf("%s/codebook.csv?raw=true", wd)) %>% 
    read_csv(.) %>%
    mutate(old_name = str_to_lower(old_name)))

old.names <- codebook$old_name # get old column names
new.names <- codebook$new_name # get new column names

(soep <- url(sprintf("%s/data/07-descriptives-data.csv?raw=true", wd)) %>% # path to data
    read_csv(.) %>% # read in data
    select(old.names) %>% # select the columns from our codebook
    setNames(new.names)) # rename columns with our new names

soep_long <- soep %>%
  pivot_longer(
    cols = c(-contains("Procedural"), -contains("Demographic"))
    , names_to = c("item", "year")
    , names_sep = "[.]"
    , values_to = "value"
    , values_drop_na = T
  ) %>%
  mutate(item = str_remove_all(item, "[ ]")) %>%
  pivot_wider(
    names_from = "item"
    , values_from = "value"
  ) %>% 
  arrange(Procedural__SID, year)

write_csv(soep_long, file = "~/Documents/teaching/PSC290-cleaning-fall-2023/04-workshops/03-week3-tidyr/gsoep.csv")
