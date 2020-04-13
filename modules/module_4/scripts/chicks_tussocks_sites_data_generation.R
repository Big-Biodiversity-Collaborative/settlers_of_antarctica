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

complement <- function(y, rho, x) {
  if (missing(x)) x <- rnorm(length(y)) # Optional: supply a default if `x` is not given
  y.perp <- residuals(lm(x ~ y))
  rho * sd(y.perp) * y + y.perp * sd(y) * sqrt(1 - rho^2)
}

x = site_changes$num_nests
y = -1.5*(x - 6)^2 + 4*(x) + 50
var = sample(seq(from = 0.9, to = 1.1, by = 0.01), size = length(y), replace = TRUE)
y_with_var = y*var

site_changes = tibble(site_id = c(rep(1:100), rep(1:100)), 
                      year = c(rep(1971, 100), rep(2011, 100)),
                      tussocks = c(rnorm(100, 5, sd = 1), rnorm(100, 7, sd = 1)), 
                      dist_to_water = c(rnorm(100, 27, sd = 2), rnorm(100, 21, sd = 2)), 
                      stone_size = c(rnorm(100, 44, sd = 3), rnorm(100, 44, sd = 3)))


x1 = site_changes$stone_size[1:100]
x2 = site_changes$stone_size[1:100]
y1 = -2*(x1 - 48)^2 - 4*(x1) + 400
y2 = -2*(x2 - 48)^2 - 4*(x2) + 450

var1 = sample(seq(from = 0.7, to = 1.4, by = 0.01), size = length(y1), replace = TRUE)
var2 = sample(seq(from = 0.7, to = 1.4, by = 0.01), size = length(y2), replace = TRUE)
y1_with_var = abs((y1*var1)*0.1)
y2_with_var = abs((y2*var2)*0.1)

plot(x1, y1_with_var)
points(x2, y2_with_var, pch = 16, col = "black")

site_changes$num_nests = c(y1_with_var, y2_with_var)
site_changes$num_nests = round(site_changes$num_nests)

write_csv(site_changes, path = "./modules/module_4/data/site_changes.csv")
