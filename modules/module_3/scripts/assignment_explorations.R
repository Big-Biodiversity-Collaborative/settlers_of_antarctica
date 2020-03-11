wind_turbines = read_csv("./modules/module_3/data/wind_turbines.csv")

wind_turbines %>%
  group_by(maker) %>%
  summarize(mean_ws = mean(wind_speed), 
            mean_po = mean(power_output), 
            max_power = max(power_output), 
            variance = sd(power_output))

ggplot(data = wind_turbines, mapping = aes(x = maker, y = wind_speed)) +
  geom_boxplot(outlier.shape = NULL) +
  geom_jitter(width = 0.1)


t.test(wind_speed ~ maker, data = wind_turbines)
t.test(power_output ~ maker, data = wind_turbines)

ggplot(data = wind_turbines, mapping = aes(x = wind_speed, y = power_output, 
                                           color = maker)) +
  geom_point()

library(class)
nor <-function(x){
  (x -min(x))/(max(x)-min(x))
}

train = wind_turbines %>%
  transmute(wind_speed_norm = nor(wind_speed), 
         power_output = nor(power_output))

cl = wind_turbines %>%
  select(maker) %>%
  pull()

test = expand.grid(x=seq(min(train[,1]-0.5), max(train[,1]+0.5),
                         by=0.1),
                   y=seq(min(train[,2]-0.5), max(train[,2]+0.5), 
                         by=0.1))

mod = knn(train = train, test = test, cl = cl, k = 5, prob = TRUE)
mod2 = knn(train = train, test = test, cl = cl, k = 9, prob = TRUE)
mod3 = knn(train = train, test = test, cl = cl, k = 3, prob = TRUE)




# knn-plot for module 3
# Keaton Wilson
# keatonwilson@me.com
# 2020-03-10

#packages
library(MASS)
library(class)
library(tidyverse)

# function to make a plot when you put in model and data


knn_plot = function(data, model){
  
  train = data %>%
    transmute(wind_speed_norm = nor(wind_speed), 
              power_output = nor(power_output)) %>%
    as.data.frame()
  
  cl = data %>%
    dplyr::select(maker) %>%
    pull()
  
  test = expand.grid(x=seq(min(train[,1]-0.5), max(train[,1]+0.5),
                           by=0.1),
                     y=seq(min(train[,2]-0.5), max(train[,2]+0.5), 
                           by=0.1))
  
  # loading model
  classif = model
  
  prob = attr(classif, "prob")
  
  dataf <- bind_rows(mutate(test,
                            prob=prob,
                            cls="Turbines turbines turbines Inc",
                            prob_cls=ifelse(classif==cls,
                                            1, 0)),
                     mutate(test,
                            prob=prob,
                            cls="Turbo turbines",
                            prob_cls=ifelse(classif==cls,
                                            1, 0)))
  print("Ready to plot")
  print(dataf)
  
  ggplot(dataf) +
    geom_point(aes(x=x, y=y, col=cls, size=prob),
               data = mutate(test, cls=classif)) +
    scale_size(range=c(0.8, 2)) +
    geom_contour(aes(x=x, y=y, z=prob_cls, group=cls, color=cls),
                 bins=2,
                 data=dataf) +
    geom_point(aes(x=x, y=y, col=cls),
               size=3,
               data=data.frame(x=train[,1], y=train[,2], cls=cl)) +
    geom_point(aes(x=x, y=y),
               size=3, shape=1,
               data=data.frame(x=train[,1], y=train[,2], cls=cl)) +
    xlab("Normalized Wind Speed") +
    ylab("Power output")
  
}


knn_plot(wind_turbines, model = mod)
knn_plot(wind_turbines, model = mod2)
knn_plot(wind_turbines, model = mod3)
