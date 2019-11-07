# Antarctica Station Data
# Keaton Wilson
# keatonwilson@me.com
# 2019-11-7

# packages
library(tidyverse)
library(lubridate)


# Multiple stations
test = read_delim("./modules/module_1/data/raw_antarctica_station_data/ag4201801q3h.txt", 
                  delim = " ", 
                  skip = 2, 
                  col_names = c("year", "day", "month", 
                                "running_day", "hour", 
                                "temp", "pressure", 
                                "wind_speed", "wind_direction", 
                                "humidity", "delta_t"))

test %>%
  mutate(date = paste(test$year, test$month, test$day, sep = "-") %>% ymd()) %>%
  mutate_if(is.character, as.numeric)


master_station_data = data.frame()
files = list.files("./modules/module_1/data/raw_antarctica_station_data/", 
                   full.names = TRUE)
for(i in 1:length(files)) {
  temp = read_delim(files[i], 
                    delim = " ", 
                    skip = 2, 
                    col_names = c("year", "day", "month", 
                                  "running_day", "hour", 
                                  "temp", "pressure", 
                                  "wind_speed", "wind_direction", 
                                  "humidity", "delta_t"))
  temp = temp %>%
    mutate(date = paste(year, month, day, sep = "-") %>% ymd()) %>%
    mutate_if(is.character, as.numeric) %>%
    mutate(station_id = str_remove(str_sub(files[i], start = -16), 
                                   pattern = ".txt"))
  master_station_data = bind_rows(master_station_data, temp)
}

write_csv(master_station_data, "./modules/module_1/data/aggregated_station_data.csv")
