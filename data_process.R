###############################################################################
#                         DATA PROCESSING SCRIPT
# This script contains functions used for manipulating and combining data sets.
# These functions are sourced by the master script.
###############################################################################

library("readr")
library("dplyr")
library("data.table")

# Read in Files (EDIT PREFIX)---------------------------------------------
prefix <- "C:/Users/Caitlyn/Box/Research/air_pollution/Datasets/"
file1 <- paste0(prefix,"ukbbPollutionLung_participant.tsv")
file2 <- paste0(prefix,"solid_all_0912.csv")
file3 <- paste0(prefix,"meta_data_forCaitlyn.txt")
file4 <- paste0(prefix,"heme.csv")

ukbb <- read_tsv(file1)
cancerSolid <- read_csv(file2)
demo <- read.delim(file3, header = TRUE, sep = "\t", dec = ".")
cancerHeme <- read_csv(file4)


# Merge Cancer Data -------------------------------------------------------

#Combine cancer records
cancer <- rbind(cancerSolid, cancerHeme)
rm(cancerSolid,cancerHeme)
cancer$eid <- as.integer(cancer$eid)


# Merge UKBB and Demographic Data -----------------------------------------

#Add column labels to UKBB data
names(ukbb) <- c('eid', 'townsend', 'bmi', 'householdIncomeCat', 'dateAssesment',
                 'pm10_2007', 'pm10_2010', 'pm25Absorb_2010', 'pm25_2010',
                 'pmcourse_2010', 'no2_2005', 'no2_2006', 'no2_2007',
                 'no2_2010', 'no1_2010', 'fuel', 'education',
                 'exposeSmokeHomeRaw', 'timeCurrentAddress')
ukbb$eid <- as.integer(ukbb$eid)

#Exclude variables from merge
genetic_princ_col <- grep("genetic_principal*", colnames(demo))
demo_2 <- demo %>% select(-c(raceRaw, dob, baselineDate, all_of(genetic_princ_col), batch))

df <-  merge(ukbb, demo_2, by="eid")
rm(ukbb, demo, demo_2)


# Generate New Variables -------------------------------------------------

#Define pollution increase per micro-gram/m^3 increment
attach(df)
df$pm10_2007per10 <- pm10_2007 / 10
df$pm10_2010per10 <- pm10_2010 / 10
df$pm25_2010per5 <- pm25_2010 / 5
df$pmcourse_2010per5 <- pmcourse_2010 / 5
df$no2_2005per10 <- no2_2005 / 10
df$no2_2006per10 <- no2_2006 / 10
df$no2_2007per10 <- no2_2007 / 10
df$no2_2010per10 <- no2_2010 / 10
df$no1_2010per20 <- no1_2010 /20
detach(df)

#Create censor date variable, dateCensor has unexpected values

#Define bmi category (Normal , Underweight, Overweight, Obese, NA) 
# df$bmiCat <- df$bmi
# <18.5
# 18.5-24.9
# 25–29.9
# >30 

#Define income category (Less than 31000, Greater than 31000, NA)
# df$incomeCat <- df$householdIncomeCat

#Age Category (Under 60, 60 or Over)
# df$ageCat

#Define education level category(Degree or professional education, Other levels, NA)
# df$educationCat


# Merge Cancer, UKBB Data -------------------------------------------------

#Exclude variables from merge
cancer_2 <- cancer %>% select(-baselineDate)

#Combine with cancer data
merged <- merge(df, cancer, all=TRUE)
merged$prior_cancer[is.na(merged$prior_cancer)] <- 0 #Coding NA as 0
merged$lung_cancer[is.na(merged$lung_cancer)] <- 0   #Coding NA as 0
rm(df, cancer, cancer_2)
gc()


# Filtering Out Prior Cancers, Duplicate Rows -----------------------------

#Filter out records with prior cancers
merged <- subset(merged, 
                 subset=merged$prior_cancer==0,
                 select=eid:t_lungCancer)

#If has lung cancer = cancer date, else NA 
merged$cancerDate_Lung[merged$lung_cancer==1] <- merged$cancerDate
merged$cancerDate_Lung[merged$lung_cancer==0] <- NA


#Sort by lung cancer date, eid
sorted1 <- merged[
  with(merged, order(merged$cancerDate_Lung, decreasing = FALSE, na.last=TRUE)),
]
sorted2 <- sorted1[
  with(sorted1, order(sorted1$eid, decreasing = FALSE, na.last=TRUE)),
]

#Remove duplicate eid
df2 <- sorted2[!duplicated(sorted2$eid), ]

rm(merged,sorted1,sorted2)
gc()

# Export RDS File ---------------------------------------------------------
saveRDS(df2, file = paste0(prefix,"pollution.rds"))
