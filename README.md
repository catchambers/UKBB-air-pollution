# Air Pollution and Health Outcomes in the UK Biobank
This project aims to recreate the following analysis associating long-term air pollution exposure with lung cancer risk: 
[Huang et al., “Air Pollution, Genetic Factors, and the Risk of Lung Cancer.”](https://www.atsjournals.org/doi/10.1164/rccm.202011-4063OC)

These methods will be extended to review the association between air pollution exposure and the risk of developing clonal hematopoesis.

## View Latest Report
To view the latest stable report, click master.md above.

## Workflow
### Do this once
- Fork this repository using your personal github account
- Clone the forked repository to access the codebase on your local machine
### Normal process for starting work
- Sync personal repository with lab repository
- Pull down changes
- Make changes in RStudio
- Commit changes
- Push to Github
- Make and accept a pull request to incorporate changes into lab repository

### Generate a New Report
- Open master.Rmd in RStudio
- Click dropdown on Knit, select "Knit with Parameters"
- Enter name and date. Select data to use and whether to include code in output
- Once report has been generated, review the temporary HTML

## Features to add
- [ ] Make bmiCat factor variable (Normal (<25 kg/m2), Overweight (25–29.9 kg/m2), Obesity (>=30 kg/m2, Missing value)
- [ ] Make pack-years of smoking numeric variable
- [ ] Simplify education levels. Include each participant in only one level. (Degree level or professional education, Other levels, Missing value)
- [ ] Simplify householdIncomeCat (Less than £31,000, £31,000 and above, Missing value)
- [ ] Simplify smokingCat (Never-smoker, Current or former smoker, Missing value)
- [ ] Simplify fuel (yes/no gas or solid-fuel cooking/heating in home, Missing value)
- [ ] Make exposeSmokeHome factor variable. Remove raw variable from model
- [ ] histology variable
- [ ] Table of population characteristics
- [ ] Incidence rate of phenotype
- [ ] Number of subjects excluded during filtering
- [ ] Number of subjects
- [ ] Distributions of all relevant variables
- [ ] Pearson correlation coefficients between pollutants
- [ ] Pearson correlation coefficients between covariates
- [ ] Data processing for CH
- [ ] Update CH file when latest results become available (200k participants currently)
- [ ] Test running on cluster. Update filepaths as needed
- [ ] Lung PRS - ask Xiaoyu for this data
- [ ] Check for violation of proportional hazard (constant HR over time)
- [ ] Model all pollutants
- [ ] Tabs for navigating between pollutants
- [ ] Stratified analyses (Sex, Age, Obesity, Smoking Status, Household Income, Histology)

## Future Ideas
- [ ] Explore Genetic Analysis of Time-to-Event phenotypes (GATE) Method to adjust for population structure, sample relatedness, and p-value inflation due to very low-frequency variants and heavily censored phenotypes
- [ ] Replace dense scatter plots with hexplots
- [ ] Generate exposeSmokeHomeImputed using mice package
- [ ] Sensitivity Analyses
