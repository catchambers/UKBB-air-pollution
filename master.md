Air Pollution and Health Outcomes in the UK Biobank
================
Caitlyn Chitwood -
January 05, 2023

- <a href="#descriptive-statistics"
  id="toc-descriptive-statistics">Descriptive Statistics</a>
  - <a href="#summary-statistics" id="toc-summary-statistics">Summary
    Statistics</a>
  - <a href="#density-plots" id="toc-density-plots">Density Plots</a>
  - <a href="#histograms" id="toc-histograms">Histograms</a>
  - <a href="#scatter-plots-and-correlation-coefficients-pollutants"
    id="toc-scatter-plots-and-correlation-coefficients-pollutants">Scatter
    Plots and Correlation Coefficients: pollutants</a>
  - <a
    href="#scatter-plots-and-correlation-coefficients-pollutants-and-covariates"
    id="toc-scatter-plots-and-correlation-coefficients-pollutants-and-covariates">Scatter
    Plots and Correlation Coefficients: pollutants and covariates</a>
  - <a href="#pm-25" id="toc-pm-25">PM 2.5</a>
    - <a href="#box-plot" id="toc-box-plot">Box Plot</a>
    - <a href="#qq-plot" id="toc-qq-plot">QQ Plot</a>
    - <a href="#outliers" id="toc-outliers">Outliers</a>
    - <a
      href="#correlation-coefficients-pollutant-extreme-outliers-and-covariates"
      id="toc-correlation-coefficients-pollutant-extreme-outliers-and-covariates">Correlation
      Coefficients: pollutant extreme outliers and covariates</a>
    - <a
      href="#correlation-coefficients-pollutant-mild-outliers-and-covariates"
      id="toc-correlation-coefficients-pollutant-mild-outliers-and-covariates">Correlation
      Coefficients: pollutant mild outliers and covariates</a>
- <a href="#regression-cox-proportional-hazards-model"
  id="toc-regression-cox-proportional-hazards-model">Regression: Cox
  Proportional-Hazards Model</a>
  - <a href="#model-1-age-and-sex-covariates-only"
    id="toc-model-1-age-and-sex-covariates-only">Model 1: age and sex
    covariates only</a>
    - <a href="#pm25-2010" id="toc-pm25-2010">PM2.5 (2010)</a>
    - <a href="#pm25-2010-1" id="toc-pm25-2010-1">PM2.5 (2010)</a>
  - <a href="#model-2-multiple-covariates"
    id="toc-model-2-multiple-covariates">Model 2: multiple covariates</a>
- <a href="#citations" id="toc-citations">Citations</a>

Lung cancer data was used for the following analyses.

## Descriptive Statistics

### Summary Statistics

``` r
kable(head(df_pheno),
      caption = "A table showing first 6 rows of relevant variables.")
```

|     eid |  townsend |     bmi | householdIncomeCat   | dateAssesment | pm10_2007 | pm10_2010 | pm25Absorb_2010 | pm25_2010 | pmcourse_2010 | no2_2005 | no2_2006 | no2_2007 | no2_2010 | no1_2010 | fuel                                                                      | education                                                                                                                                             | exposeSmokeHomeRaw | timeCurrentAddress | dateLostFollowUp | dateCensor | dateCutoff | date_of_death | ageBaseline | race  | sex    | packYear | smokingCat                    | pm10_2007per10 | pm10_2010per10 | pm25_2010per5 | pmcourse_2010per5 | no2_2005per10 | no2_2006per10 | no2_2007per10 | no2_2010per10 | no1_2010per20 | baselineDate | dob        | cancerDate | cancerICD10 | cancerHistology | cancerBehaviour         | meaning                              | ICD10group | prior_cancer | lung_cancer | t_lungCancer | cancerDate_Lung |
|--------:|----------:|--------:|:---------------------|:--------------|----------:|----------:|----------------:|----------:|--------------:|---------:|---------:|---------:|---------:|---------:|:--------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------|:-------------------|:-----------------|:-----------|:-----------|:--------------|------------:|:------|:-------|---------:|:------------------------------|---------------:|---------------:|--------------:|------------------:|--------------:|--------------:|--------------:|--------------:|--------------:|:-------------|:-----------|:-----------|:------------|----------------:|:------------------------|:-------------------------------------|:-----------|-------------:|------------:|-------------:|:----------------|
| 1000018 | -4.517900 | 24.1274 | 31,000 to 51,999     | 2009-05-23    |     24.13 |     15.98 |            1.15 |     10.32 |          6.00 |    29.48 |    29.65 |    30.31 |    29.92 |    46.81 | A gas hob or gas cooker                                                   | O levels/GCSEs or equivalent\|NVQ or HND or HNC or equivalent                                                                                         | 0                  | 4                  | NA               | 2020-02-29 | 2020-02-29 | NA            |    43.51814 | White | Male   |       NA | Past smoker unknown pack year |          2.413 |          1.598 |         2.064 |             1.200 |         2.948 |         2.965 |         3.031 |         2.992 |        2.3405 | 5/23/2009    | 11/15/1965 | 7/23/2015  | C822        |            9698 | Malignant, primary site | C82.2 Large cell, follicular         | NA         |            0 |           0 |           NA | NA              |
| 1000020 | -3.607660 | 28.9216 | 31,000 to 51,999     | 2007-08-03    |     21.08 |     17.15 |            1.00 |      9.37 |          6.70 |    20.61 |    19.94 |    21.93 |    17.50 |    33.00 | None of the above                                                         | CSEs or equivalent                                                                                                                                    | 0                  | 27                 | NA               | 2020-02-29 | 2020-02-29 | NA            |    57.13347 | White | Female |     0.00 | Never smoker                  |          2.108 |          1.715 |         1.874 |             1.340 |         2.061 |         1.994 |         2.193 |         1.750 |        1.6500 | NA           | NA         | NA         | NA          |              NA | NA                      | NA                                   | NA         |            0 |           0 |           NA | NA              |
| 1000037 | -1.198350 | 32.7558 | Prefer not to answer | 2009-11-05    |     25.50 |     14.04 |            0.89 |      9.54 |          5.61 |    19.12 |    18.02 |    20.65 |    19.66 |    38.84 | A gas hob or gas cooker                                                   | O levels/GCSEs or equivalent                                                                                                                          | 45                 | 21                 | NA               | 2020-02-29 | 2020-02-29 | NA            |    60.05749 | White | Female |    76.00 | Past smoker \>19 pack year    |          2.550 |          1.404 |         1.908 |             1.122 |         1.912 |         1.802 |         2.065 |         1.966 |        1.9420 | 11/5/2009    | 10/15/1949 | 10/22/2013 | C504        |            8500 | Malignant, primary site | C50.4 Upper-outer quadrant of breast | C50        |            0 |           0 |           NA | NA              |
| 1000043 |  4.682530 | 26.7563 | 52,000 to 100,000    | 2007-05-12    |     26.95 |     16.66 |            1.43 |     10.38 |          6.24 |    50.80 |    48.50 |    53.12 |    34.31 |    51.70 | None of the above                                                         | College or University degree                                                                                                                          | 0                  | 7                  | NA               | 2020-02-29 | 2020-02-29 | NA            |    60.82409 | White | Male   |       NA | Past smoker unknown pack year |          2.695 |          1.666 |         2.076 |             1.248 |         5.080 |         4.850 |         5.312 |         3.431 |        2.5850 | NA           | NA         | NA         | NA          |              NA | NA                      | NA                                   | NA         |            0 |           0 |           NA | NA              |
| 1000051 | -1.003240 | 28.3711 | Prefer not to answer | 2008-01-11    |     20.03 |     17.23 |            1.36 |     10.58 |          6.49 |    26.38 |    25.73 |    26.38 |    33.02 |    52.70 | A gas hob or gas cooker\|A gas fire that you use regularly in winter time | College or University degree\|A levels/AS levels or equivalent\|O levels/GCSEs or equivalent\|Other professional qualifications eg: nursing, teaching | 0                  | 43                 | NA               | 2020-02-29 | 2020-02-29 | 2015-10-19    |    67.73990 | White | Male   |     5.20 | Past smoker 1-19 pack year    |          2.003 |          1.723 |         2.116 |             1.298 |         2.638 |         2.573 |         2.638 |         3.302 |        2.6350 | 1/11/2008    | 4/15/1940  | 9/10/2015  | C930        |            9891 | Malignant, primary site | C93.0 Acute monocytic leukaemia      | NA         |            0 |           0 |           NA | NA              |
| 1000066 | -0.541713 | 42.4953 | 18,000 to 30,999     | 2007-05-08    |     22.85 |     14.56 |            0.98 |      9.84 |          5.84 |    25.57 |    23.88 |    26.49 |    23.43 |    31.54 | A gas hob or gas cooker                                                   | O levels/GCSEs or equivalent\|CSEs or equivalent\|NVQ or HND or HNC or equivalent                                                                     | NA                 | 10                 | NA               | 2020-02-29 | 2020-02-29 | NA            |    42.89391 | White | Female |    18.75 | Current smoker 1-19 pack year |          2.285 |          1.456 |         1.968 |             1.168 |         2.557 |         2.388 |         2.649 |         2.343 |        1.5770 | NA           | NA         | NA         | NA          |              NA | NA                      | NA                                   | NA         |            0 |           0 |           NA | NA              |

A table showing first 6 rows of relevant variables.

There are 4081 cases of lung cancer in the data set.

### Density Plots

``` r
kd_male <- density(na.omit(pm10_2007[sex=="Male"])) #define kernel density
plot(kd_male,
     col='blue',
     lwd=2,
     main = "Female/Male PM10_2007") #create kernel density plot
kd_female <- density(na.omit(pm10_2007[sex=="Female"]))
lines(kd_female,
      col='red',
      lwd=2)
```

![](master_files/figure-gfm/density-plot-sex-1.png)<!-- -->

``` r
# fill in kernel density plot with specific color
# polygon(kd_male, col='blue', border='black')
# polygon(kd_female, col='red', border='black')
```

``` r
x1 = na.omit(pm10_2007[ageBaseline>=60])
x2 = na.omit(pm10_2007[ageBaseline<60])
plot_mult_density("pm10_2007 (blue=60 or over, red=under 60)", x1,x2)
```

![](master_files/figure-gfm/density-plots-1.png)<!-- -->

### Histograms

``` r
#define data
x1 = na.omit(pm10_2007[ageBaseline>=60])
x2 = na.omit(pm10_2007[ageBaseline<60])

#plot two histograms in same graph
hist(x1, col='red', main='pm10_2007', xlab='(μg/m3)')
hist(x2, col='green', add=TRUE)

#add legend
legend('topright', c('60 or Over', 'Under 60'), fill=c('red', 'green'))
```

![](master_files/figure-gfm/histogram-age-1.png)<!-- -->

``` r
hist(pm25_2010, 
     main="Particulate matter air pollution (pm2.5) 2010",
     xlab="PM2.5 (μg/m3)",
     col="cadetblue",
     freq=FALSE,
     ylim=c(0,0.7))

#Plot lognormal distribution
xfit <- seq(min(pm25_2010, na.rm = TRUE),
            max(pm25_2010, na.rm = TRUE),
            length = 40)
yfit <- dlnorm(xfit,
               meanlog = log(mean(pm25_2010)),
               sdlog = log(sd(pm25_2010)))
lines(xfit, yfit, col = "black", lwd = 2)
```

![](master_files/figure-gfm/histogram-1.png)<!-- -->

The distribution is right-skewed and appears to be a log normal
distribution.

``` r
par(mfrow=c(3,3))
hist(pm10_2007, 
     xlab="pm10_2007 (μg/m3)",
     col="cadetblue",
     freq=FALSE)

hist(pm10_2010, 
     xlab="pm10_2010 (μg/m3)",
     col="cadetblue",
     freq=FALSE)

hist(pmcourse_2010, 
     xlab="pmcourse_2010 (μg/m3)",
     col="cadetblue",
     freq=FALSE)

hist(no2_2005, 
     xlab="no2_2005 (μg/m3)",
     col="cadetblue",
     freq=FALSE)

hist(no2_2006, 
     xlab="no2_2006 (μg/m3)",
     col="cadetblue",
     freq=FALSE)

hist(no2_2007, 
     xlab="no2_2007 (μg/m3)",
     col="cadetblue",
     freq=FALSE)

hist(no2_2010, 
     xlab="no2_2010 (μg/m3)",
     col="cadetblue",
     freq=FALSE)

hist(no1_2010, 
     xlab="no1_2010 (μg/m3)",
     col="cadetblue",
     freq=FALSE)

hist(pm25_2010, 
     xlab="PM2.5 (μg/m3)",
     col="cadetblue",
     freq=FALSE)
```

![](master_files/figure-gfm/histogram2-1.png)<!-- -->

### Scatter Plots and Correlation Coefficients: pollutants

``` r
plot(pm10_2010, no2_2010)
```

![](master_files/figure-gfm/scatterplot-PM10-NO2-1.png)<!-- -->

``` r
cor(pm10_2010, no2_2010, method="pearson", use="complete.obs")
```

    ## [1] 0.5055037

``` r
cor(pm10_2010, no2_2010, method="spearman", use="complete.obs")
```

    ## [1] 0.5398056

``` r
plot(pm10_2010,pm25_2010)
```

![](master_files/figure-gfm/scatterplot-PM10-PM2.5-1.png)<!-- -->

``` r
cor(pm10_2010, pm25_2010, method="pearson", use="complete.obs")
```

    ## [1] 0.5325037

``` r
cor(pm10_2010, pm25_2010, method="spearman", use="complete.obs")
```

    ## [1] 0.5687892

``` r
plot(no1_2010, no2_2010)
```

![](master_files/figure-gfm/scatterplot-NO1-NO2-1.png)<!-- -->

``` r
cor(no1_2010, no2_2010, method="pearson", use="complete.obs")
```

    ## [1] 0.9219059

``` r
cor(no1_2010, no2_2010, method="spearman", use="complete.obs")
```

    ## [1] 0.9144932

### Scatter Plots and Correlation Coefficients: pollutants and covariates

``` r
cor(pm25_2010, ageBaseline, use="pairwise.complete.obs")
```

    ## [1] -0.07250032

``` r
cor(pm25_2010, bmi, use="pairwise.complete.obs")
```

    ## [1] 0.04181106

``` r
cor(pm25_2010, packYear, use="pairwise.complete.obs")
```

    ## [1] 0.07892377

### PM 2.5

#### Box Plot

``` r
quantile(pm25_2010, na.rm=TRUE)
```

    ##    0%   25%   50%   75%  100% 
    ##  8.17  9.29  9.94 10.57 21.31

``` r
iqr <- IQR(pm25_2010, na.rm=TRUE)

boxplot(pm25_2010, 
        horizontal=TRUE,
        col="cadetblue")
```

![](master_files/figure-gfm/boxplot-1.png)<!-- -->

#### QQ Plot

``` r
qqnorm(pm25_2010)
qqline(pm25_2010)
```

![](master_files/figure-gfm/qqplot-1.png)<!-- -->

#### Outliers

``` r
extremeOut <- 3*iqr
mildOut <- 1.5*iqr

extremePM25 <- subset(df_pheno, pm25_2010 > (mean(pm25_2010, na.rm=TRUE)+ extremeOut))
mildPM25 <- subset(df_pheno, pm25_2010 > (mean(pm25_2010, na.rm=TRUE)+ mildOut))
```

There are 958 extreme outliers and 20992 mild outliers for PM2.5 data
from 2010.

#### Correlation Coefficients: pollutant extreme outliers and covariates

``` r
cor(extremePM25$pm25_2010, extremePM25$ageBaseline)
```

    ## [1] 0.04268743

``` r
cor(extremePM25$pm25_2010, extremePM25$bmi, use="pairwise.complete.obs")
```

    ## [1] 0.0300583

``` r
cor(extremePM25$pm25_2010, extremePM25$packYear, use="pairwise.complete.obs")
```

    ## [1] -0.01779504

#### Correlation Coefficients: pollutant mild outliers and covariates

``` r
cor(mildPM25$pm25_2010, mildPM25$ageBaseline, use="pairwise.complete.obs")
```

    ## [1] 0.003296757

``` r
cor(mildPM25$pm25_2010, mildPM25$bmi, use="pairwise.complete.obs")
```

    ## [1] -0.004101232

``` r
cor(mildPM25$pm25_2010, mildPM25$packYear, use="pairwise.complete.obs")
```

    ## [1] 0.009053578

``` r
rm(mildPM25, extremePM25)
```

## Regression: Cox Proportional-Hazards Model

### Model 1: age and sex covariates only

#### PM2.5 (2010)

``` r
res.model1 <- coxph(
  Surv(t_lungCancer, lung_cancer) ~  pm25_2010per5 + ageBaseline + sex,
  data = df_pheno,
  ties = "efron"
)
```

#### PM2.5 (2010)

### Model 2: multiple covariates

``` r
res.model2 <- coxph(
  Surv(t_lungCancer, lung_cancer) ~ pm25_2010per5 + ageBaseline + sex + householdIncomeCat + education + bmi + smokingCat,
  data = df_pheno,
  ties = "efron"
)
res.model2
```

    ## Call:
    ## coxph(formula = Surv(t_lungCancer, lung_cancer) ~ pm25_2010per5 + 
    ##     ageBaseline + sex + householdIncomeCat + education + bmi + 
    ##     smokingCat, data = df_pheno, ties = "efron")
    ## 
    ##                                                                                                                                                                                                  coef
    ## pm25_2010per5                                                                                                                                                                               -0.141782
    ## ageBaseline                                                                                                                                                                                  0.007852
    ## sexMale                                                                                                                                                                                      0.047993
    ## householdIncomeCat31,000 to 51,999                                                                                                                                                           0.012521
    ## householdIncomeCat52,000 to 100,000                                                                                                                                                         -0.001635
    ## householdIncomeCatDo not know                                                                                                                                                                0.009097
    ## householdIncomeCatGreater than 100,000                                                                                                                                                       0.039685
    ## householdIncomeCatLess than 18,000                                                                                                                                                          -0.032072
    ## householdIncomeCatPrefer not to answer                                                                                                                                                      -0.051286
    ## educationA levels/AS levels or equivalent|CSEs or equivalent                                                                                                                                -0.097310
    ## educationA levels/AS levels or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                         0.817108
    ## educationA levels/AS levels or equivalent|NVQ or HND or HNC or equivalent                                                                                                                    0.167925
    ## educationA levels/AS levels or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                            0.873592
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent                                                                                                                      -0.046041
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent                                                                                                   -0.030024
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent                                                                    1.182616
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching            0.619173
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                            0.362177
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                      -0.157356
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                               0.743599
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                               0.046660
    ## educationA levels/AS levels or equivalent|Other professional qualifications eg: nursing, teaching                                                                                            0.026236
    ## educationCollege or University degree                                                                                                                                                        0.069269
    ## educationCollege or University degree|A levels/AS levels or equivalent                                                                                                                      -0.092839
    ## educationCollege or University degree|A levels/AS levels or equivalent|NVQ or HND or HNC or equivalent                                                                                       0.549569
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent                                                                                          0.187289
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent                                                                      -0.482733
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching               0.062320
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                          0.427032
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching  0.022028
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                  0.061299
    ## educationCollege or University degree|A levels/AS levels or equivalent|Other professional qualifications eg: nursing, teaching                                                               0.498647
    ## educationCollege or University degree|CSEs or equivalent                                                                                                                                    -0.641138
    ## educationCollege or University degree|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                             1.036947
    ## educationCollege or University degree|NVQ or HND or HNC or equivalent                                                                                                                       -0.165241
    ## educationCollege or University degree|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                0.455216
    ## educationCollege or University degree|O levels/GCSEs or equivalent                                                                                                                           0.251917
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent                                                                                                        0.040016
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                2.260873
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                0.701003
    ## educationCollege or University degree|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                          -0.585474
    ## educationCollege or University degree|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                  -0.138305
    ## educationCollege or University degree|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                  -0.246559
    ## educationCollege or University degree|Other professional qualifications eg: nursing, teaching                                                                                                0.017780
    ## educationCSEs or equivalent                                                                                                                                                                  0.144395
    ## educationCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                                                  0.199246
    ## educationCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                          0.121766
    ## educationCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                                                         -0.281254
    ## educationNone of the above                                                                                                                                                                   0.144017
    ## educationNVQ or HND or HNC or equivalent                                                                                                                                                     0.029176
    ## educationNVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                                             0.132896
    ## educationO levels/GCSEs or equivalent                                                                                                                                                        0.052122
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent                                                                                                                                     0.157484
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                    -0.082510
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                             0.880402
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                            -0.079359
    ## educationO levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                                       -0.053872
    ## educationO levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                               -0.004029
    ## educationO levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                                               -0.035637
    ## educationOther professional qualifications eg: nursing, teaching                                                                                                                             0.077086
    ## educationPrefer not to answer                                                                                                                                                                0.104340
    ## bmi                                                                                                                                                                                         -0.008547
    ## smokingCatCurrent smoker 1-19 pack year                                                                                                                                                     -0.028962
    ## smokingCatCurrent smoker unknown pack year                                                                                                                                                  -0.056417
    ## smokingCatNever smoker                                                                                                                                                                       0.108487
    ## smokingCatPast smoker >19 pack year                                                                                                                                                          0.038155
    ## smokingCatPast smoker 1-19 pack year                                                                                                                                                         0.053481
    ## smokingCatPast smoker unknown pack year                                                                                                                                                      0.045724
    ##                                                                                                                                                                                             exp(coef)
    ## pm25_2010per5                                                                                                                                                                                0.867811
    ## ageBaseline                                                                                                                                                                                  1.007883
    ## sexMale                                                                                                                                                                                      1.049163
    ## householdIncomeCat31,000 to 51,999                                                                                                                                                           1.012600
    ## householdIncomeCat52,000 to 100,000                                                                                                                                                          0.998367
    ## householdIncomeCatDo not know                                                                                                                                                                1.009138
    ## householdIncomeCatGreater than 100,000                                                                                                                                                       1.040483
    ## householdIncomeCatLess than 18,000                                                                                                                                                           0.968437
    ## householdIncomeCatPrefer not to answer                                                                                                                                                       0.950007
    ## educationA levels/AS levels or equivalent|CSEs or equivalent                                                                                                                                 0.907274
    ## educationA levels/AS levels or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                         2.263942
    ## educationA levels/AS levels or equivalent|NVQ or HND or HNC or equivalent                                                                                                                    1.182848
    ## educationA levels/AS levels or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                            2.395500
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent                                                                                                                       0.955003
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent                                                                                                    0.970422
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent                                                                    3.262899
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching            1.857392
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                            1.436453
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                       0.854400
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                               2.103491
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                               1.047765
    ## educationA levels/AS levels or equivalent|Other professional qualifications eg: nursing, teaching                                                                                            1.026583
    ## educationCollege or University degree                                                                                                                                                        1.071725
    ## educationCollege or University degree|A levels/AS levels or equivalent                                                                                                                       0.911340
    ## educationCollege or University degree|A levels/AS levels or equivalent|NVQ or HND or HNC or equivalent                                                                                       1.732506
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent                                                                                          1.205976
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent                                                                       0.617095
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching               1.064302
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                          1.532701
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching  1.022273
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                  1.063217
    ## educationCollege or University degree|A levels/AS levels or equivalent|Other professional qualifications eg: nursing, teaching                                                               1.646493
    ## educationCollege or University degree|CSEs or equivalent                                                                                                                                     0.526693
    ## educationCollege or University degree|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                             2.820593
    ## educationCollege or University degree|NVQ or HND or HNC or equivalent                                                                                                                        0.847689
    ## educationCollege or University degree|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                1.576513
    ## educationCollege or University degree|O levels/GCSEs or equivalent                                                                                                                           1.286489
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent                                                                                                        1.040827
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                9.591456
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                2.015774
    ## educationCollege or University degree|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                           0.556842
    ## educationCollege or University degree|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                   0.870833
    ## educationCollege or University degree|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                   0.781485
    ## educationCollege or University degree|Other professional qualifications eg: nursing, teaching                                                                                                1.017939
    ## educationCSEs or equivalent                                                                                                                                                                  1.155340
    ## educationCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                                                  1.220482
    ## educationCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                          1.129489
    ## educationCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                                                          0.754837
    ## educationNone of the above                                                                                                                                                                   1.154904
    ## educationNVQ or HND or HNC or equivalent                                                                                                                                                     1.029606
    ## educationNVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                                             1.142131
    ## educationO levels/GCSEs or equivalent                                                                                                                                                        1.053504
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent                                                                                                                                     1.170562
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                     0.920802
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                             2.411868
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                             0.923708
    ## educationO levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                                        0.947553
    ## educationO levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                0.995979
    ## educationO levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                                                0.964990
    ## educationOther professional qualifications eg: nursing, teaching                                                                                                                             1.080135
    ## educationPrefer not to answer                                                                                                                                                                1.109977
    ## bmi                                                                                                                                                                                          0.991489
    ## smokingCatCurrent smoker 1-19 pack year                                                                                                                                                      0.971454
    ## smokingCatCurrent smoker unknown pack year                                                                                                                                                   0.945145
    ## smokingCatNever smoker                                                                                                                                                                       1.114590
    ## smokingCatPast smoker >19 pack year                                                                                                                                                          1.038893
    ## smokingCatPast smoker 1-19 pack year                                                                                                                                                         1.054936
    ## smokingCatPast smoker unknown pack year                                                                                                                                                      1.046786
    ##                                                                                                                                                                                              se(coef)
    ## pm25_2010per5                                                                                                                                                                                0.078889
    ## ageBaseline                                                                                                                                                                                  0.003327
    ## sexMale                                                                                                                                                                                      0.035756
    ## householdIncomeCat31,000 to 51,999                                                                                                                                                           0.060065
    ## householdIncomeCat52,000 to 100,000                                                                                                                                                          0.075143
    ## householdIncomeCatDo not know                                                                                                                                                                0.076367
    ## householdIncomeCatGreater than 100,000                                                                                                                                                       0.136826
    ## householdIncomeCatLess than 18,000                                                                                                                                                           0.045988
    ## householdIncomeCatPrefer not to answer                                                                                                                                                       0.063292
    ## educationA levels/AS levels or equivalent|CSEs or equivalent                                                                                                                                 1.009733
    ## educationA levels/AS levels or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                         1.008880
    ## educationA levels/AS levels or equivalent|NVQ or HND or HNC or equivalent                                                                                                                    0.352325
    ## educationA levels/AS levels or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                            0.589840
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent                                                                                                                       0.178155
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent                                                                                                    0.371905
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent                                                                    0.514641
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching            0.590681
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                            1.009910
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                       0.229938
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                               0.371893
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                               0.184360
    ## educationA levels/AS levels or equivalent|Other professional qualifications eg: nursing, teaching                                                                                            0.215222
    ## educationCollege or University degree                                                                                                                                                        0.130478
    ## educationCollege or University degree|A levels/AS levels or equivalent                                                                                                                       0.427236
    ## educationCollege or University degree|A levels/AS levels or equivalent|NVQ or HND or HNC or equivalent                                                                                       1.007463
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent                                                                                          0.161046
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent                                                                       0.514752
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching               0.282980
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                          0.424414
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching  0.323067
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                  0.147280
    ## educationCollege or University degree|A levels/AS levels or equivalent|Other professional qualifications eg: nursing, teaching                                                               0.514328
    ## educationCollege or University degree|CSEs or equivalent                                                                                                                                     1.008967
    ## educationCollege or University degree|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                             1.008487
    ## educationCollege or University degree|NVQ or HND or HNC or equivalent                                                                                                                        0.395875
    ## educationCollege or University degree|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                0.463763
    ## educationCollege or University degree|O levels/GCSEs or equivalent                                                                                                                           0.291013
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent                                                                                                        0.591222
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                1.010909
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                0.590647
    ## educationCollege or University degree|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                           0.461731
    ## educationCollege or University degree|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                   0.425261
    ## educationCollege or University degree|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                   0.275062
    ## educationCollege or University degree|Other professional qualifications eg: nursing, teaching                                                                                                0.176150
    ## educationCSEs or equivalent                                                                                                                                                                  0.151424
    ## educationCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                                                  0.221310
    ## educationCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                          0.463451
    ## educationCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                                                          0.395184
    ## educationNone of the above                                                                                                                                                                   0.116558
    ## educationNVQ or HND or HNC or equivalent                                                                                                                                                     0.126891
    ## educationNVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                                             0.225873
    ## educationO levels/GCSEs or equivalent                                                                                                                                                        0.121834
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent                                                                                                                                     0.256681
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                     0.283598
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                             0.515477
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                             0.323118
    ## educationO levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                                        0.159381
    ## educationO levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                0.234099
    ## educationO levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                                                0.154742
    ## educationOther professional qualifications eg: nursing, teaching                                                                                                                             0.131347
    ## educationPrefer not to answer                                                                                                                                                                0.180461
    ## bmi                                                                                                                                                                                          0.003764
    ## smokingCatCurrent smoker 1-19 pack year                                                                                                                                                      0.073827
    ## smokingCatCurrent smoker unknown pack year                                                                                                                                                   0.108162
    ## smokingCatNever smoker                                                                                                                                                                       0.057023
    ## smokingCatPast smoker >19 pack year                                                                                                                                                          0.045097
    ## smokingCatPast smoker 1-19 pack year                                                                                                                                                         0.068082
    ## smokingCatPast smoker unknown pack year                                                                                                                                                      0.069236
    ##                                                                                                                                                                                                  z
    ## pm25_2010per5                                                                                                                                                                               -1.797
    ## ageBaseline                                                                                                                                                                                  2.360
    ## sexMale                                                                                                                                                                                      1.342
    ## householdIncomeCat31,000 to 51,999                                                                                                                                                           0.208
    ## householdIncomeCat52,000 to 100,000                                                                                                                                                         -0.022
    ## householdIncomeCatDo not know                                                                                                                                                                0.119
    ## householdIncomeCatGreater than 100,000                                                                                                                                                       0.290
    ## householdIncomeCatLess than 18,000                                                                                                                                                          -0.697
    ## householdIncomeCatPrefer not to answer                                                                                                                                                      -0.810
    ## educationA levels/AS levels or equivalent|CSEs or equivalent                                                                                                                                -0.096
    ## educationA levels/AS levels or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                         0.810
    ## educationA levels/AS levels or equivalent|NVQ or HND or HNC or equivalent                                                                                                                    0.477
    ## educationA levels/AS levels or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                            1.481
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent                                                                                                                      -0.258
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent                                                                                                   -0.081
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent                                                                    2.298
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching            1.048
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                            0.359
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                      -0.684
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                               1.999
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                               0.253
    ## educationA levels/AS levels or equivalent|Other professional qualifications eg: nursing, teaching                                                                                            0.122
    ## educationCollege or University degree                                                                                                                                                        0.531
    ## educationCollege or University degree|A levels/AS levels or equivalent                                                                                                                      -0.217
    ## educationCollege or University degree|A levels/AS levels or equivalent|NVQ or HND or HNC or equivalent                                                                                       0.545
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent                                                                                          1.163
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent                                                                      -0.938
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching               0.220
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                          1.006
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching  0.068
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                  0.416
    ## educationCollege or University degree|A levels/AS levels or equivalent|Other professional qualifications eg: nursing, teaching                                                               0.970
    ## educationCollege or University degree|CSEs or equivalent                                                                                                                                    -0.635
    ## educationCollege or University degree|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                             1.028
    ## educationCollege or University degree|NVQ or HND or HNC or equivalent                                                                                                                       -0.417
    ## educationCollege or University degree|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                0.982
    ## educationCollege or University degree|O levels/GCSEs or equivalent                                                                                                                           0.866
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent                                                                                                        0.068
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                2.236
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                1.187
    ## educationCollege or University degree|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                          -1.268
    ## educationCollege or University degree|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                  -0.325
    ## educationCollege or University degree|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                  -0.896
    ## educationCollege or University degree|Other professional qualifications eg: nursing, teaching                                                                                                0.101
    ## educationCSEs or equivalent                                                                                                                                                                  0.954
    ## educationCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                                                  0.900
    ## educationCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                          0.263
    ## educationCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                                                         -0.712
    ## educationNone of the above                                                                                                                                                                   1.236
    ## educationNVQ or HND or HNC or equivalent                                                                                                                                                     0.230
    ## educationNVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                                             0.588
    ## educationO levels/GCSEs or equivalent                                                                                                                                                        0.428
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent                                                                                                                                     0.614
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                    -0.291
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                             1.708
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                            -0.246
    ## educationO levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                                       -0.338
    ## educationO levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                               -0.017
    ## educationO levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                                               -0.230
    ## educationOther professional qualifications eg: nursing, teaching                                                                                                                             0.587
    ## educationPrefer not to answer                                                                                                                                                                0.578
    ## bmi                                                                                                                                                                                         -2.271
    ## smokingCatCurrent smoker 1-19 pack year                                                                                                                                                     -0.392
    ## smokingCatCurrent smoker unknown pack year                                                                                                                                                  -0.522
    ## smokingCatNever smoker                                                                                                                                                                       1.903
    ## smokingCatPast smoker >19 pack year                                                                                                                                                          0.846
    ## smokingCatPast smoker 1-19 pack year                                                                                                                                                         0.786
    ## smokingCatPast smoker unknown pack year                                                                                                                                                      0.660
    ##                                                                                                                                                                                                  p
    ## pm25_2010per5                                                                                                                                                                               0.0723
    ## ageBaseline                                                                                                                                                                                 0.0183
    ## sexMale                                                                                                                                                                                     0.1795
    ## householdIncomeCat31,000 to 51,999                                                                                                                                                          0.8349
    ## householdIncomeCat52,000 to 100,000                                                                                                                                                         0.9826
    ## householdIncomeCatDo not know                                                                                                                                                               0.9052
    ## householdIncomeCatGreater than 100,000                                                                                                                                                      0.7718
    ## householdIncomeCatLess than 18,000                                                                                                                                                          0.4856
    ## householdIncomeCatPrefer not to answer                                                                                                                                                      0.4178
    ## educationA levels/AS levels or equivalent|CSEs or equivalent                                                                                                                                0.9232
    ## educationA levels/AS levels or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                        0.4180
    ## educationA levels/AS levels or equivalent|NVQ or HND or HNC or equivalent                                                                                                                   0.6336
    ## educationA levels/AS levels or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                           0.1386
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent                                                                                                                      0.7961
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent                                                                                                   0.9357
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent                                                                   0.0216
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching           0.2945
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                           0.7199
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                      0.4938
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                              0.0456
    ## educationA levels/AS levels or equivalent|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                              0.8002
    ## educationA levels/AS levels or equivalent|Other professional qualifications eg: nursing, teaching                                                                                           0.9030
    ## educationCollege or University degree                                                                                                                                                       0.5955
    ## educationCollege or University degree|A levels/AS levels or equivalent                                                                                                                      0.8280
    ## educationCollege or University degree|A levels/AS levels or equivalent|NVQ or HND or HNC or equivalent                                                                                      0.5854
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent                                                                                         0.2448
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent                                                                      0.3483
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching              0.8257
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                         0.3143
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching 0.9456
    ## educationCollege or University degree|A levels/AS levels or equivalent|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                 0.6773
    ## educationCollege or University degree|A levels/AS levels or equivalent|Other professional qualifications eg: nursing, teaching                                                              0.3323
    ## educationCollege or University degree|CSEs or equivalent                                                                                                                                    0.5251
    ## educationCollege or University degree|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                            0.3038
    ## educationCollege or University degree|NVQ or HND or HNC or equivalent                                                                                                                       0.6764
    ## educationCollege or University degree|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                               0.3263
    ## educationCollege or University degree|O levels/GCSEs or equivalent                                                                                                                          0.3867
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent                                                                                                       0.9460
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching               0.0253
    ## educationCollege or University degree|O levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                               0.2353
    ## educationCollege or University degree|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                          0.2048
    ## educationCollege or University degree|O levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                  0.7450
    ## educationCollege or University degree|O levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                  0.3701
    ## educationCollege or University degree|Other professional qualifications eg: nursing, teaching                                                                                               0.9196
    ## educationCSEs or equivalent                                                                                                                                                                 0.3403
    ## educationCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                                                 0.3680
    ## educationCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                         0.7928
    ## educationCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                                                         0.4766
    ## educationNone of the above                                                                                                                                                                  0.2166
    ## educationNVQ or HND or HNC or equivalent                                                                                                                                                    0.8181
    ## educationNVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                                                            0.5563
    ## educationO levels/GCSEs or equivalent                                                                                                                                                       0.6688
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent                                                                                                                                    0.5395
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                    0.7711
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                            0.0876
    ## educationO levels/GCSEs or equivalent|CSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                            0.8060
    ## educationO levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent                                                                                                                       0.7354
    ## educationO levels/GCSEs or equivalent|NVQ or HND or HNC or equivalent|Other professional qualifications eg: nursing, teaching                                                               0.9863
    ## educationO levels/GCSEs or equivalent|Other professional qualifications eg: nursing, teaching                                                                                               0.8179
    ## educationOther professional qualifications eg: nursing, teaching                                                                                                                            0.5573
    ## educationPrefer not to answer                                                                                                                                                               0.5631
    ## bmi                                                                                                                                                                                         0.0232
    ## smokingCatCurrent smoker 1-19 pack year                                                                                                                                                     0.6948
    ## smokingCatCurrent smoker unknown pack year                                                                                                                                                  0.6019
    ## smokingCatNever smoker                                                                                                                                                                      0.0571
    ## smokingCatPast smoker >19 pack year                                                                                                                                                         0.3975
    ## smokingCatPast smoker 1-19 pack year                                                                                                                                                        0.4321
    ## smokingCatPast smoker unknown pack year                                                                                                                                                     0.5090
    ## 
    ## Likelihood ratio test=62.66  on 68 df, p=0.6602
    ## n= 3583, number of events= 3583 
    ##    (478199 observations deleted due to missingness)

## Citations

(Huang et al. 2021; Tian et al. 2022; Swanton et al. 2016)

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-huang2021a" class="csl-entry">

Huang, Yanqian, Meng Zhu, Mengmeng Ji, Jingyi Fan, Junxing Xie, Xiaoxia
Wei, Xiangxiang Jiang, et al. 2021. “Air Pollution, Genetic Factors, and
the Risk of Lung Cancer: A Prospective Study in the UK Biobank.”
*American Journal of Respiratory and Critical Care Medicine* 204 (7):
817–25. <https://doi.org/10.1164/rccm.202011-4063OC>.

</div>

<div id="ref-swanton2016" class="csl-entry">

Swanton, C., P. Boffetta, R. Peston, and J.-C. Soria. 2016.
“Environmental emissions, public health and lung cancer risk.” *Annals
of Oncology: Official Journal of the European Society for Medical
Oncology* 27 (2): 211–12. <https://doi.org/10.1093/annonc/mdv579>.

</div>

<div id="ref-tian2022a" class="csl-entry">

Tian, Ruiyi, Brian Wiley, Jie Liu, Xiaoyu Zong, Buu Truong, Stephanie
Zhao, Md Mesbah Uddin, et al. 2022. “Clonal Hematopoiesis and Risk of
Incident Lung Cancer.” *Journal of Clinical Oncology: Official Journal
of the American Society of Clinical Oncology*, December, JCO2200857.
<https://doi.org/10.1200/JCO.22.00857>.

</div>

</div>
