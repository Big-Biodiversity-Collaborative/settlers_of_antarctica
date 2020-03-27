# Penguin Chick Data
# Keaton Wilson
# keatonwilson@me.com
# 2020-03-20

# packages
library(tidyverse)

site_list = c("McMurdo East", "McMurdo West", "McMurdo North", "McMurdo South",
              "Scott Base East", "Scott Base West", "Scott Base North", 
              "Scott Base South", "Cape Royds", "Erebus East", "Erebus West", 
              "Ross Island North", "Ross Island Tip", "Marble Point East", 
              "Marble Point West", "Marble Point North", "Marble Point South", 
              "Wright Valley Entrance", "Taylor Valley Entrance", 
              "Ferrar Coast")

penguin_chicks = data.frame(chick_ID = seq(1:3200),
                            site = sample(site_list, 
                                          size = 3200, 
                                          replace = TRUE)
                            ) %>% arrange(site)

# tussocks
nums = penguin_chicks %>%
  group_by(site) %>%
  count() %>%
  pull(n)

means = c(7, 10, 3, 1, 1, 8, 21, 9, 18, 10, 11, 11, 16, 6, 5, 16, 15, 13, 11, 3)
tussocks = c()
for(i in 1:20){
  tussocks = c(tussocks, rnorm(nums[i], means[i], sd = 0.5))
}

penguin_chicks = penguin_chicks %>%
  mutate(avg_tussocks = tussocks)

# distance to open water

means_ow = c(10, 125, 122, 500, 200, 205, 8, 44, 37, 200, 11, 90, 88, 31, 17, 
             201, 37, 44, 23, 17)
open_water = c()
for(i in 1:20){
  open_water = c(open_water, rnorm(nums[i], means_ow[i], sd = 1))
}

penguin_chicks = penguin_chicks %>%
  mutate(dist_open_water = open_water) %>%
  as_tibble()

write_csv(penguin_chicks, "./modules/module_4/data/penguin_chicks.csv")
