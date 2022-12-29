###############################################################################
#                             UTILITIES SCRIPT
# This script contains functions for basic setup, file handling, and user input.
###############################################################################

do_setup <- function(){
  
}

# User Input --------------------------------------------------------------

get_input <- function(){
  input <-  readline(prompt = "Enter 1 for lung cancer, 2 for CHIP : ")
  input <- as.integer(input)
  return(input)
}
