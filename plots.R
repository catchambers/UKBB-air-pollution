###############################################################################
#                         PLOTTING SCRIPT
# This script contains functions used for visualization and analysis.
###############################################################################


# Density Plots -----------------------------------------------------------
#Density plot function
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

# Histograms --------------------------------------------------------------

