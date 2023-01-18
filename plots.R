#______________________________________________________________________________
#                         PLOTTING SCRIPT
# This script contains functions used for visualization and analysis.
#______________________________________________________________________________


# Density Plot ------------------------------------------------------------
# Overlay multiple density plots function
plot_mult_density <- function(variable, data1, data2, data3=NULL){
  kd <- density(data1) #define kernel density
  plot(kd,
       col='blue',
       lwd=2,
       main = variable) #create kernel density plot
  kd2 <- density(data2)
  lines(kd2,
        col='red',
        lwd=2)
  if(!is.null(data3)){
    kd3 <- density(data3)
    lines(kd3,
          col='green',
          lwd=2)
  }
}

# x1 = na.omit(pm10_2007[df$lung_cancer==1])
# x2 = na.omit(pm10_2007[df$lung_cancer==0])
# plot_mult_density("pm10_2007 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
# 
# x1 = na.omit(pm10_2010[df$lung_cancer==1])
# x2 = na.omit(pm10_2010[df$lung_cancer==0])
# plot_mult_density("pm10_2010 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
# 
# x1 = na.omit(pm25_2010[df$lung_cancer==1])
# x2 = na.omit(pm25_2010[df$lung_cancer==0])
# plot_mult_density("pm25_2010 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
# 
# x1 = na.omit(pmcourse_2010[df$lung_cancer==1])
# x2 = na.omit(pmcourse_2010[df$lung_cancer==0])
# plot_mult_density("pmcourse_2010 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
# 
# x1 = na.omit(no2_2005[df$lung_cancer==1])
# x2 = na.omit(no2_2005[df$lung_cancer==0])
# plot_mult_density("no2_2005 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
# 
# x1 = na.omit(no2_2006[df$lung_cancer==1])
# x2 = na.omit(no2_2006[df$lung_cancer==0])
# plot_mult_density("no2_2006 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
# 
# x1 = na.omit(no2_2007[df$lung_cancer==1])
# x2 = na.omit(no2_2007[df$lung_cancer==0])
# plot_mult_density("no2_2007 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
# 
# x1 = na.omit(no2_2010[df$lung_cancer==1])
# x2 = na.omit(no2_2010[df$lung_cancer==0])
# plot_mult_density("no2_2010 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
# 
# x1 = na.omit(no1_2010[df$lung_cancer==1])
# x2 = na.omit(no1_2010[df$lung_cancer==0])
# plot_mult_density("no1_2010 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)

# Histogram ---------------------------------------------------------------
# hist(pm25_2010, 
#      main="Particulate matter air pollution (pm2.5) 2010",
#      xlab="PM2.5 (μg/m3)",
#      col="cadetblue",
#      freq=FALSE,
#      ylim=c(0,0.7))
# 
# #Plot lognormal distribution
# xfit <- seq(min(pm25_2010, na.rm = TRUE),
#             max(pm25_2010, na.rm = TRUE),
#             length = 40)
# yfit <- dlnorm(xfit,
#                meanlog = log(mean(pm25_2010)),
#                sdlog = log(sd(pm25_2010)))
# lines(xfit, yfit, col = "black", lwd = 2)

## AGE category overlay
# #define data
# x1 = na.omit(pm10_2007[ageBaseline>=60])
# x2 = na.omit(pm10_2007[ageBaseline<60])
# 
# #plot two histograms in same graph
# hist(x1, col='red', main='pm10_2007', xlab='(μg/m3)')
# hist(x2, col='green', add=TRUE)
# 
# #add legend
# legend('topright', c('60 or Over', 'Under 60'), fill=c('red', 'green'))
#The distribution is right-skewed and appears to be a log normal distribution.
