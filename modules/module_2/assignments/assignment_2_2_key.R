# Assignment 2_2 Key
# Keaton Wilson
# 2020-01-07
# keatonwilson@me.com

# packages
library(tidyverse)

# data
fish_tank_data = read_csv("https://tinyurl.com/tbyskxl")

# temperature function  
temp_sim = function() {
  return(mean(rnorm(n = 15, mean = 75, sd = 4)))
}

# test
temp_sim()

# sampling Tilapia tanks
# Filtering
tilapia_sub = fish_tank_data %>%
  filter(species == "tilapia") %>%
  mutate(avg_daily_temp = (avg_daily_temp*1.8)+32)

# Sampling
one_shot_sample = sample(tilapia_sub$avg_daily_temp, size = 15, replace = FALSE)

# means
mean(one_shot_sample)
temp_sim()

# Looping each one and comparing means
sample_vec = c()
sim_vec = c()
for(i in 1:100){
  sample_vec[i] = mean(sample(tilapia_sub$avg_daily_temp, 
                                   size = 15, 
                                   replace = FALSE))
  sim_vec[i] = temp_sim()
}

comparison_df = data.frame(sample = sample_vec,
                           sim = sim_vec)
comparison_df %>%
pivot_longer(sample:sim, names_to = "type", values_to = "temp") %>%
  ggplot(aes(x = temp, fill = factor(type))) +
  geom_histogram() +
  geom_vline(xintercept = median(comparison_df$sample)) +
  geom_vline(xintercept = median(comparison_df$sim))

# Conclusions, our medians are the same, but our simulation isn't really 
# matching what we're seeing when we sample the data... much more spread. But 
# the main take home here is that there isn't a big difference in the average
# tank temperature from our simulation, where it's sitting tightly around 75º F. 
  
