#______________________________________________________________________________
#                         DATA PROCESSING SCRIPT
# This script contains functions used for manipulating and combining data sets.
#______________________________________________________________________________

get_data <- function(selection) {
  
  # Read in Files -----------------------------------------------------------
  prefix <- "C:/Users/Caitlyn/Box/Research/air_pollution/Datasets/"
  
  # Biobank export
  file1 <- paste0(prefix,
                  "ukbbPollutionLung_participant.tsv")
  
  # solid tumors
  file2 <- paste0(prefix,
                  "solid_all_0912.csv") 
  
  # additional demographic data
  file3 <- paste0(prefix, 
                  "meta_data_forCaitlyn.txt")
  
  # hematologic cancers
  file4 <- paste0(prefix, 
                  "heme.csv") 
  
  # CH for 250k, update pending
  file5 <- paste0(prefix, 
                  "CH450K_1111.txt")  
    
  ukbb <- read_tsv(file1)
  cancerSolid <- read_csv(file2)
  demo <- read.delim(file3,
                     header = TRUE,
                     sep = "\t",
                     dec = ".")
  cancerHeme <- read_csv(file4)
  
  # Clean up environment
  rm(file1, file2, file3, file4, file5)
    
  # Merge Cancer Data -------------------------------------------------------
  
  # Combine solid and heme cancer records
  cancer <- rbind(cancerSolid, cancerHeme)
  rm(cancerSolid, cancerHeme)
  cancer$eid <- as.integer(cancer$eid)
  
  # Merge UKBB and Demographic Data -----------------------------------------
  
  ## Add column labels to UKBB data -----------------------------------------
  names(ukbb) <-
    c(
      'eid',
      'townsend',
      'bmi',
      'householdIncomeCat',
      'dateAssesment',
      'pm10_2007',
      'pm10_2010',
      'pm25Absorb_2010',
      'pm25_2010',
      'pmcourse_2010',
      'no2_2005',
      'no2_2006',
      'no2_2007',
      'no2_2010',
      'no1_2010',
      'fuel',
      'education',
      'exposeSmokeHomeRaw',
      'timeCurrentAddress'
    )
  ukbb$eid <- as.integer(ukbb$eid)
    
  ## Exclude variables from merge ------------------------------------------
  genetic_princ_col <- grep("genetic_principal*", colnames(demo))
  demo_2 <- demo %>% select(-c(raceRaw, dob, baselineDate, all_of(genetic_princ_col), batch))
  
  df <-  merge(ukbb, demo_2, by = "eid")
  rm(ukbb, demo, demo_2, genetic_princ_col)
    
    
  # Generate New Variables -------------------------------------------------
  
  ## Define pollution increase per micro-gram/m^3 increment ----------------
  attach(df)
  df$pm10_2007per10 <- pm10_2007 / 10
  df$pm10_2010per10 <- pm10_2010 / 10
  df$pm25_2010per5 <- pm25_2010 / 5
  df$pmcourse_2010per5 <- pmcourse_2010 / 5
  df$no2_2005per10 <- no2_2005 / 10
  df$no2_2006per10 <- no2_2006 / 10
  df$no2_2007per10 <- no2_2007 / 10
  df$no2_2010per10 <- no2_2010 / 10
  df$no1_2010per20 <- no1_2010 / 20
  detach(df)
    
  ## Create censor date variable, dateCensor has unexpected values ---------
  #df %>% censorDate
  
  ## Define bmi category ---------------------------------------------------
  df <- df %>%
    mutate(bmiCat = case_when(bmi <= 18.5 ~ 'Underweight',
                              bmi <= 25 ~ 'Normal',
                              bmi <= 30 ~ 'Overweight',
                              bmi > 30 ~ 'Obese'))

  ## Define income category ------------------------------------------------
  # Reduce number of levels in householdIncomeCat
  df <- df %>%
    mutate(
      householdIncomeCat = case_when(
        householdIncomeCat == "18,000 to 30,999" |
          householdIncomeCat == "Less than 18,000" ~ "Less than 31000",
        householdIncomeCat == "31,000 to 51,999" |
          householdIncomeCat == "52,000 to 100,000" |
          householdIncomeCat == "Greater than 100,000" ~ "Greater than 31000"))
  
  ## Age Category ----------------------------------------------------------
  # df$ageCat
  # Under 60
  # 60 or Over
  
  ## Define education level category ---------------------------------------
  # df$educationCat
  # Degree or professional education
  # Other levels
  # NA
  
    
  # Merge Cancer, UKBB Data -------------------------------------------------
  
  ## Exclude variables from merge -------------------------------------------
  cancer_2 <- cancer %>% select(-baselineDate)
  
  # Combine with cancer data
  merged <- merge(df, cancer, all = TRUE)
  merged$prior_cancer[is.na(merged$prior_cancer)] <- 0 # Coding NA as 0
  merged$lung_cancer[is.na(merged$lung_cancer)] <- 0   # Coding NA as 0
  
  # Clean up environment
  rm(df, cancer, cancer_2)
  gc()
    
    
  # Filtering ---------------------------------------------------------------
  
  ## Filter out records with prior cancers ----------------------------------
  merged <- subset(merged,
                   subset = merged$prior_cancer == 0,
                   select = eid:t_lungCancer)
  
  # Returning Data ----------------------------------------------------------
  
  ## Lung Cancer ------------------------------------------------------------
  if (selection == "LC") {
    
    ### Set lung cancer date ------------------------------------------------
    merged$cancerDate_Lung[merged$lung_cancer == 1] <- merged$cancerDate
    merged$cancerDate_Lung[merged$lung_cancer == 0] <- NA
    
    
    ### Sort by lung cancer date --------------------------------------------
    sorted1 <- merged[with(merged,
                           order(
                             merged$cancerDate_Lung,
                             decreasing = FALSE,
                             na.last = TRUE
                           )), ]
    
    ### Sort by participant id ----------------------------------------------
    sorted2 <- sorted1[with(sorted1,
                            order(
                              sorted1$eid,
                              decreasing = FALSE,
                              na.last = TRUE
                              )), ]
    
    ### Remove rows with duplicate id and return data -----------------------
    return(sorted2[!duplicated(sorted2$eid), ])
    
  ## Clonal Hematopoiesis ---------------------------------------------------
  } else if (selection == "CH") {
    
    ### Set diagnosis date --------------------------------------------------
    
    ### Sort by diagnosis cancer date ---------------------------------------
    
    ### Sort by participant id ----------------------------------------------
    
    ### Remove rows with duplicate id and return data -----------------------
    
  }
  
  # Clean up environment
  rm(merged, sorted1, sorted2)
  gc()
}
