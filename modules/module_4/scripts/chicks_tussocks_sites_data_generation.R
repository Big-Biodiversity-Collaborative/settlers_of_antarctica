# Second data set for 4.4 onward
# Keaton Wilson
# keatonwilson@me.com
# 2020-03-27

# packages
library(tidyverse)

# each row is data from a single site for a single year
# vars - #tussocks, distance to water, year (1991, 2011), #nests, avg_stone_size
# Major patterns in data:
# 1. More tussocks/m2 in 2011 than in 1971 (on average)
# 2. Distance to open water decreases between 1971 and 2011
# 3. Number of nests is non-linear with stone size
# 4. More tussocks = more nests
# 5. 
site_changes = tibble(site_id = c(rep(1:100), rep(1:100)), 
                      year = c(rep(1971, 100), rep(2011, 100)),
                      )

                      

mtcars
?pivot_long
