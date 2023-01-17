#______________________________________________________________________________
#                             UTILITIES SCRIPT
# This script contains functions for basic setup, file handling, and user input.
#______________________________________________________________________________

do_setup <- function() {
  
}


# get_input <- function(){
#   input <-  readline(prompt = "Enter 1 for lung cancer, 2 for CHIP : ")
#   input <- as.integer(input)
#   if(input==1){
#     return("lung")
#   } else if(input==2){
#     return("ch")
#   }
# 
# }

export_excel <- function() {
  write_xlsx(df_pheno, "C:/Users/Caitlyn/Box/Research/air_pollution/Datasets/archive/df_pheno1.xlsx")
}


render_report = function(input) {
  rmarkdown::render("MyDocument.Rmd", params = "ask")
}