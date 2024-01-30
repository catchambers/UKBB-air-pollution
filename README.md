# Air Pollution and Health Outcomes in the UK Biobank
This project aims to recreate the following analysis associating long-term air pollution exposure with lung cancer risk: 
[Huang et al., “Air Pollution, Genetic Factors, and the Risk of Lung Cancer.”](https://www.atsjournals.org/doi/10.1164/rccm.202011-4063OC)

These methods will be extended to review the association between air pollution exposure and the risk of developing clonal hematopoesis.

### Generate a New Report
- Open data_process.R, change prefix path to match username, save
- Open master.Rmd in RStudio
- Click dropdown on Knit, select "Knit with Parameters"
- Select data to use and whether to include code in output
- Once report has been generated, review the temporary HTML

## Features to add
- [x] Make bmiCat factor variable (Normal (<25 kg/m2), Overweight (25–29.9 kg/m2), Obesity (>=30 kg/m2, Missing value)
- [x] Find average pack-years of smoking
- [x] Simplify education levels. Include each participant in only one level. (Degree level or professional education, Other levels, Missing value)
- [x] Simplify householdIncomeCat (Less than £31,000, £31,000 and above, Missing value)
- [x] Simplify smokingCat (Never-smoker, Current or former smoker, Missing value)
- [x] Make categorical variables into factors and set reference level
- [ ] Simplify fuel (yes/no gas or solid-fuel cooking/heating in home, Missing value)
- [ ] Make exposeSmokeHome factor variable. Remove raw variable from model
- [ ] histology variable
- [ ] Include genetic component variables
- [x] Table of population characteristics using table1
- [ ] Incidence rate of phenotype
- [x] Number of subjects excluded during filtering
- [ ] Distributions of all relevant variables
- [ ] Pearson correlation coefficients between pollutants
- [ ] Pearson correlation coefficients between covariates
- [ ] Data processing for CH (CH missing if exome failed. CH-PD = CH=1 & PD=1)
- [x] Update CH file when latest results become available (200k participants currently)
- [ ] Test running on cluster. Update file paths as needed
- [ ] Lung PRS - ask Xiaoyu for this data
- [ ] Check for violation of proportional hazard (constant HR over time)
- [ ] Model all pollutants, including genetic components
- [ ] Tabs for navigating between pollutants
- [ ] Stratified analyses (Sex, Age, Obesity, Smoking Status, Household Income, Histology)
- [ ] Consider whether common skin cancers should by included in prior cancer filtering

## Future Ideas
- [ ] Explore Genetic Analysis of Time-to-Event phenotypes (GATE) Method to adjust for population structure, sample relatedness, and p-value inflation due to very low-frequency variants and heavily censored phenotypes
- [ ] Replace dense scatter plots with hexplots
- [ ] Generate exposeSmokeHomeImputed using mice package
- [ ] Sensitivity Analyses
- [ ] Host data using Github Large Files
