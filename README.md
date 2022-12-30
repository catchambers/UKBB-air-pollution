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
- [ ] Data processing for CH
- [ ] Update CH file when latest results become available (200k participants currently)
- [ ] Test running on cluster. Update filepaths as needed
- [ ] Paper uses exposeSmokeHomeImputed, bmiCat, and lungFamilyHistory. These variables haven't been generated
- [ ] Lung PRS

## Future Ideas
