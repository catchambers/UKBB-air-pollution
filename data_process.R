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
      'pmcoarse_2010',
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
  df$pmcoarse_2010per5 <- pmcoarse_2010 / 5
  df$no2_2005per10 <- no2_2005 / 10
  df$no2_2006per10 <- no2_2006 / 10
  df$no2_2007per10 <- no2_2007 / 10
  df$no2_2010per10 <- no2_2010 / 10
  df$no1_2010per20 <- no1_2010 / 20
  detach(df)
    
  
  ## Define bmi category ---------------------------------------------------
  df <- df %>%
    mutate(bmiCat = case_when(bmi <= 18.5 ~ 'Underweight',
                              bmi <= 25 ~ 'Normal',
                              bmi <= 30 ~ 'Overweight',
                              bmi > 30 ~ 'Obese'))

  ## Define income category ------------------------------------------------
  # Reduce number of levels in householdIncomeCat
  df <- df %>%
    mutate(householdIncomeCat = case_when(
        householdIncomeCat == "18,000 to 30,999" ~ "Less than 31000",
        householdIncomeCat == "Less than 18,000" ~ "Less than 31000",
        householdIncomeCat == "31,000 to 51,999" ~ "Greater than 31000",
        householdIncomeCat == "52,000 to 100,000" ~ "Greater than 31000",
        householdIncomeCat == "Greater than 100,000" ~ "Greater than 31000")) 
  
  ## Age Category ----------------------------------------------------------

  df <- df %>%
    mutate(ageCat = case_when(
      ageBaseline < 60 ~ "Under 60",
      ageBaseline >= 60 ~ "60 or Over"
    ))
  
  ## Define education level category ---------------------------------------
  df <- df %>% 
    mutate(eduCat = case_when(
      grepl('professional', education) ~ 'Degree or professional education',
      grepl('NVQ', education) ~ 'Degree or professional education',
      grepl('College', education) ~ 'Degree or professional education',
      grepl('Prefer not to answer', education) ~ "",
      TRUE ~ 'Other levels')) %>%
    mutate(eduCat = ifelse(eduCat == "", NA, eduCat))#A levels, O levels, CSEs, None of the above
  
  # Merge Cancer, UKBB Data -------------------------------------------------
  
  ## Exclude variables from merge -------------------------------------------
  cancer2 <- cancer %>% select(-baselineDate)
  
  # Combine with cancer data
  merged <- merge(df, cancer2, all = TRUE)
  merged$prior_cancer[is.na(merged$prior_cancer)] <- 0 # Coding NA as 0
  merged$lung_cancer[is.na(merged$lung_cancer)] <- 0   # Coding NA as 0
  
  # Clean up environment
  rm(df, cancer, cancer2)
  gc()
    
  # Filtering ---------------------------------------------------------------
  
  ## Filter out records with prior cancers ----------------------------------
  merged <- subset(merged,
                   subset = merged$prior_cancer == 0,
                   select = eid:lung_cancer)
  
  # Return Data ----------------------------------------------------------
  
  ## Lung Cancer ------------------------------------------------------------
  if (selection == "LC") {
    
    ### Set lung cancer date ------------------------------------------------
    #merged$cancerDate_Lung[merged$lung_cancer == 1] <- merged$cancerDate
    #merged$cancerDate_Lung[merged$lung_cancer == 0] <- NA
    merged <- merged %>%
      mutate(cancerDate_Lung = case_when(lung_cancer == 1 ~ as.character(cancerDate),
                                         lung_cancer == 0 ~ NA_character_))
    
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
    
    ### Remove rows with duplicate id ---------------------------------------
    sorted3 <- sorted2[!duplicated(sorted2$eid), ]
    #Use distinct() instead?
    
    ### Censor Date ---------------------------------------------------------
    sorted3$cancerDate <- as.Date(anydate(sorted3$cancerDate))
    sorted3$date_of_death <- as.Date(sorted3$date_of_death)
    sorted3$dateCutoff <- as.Date(sorted3$dateCutoff)
    sorted3$dateLostFollowUp <- as.Date(sorted3$dateLostFollowUp)
    sorted3$cancerDate_Lung <- as.Date(anydate(sorted3$cancerDate_Lung))
    sorted3$dateAssesment <- as.Date(sorted3$dateAssesment)
    
    sorted3$censorDateNew <- pmin(sorted3$cancerDate,
                                  sorted3$date_of_death,
                                  sorted3$dateCutoff,
                                  sorted3$dateLostFollowUp,
                                  sorted3$cancerDate_Lung,
                                  na.rm = TRUE)
    
    ### LC after censor date ------------------------------------------------
    # Set LC to 0 if diagnosed after censoring
    sorted3 <- sorted3 %>%
      mutate(lung_cancer = case_when(censorDateNew >= cancerDate_Lung ~ as.numeric(lung_cancer),
                                     (censorDateNew < cancerDate_Lung ~ 0)))
    
    ### Time in Study -------------------------------------------------------
    sorted3$timeStudy <- as.numeric(difftime(sorted3$censorDateNew,
                                             sorted3$dateAssesment,
                                             unit="weeks")) / 52.25
    
    ### Return Data ---------------------------------------------------------
    return(sorted3)
    
    ### Combine and compare with Xiaoyu's data
    ukbbPM25 <- readRDS(paste0(prefix, "archive/ukbbPM25Lung.rds")) #Load Xiaoyu's data
    lung <- merge(sorted3, ukbbPM25, by="eid", all=T)
    write_xlsx(lung, "C:\\Users\\Caitlyn\\Box\\Research\\air_pollution\\Datasets\\archive\\lung.xlsx")
    
    # Time in study matched with some rounding differences
    
    # C total cases LC -- 4081
    # X total cases LC -- 2707
      # X had LC, C had LC -- 2640
      # X had LC, C did not -- 67
      # C had LC, X did not -- 357
      # C had LC, X not in dataset -- 1084
         # C: LC date after censorDateNew -- 163 (added code to fix this)
         # Cancer after baseline and prior to LC --
    
    # C participants that X didn't have in dataset -- 51981
    # X had in dataset, no LC. C didn't have in dataset -- 809
    
    # cancerDate_Lung not NA -- 568
    
  ## Clonal Hematopoiesis ---------------------------------------------------
  } else if (selection == "CH") {
    # CH 450K
    CH1 = fread(paste0(prefix, "ukbb.passed.Irenaeus_script.tsvukbb.review.Irenaeus_script_1_3_2023.tsv")) %>%
      filter(CH_KB==1) %>%
      select(c("sample_id","key","CHROM", "POS", "REF", "ALT","VariantClass","Gene","AAchange.y","germline_KB","artifact_KB","CH_KB",
               "Vardict_gt_AF", "Mutect2_gt_AF","VARIANT_CLASS_VEP","PON_FISHER","Mutect2_CALLER","Mutect2_PASS","Vardict_CALLER","Vardict_PASS",
               "ch_my_pd","ch_pd","ch_pd2"))
    colnames(CH1) = c("sample_id","key","CHROM", "POS", "REF", "ALT","consequence","Gene","AAchange","germline_KB","artifact_KB","CH_KB","Vardict_gt_AF",
                      "Mutect2_gt_AF","VARIANT_CLASS_VEP","PON_FISHER","Mutect2_CALLER","Mutect2_PASS","Vardict_CALLER","Vardict_PASS",
                      "ch_my_pd","ch_pd","ch_pd2")
    
    CH2 = fread(paste0(prefix, "ukbb.passed.Irenaeus_script.tsv")) %>%
      mutate(germline_KB=0,
             artifact_KB=0,
             CH_KB=1) %>%
      select(c("sample_id","key","CHROM", "POS", "REF", "ALT","VariantClass","Gene","AAchange.y","germline_KB","artifact_KB","CH_KB",
               "Vardict_gt_AF", "Mutect2_gt_AF","VARIANT_CLASS_VEP","PON_FISHER","Mutect2_CALLER","Mutect2_PASS","Vardict_CALLER","Vardict_PASS",
               "ch_my_pd","ch_pd","ch_pd2"))
    colnames(CH2) = c("sample_id","key","CHROM", "POS", "REF", "ALT","consequence","Gene","AAchange","germline_KB","artifact_KB","CH_KB","Vardict_gt_AF",
                      "Mutect2_gt_AF","VARIANT_CLASS_VEP","PON_FISHER","Mutect2_CALLER","Mutect2_PASS","Vardict_CALLER","Vardict_PASS",
                      "ch_my_pd","ch_pd","ch_pd2")
    
    CH = rbind(CH1,CH2) %>% distinct() %>% filter(PON_FISHER<0.05)
    
    ### Set diagnosis date --------------------------------------------------
    
    ### Sort by diagnosis cancer date ---------------------------------------
    
    ### Sort by participant id ----------------------------------------------
    
    ### Remove rows with duplicate id and return data -----------------------
    
  }
  
  # Clean up environment
  rm(merged, sorted1, sorted2, sorted3)
  gc()
}
