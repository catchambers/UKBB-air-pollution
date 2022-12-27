###############################################################################
#                             UTILITIES SCRIPT
# This script contains functions for basic file handling and user input.
# These functions are sourced by the master script.
###############################################################################

# Set Working Directory ---------------------------------------------------

library("rstudioapi")
setwd(dirname(getActiveDocumentContext()$path)) #set cwd to master file location

# User Input --------------------------------------------------------------

input <-  readline(prompt = "Enter 1 for lung cancer, 2 for CHIP : ")
input <- as.integer(input)

# Source Files ------------------------------------------------------------

if(input==1){
  print("Running Lung Cancer Analysis")
  source("lung_data_process.R")
  source("lung_plot.R")

} else if(input==2){
  print("Running CHIP Analysis")
  source("chip_data_process.R")
  source("chip_plot.R")
  
}