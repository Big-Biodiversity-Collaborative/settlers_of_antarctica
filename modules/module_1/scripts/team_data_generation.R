# Data/Application Generation
# Keaton Wilson
# keatonwilson@me.com
# 2019-10-28

# packages
library(tidyverse)
library(randomNames)
library(stringr)

# gender
gender = sample(0:1, 1000, replace = TRUE)
gender_labels = ifelse(gender == 0, "M", "F")

# name generation
names = randomNames(n = 1000, gender = gender)
last = unlist(lapply(str_split(names, ","), "[[", 1))
first = unlist(lapply(str_split(names, ","), "[[", 2))

# ages
age = sample(seq(19:87), size = 1000, replace = TRUE)

# specialty/discpline
specialty = c("Mechanical Engineering", "Horticulure", "Aquaculture", "Computer Science", 
              "Data Science", "Geology", "Marine Biology", "Climatology", 
              "Electrical Engineering", "Chemical Engineering", "Medicine", 
              "Management", "Applied Bioscience", "Genetics", "Hydrology", "Food Science")

specialties = sample(specialty, size = 1000, replace = TRUE)

# weight
weights = sample(seq(from = 90.0, to = 250, by = 0.5), size = 1000, replace = TRUE)



mission_app = data.frame(