library("readr")
library("dplyr")
library("data.table")

file1 <- "C:/Users/Caitlyn/Box/Research/air_pollution/Datasets/ukbbPollutionLung_participant.tsv"
file2 <- "C:/Users/Caitlyn/Box/Research/air_pollution/Datasets/solid_all_0912.csv"
file3 <- "C:/Users/Caitlyn/Box/Research/air_pollution/Datasets/meta_data_forCaitlyn.txt"
file4 <- "C:/Users/Caitlyn/Box/Research/air_pollution/Datasets/heme.csv"

ukbb <- read_tsv(file1)
cancerSolid <- read_csv(file2)
demo <- read.delim(file3, header = TRUE, sep = "\t", dec = ".")
cancerHeme <- read_csv(file4)

#Combine all cancer records
cancer <- rbind(cancerSolid, cancerHeme)
rm(cancerSolid,cancerHeme)
cancer$eid <- as.integer(cancer$eid)

#Add column labels to UK Biobank data
names(ukbb) <- c('eid', 'townsend', 'bmi', 'householdIncomeCat', 'dateAssesment', 'pm10_2007', 'pm10_2010',
               'pm25Absorb_2010', 'pm25_2010', 'pmcourse_2010', 'no2_2005', 'no2_2006', 'no2_2007',
               'no2_2010', 'no1_2010', 'fuel', 'education', 'exposeSmokeHomeRaw', 'timeCurrentAddress')
ukbb$eid <- as.integer(ukbb$eid)


#Merge UKBB data sets
excludeVars <- names(demo) %in% c("raceRaw",
                                  "dob",
                                  "baselineDate",
                                  "genetic_principal_components_f22009_0_1",
                                  "genetic_principal_components_f22009_0_2",
                                  "genetic_principal_components_f22009_0_3",
                                  "genetic_principal_components_f22009_0_4",
                                  "genetic_principal_components_f22009_0_5",
                                  "genetic_principal_components_f22009_0_6",
                                  "genetic_principal_components_f22009_0_7",
                                  "genetic_principal_components_f22009_0_8",
                                  "genetic_principal_components_f22009_0_9",
                                  "genetic_principal_components_f22009_0_10",
                                  "batch")
demo <- demo[!excludeVars]
df <-  merge(ukbb, demo, by="eid")
rm(ukbb, demo)


#Define pollution increase per micro-gram/m^3 increase
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

#Define bmi category (Normal , Underweight, Overweight, Obese, NA) 
# df$bmiCat <- df$bmi
# <18.5
# 18.5-24.9
# 25–29.9
# >30 

#Define income category (Less than 31000, Greater than 31000, NA)
# df$incomeCat <- df$householdIncomeCat

# #Age Category (Under 60, 60 or Over)
# ageCat

#Define education level category(Degree or professional education, Other levels, NA)
#educationCat


#Combine with cancer data
# merged <- data.table(df, key="eid")[data.table(cancer, key="eid"), allow.cartesian=TRUE]
merged <- merge(df, cancer, all=TRUE)
merged$prior_cancer[is.na(merged$prior_cancer)] <- 0
merged$lung_cancer[is.na(merged$lung_cancer)] <- 0
rm(df, cancer)
gc()


#Filter out records with prior cancers
merged <- subset(merged, subset=merged$prior_cancer==0,
                         select=eid:t_lungCancer)

#Sort by cancer date, then eid

#If has lung cancer = cancer date, else NA 
merged$cancerDate_Lung[merged$lung_cancer==1] <- merged$cancerDate
merged$cancerDate_Lung[merged$lung_cancer==0] <- NA

#Create sensor date variable


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

#Subset NOx data set

#Subset PM data set


#Export to RDS file
write.csv(df2, file =  "C:/Users/Caitlyn/Box/Research/air_pollution/Datasets/pollution.csv", row.names = FALSE)
saveRDS(df2, file = "C:/Users/Caitlyn/Box/Research/air_pollution/Datasets/pollution.rds")
# saveRDS(df_nox, file = "C:/Users/Caitlyn/Box/Research/air_pollution/Datasets/NOx.rds")
# saveRDS(df_pm, file = "C:/Users/Caitlyn/Box/Research/air_pollution/Datasets/PM.rds")