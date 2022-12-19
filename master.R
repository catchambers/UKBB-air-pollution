###############################################################################
#                             MASTER SCRIPT
# Run multiple R scripts from this file. Documents how R Markdown files were
# produced for multiple different runs.
#
# Condition "L": Run lung cancer analysis
# Condition "C": Run CHIP analysis
###############################################################################

#Take input from user
var = readline(prompt = "Enter L for lung, C for CHIP: ")
##add input validation
##test

if(var=="L"){
  source()
  ##add files to source
} else if(var=="C"){
  source()
  ##add files to source
}