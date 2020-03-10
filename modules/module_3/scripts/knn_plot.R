# knn-plot for module 3
# Keaton Wilson
# keatonwilson@me.com
# 2020-03-10

#packages
library(mass)
library(class)
library(tidyverse)

# function to make a plot when you put in model and data


knn_plot = function(data, model){
  
  # separating data into predictors and classes
  train = as.data.frame(data[,-1])
  cl = data[,1] %>% pull()
  
  # test grid
  test = expand.grid(x=seq(min(train[,1]-0.5), max(train[,1]+0.5),
                            by=0.1),
                      y=seq(min(train[,2]-0.5), max(train[,2]+0.5), 
                            by=0.1))
  
  # loading model
  classif = model
  
  prob = attr(classif, "prob")
  
  dataf <- bind_rows(mutate(test,
                            prob=prob,
                            cls="Budget Collars LLC",
                            prob_cls=ifelse(classif==cls,
                                            1, 0)),
                     mutate(test,
                            prob=prob,
                            cls="Collarium Inc.",
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
               data=data.frame(x=train[,1], y=train[,2], cls=cl))
  
}



#Manual testing
# knn_data = knn_data
# mod_test = knn(train, test, cl, k = 7, prob=TRUE)
# 
# 
# knn_plot(data = knn_data, model = mod_test)
