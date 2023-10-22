library(tidyverse)
library(lubridate)
library(janitor)
library(ggrepel)
library(ggpubr)
library(skimr)
library(here)

daily_activity <- read_csv(here("dataset/dailyActivity.csv"))
daily_sleep <- read_csv(here("dataset/sleepDay.csv"))
hourly_steps <- read_csv(here("dataset/hourlySteps.csv"))

head(daily_activity)
str(daily_activity)

head(daily_sleep)
str(daily_sleep)

head(hourly_steps)
str(hourly_steps)

n_distinct(daily_activity$Id)
n_distinct(daily_sleep$Id)
n_distinct(hourly_steps$Id)

sum(duplicated(daily_activity))
sum(duplicated(daily_sleep))
sum(duplicated(hourly_steps))

daily_activity <- daily_activity %>% 
  distinct() %>% 
  drop_na()

daily_sleep <- daily_sleep %>% 
  distinct() %>% 
  drop_na()

hourly_steps <- hourly_steps %>% 
  distinct() %>% 
  drop_na()

clean_names(daily_activity)
rename_with(daily_activity, tolower)

clean_names(daily_sleep)
rename_with(daily_sleep, tolower)

clean_names(hourly_steps)
rename_with(hourly_steps, tolower)

daily_activity <- daily_activity %>%
  rename(date = ActivityDate) %>% 
  mutate(date = as_date(date, format="%m/%d/%Y"))

daily_sleep <- daily_sleep %>% 
  rename(date = SleepDay) %>% 
  mutate(date = as_date(date, format="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone()))

head(daily_activity)
head(daily_sleep)

hourly_steps <- hourly_steps %>% 
  rename(date_time = ActivityHour)
  mutate(date_time = as.POSIXct(date_time, format="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone()))

head(hourly_steps)

daily_activity_sleep <- merge(daily_activity,daily_sleep, by=c("Id","date"))
glimpse(daily_activity_sleep)

