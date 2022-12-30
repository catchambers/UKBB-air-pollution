Air Pollution Analysis
================

## CH option not functional currently

Lung cancer data was used for the following analysis.

``` r
kd_male <- density(na.omit(pm10_2007[df$sex=="Male"])) #define kernel density
plot(kd_male,
     col='blue',
     lwd=2,
     main = "Female/Male PM10_2007") #create kernel density plot
kd_female <- density(na.omit(pm10_2007[df$sex=="Female"]))
lines(kd_female,
      col='red',
      lwd=2)
```

![](master_files/figure-gfm/density%20plot%20sex-1.png)<!-- -->

``` r
# fill in kernel density plot with specific color
# polygon(kd_male, col='blue', border='black')
# polygon(kd_female, col='red', border='black')
```

``` r
x1 = na.omit(pm10_2007[df$ageBaseline>=60])
x2 = na.omit(pm10_2007[df$ageBaseline<60])
plot_mult_density("pm10_2007 (blue=60 or over, red=under 60)", x1,x2)
```

![](master_files/figure-gfm/density%20plots-1.png)<!-- -->

``` r
x1 = na.omit(pm10_2007[df$lung_cancer==1])
x2 = na.omit(pm10_2007[df$lung_cancer==0])
plot_mult_density("pm10_2007 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
```

![](master_files/figure-gfm/Lung%20Cancer-1.png)<!-- -->

``` r
x1 = na.omit(pm10_2010[df$lung_cancer==1])
x2 = na.omit(pm10_2010[df$lung_cancer==0])
plot_mult_density("pm10_2010 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
```

![](master_files/figure-gfm/Lung%20Cancer-2.png)<!-- -->

``` r
x1 = na.omit(pm25_2010[df$lung_cancer==1])
x2 = na.omit(pm25_2010[df$lung_cancer==0])
plot_mult_density("pm25_2010 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
```

![](master_files/figure-gfm/Lung%20Cancer-3.png)<!-- -->

``` r
x1 = na.omit(pmcourse_2010[df$lung_cancer==1])
x2 = na.omit(pmcourse_2010[df$lung_cancer==0])
plot_mult_density("pmcourse_2010 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
```

![](master_files/figure-gfm/Lung%20Cancer-4.png)<!-- -->

``` r
x1 = na.omit(no2_2005[df$lung_cancer==1])
x2 = na.omit(no2_2005[df$lung_cancer==0])
plot_mult_density("no2_2005 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
```

![](master_files/figure-gfm/Lung%20Cancer-5.png)<!-- -->

``` r
x1 = na.omit(no2_2006[df$lung_cancer==1])
x2 = na.omit(no2_2006[df$lung_cancer==0])
plot_mult_density("no2_2006 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
```

![](master_files/figure-gfm/Lung%20Cancer-6.png)<!-- -->

``` r
x1 = na.omit(no2_2007[df$lung_cancer==1])
x2 = na.omit(no2_2007[df$lung_cancer==0])
plot_mult_density("no2_2007 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
```

![](master_files/figure-gfm/Lung%20Cancer-7.png)<!-- -->

``` r
x1 = na.omit(no2_2010[df$lung_cancer==1])
x2 = na.omit(no2_2010[df$lung_cancer==0])
plot_mult_density("no2_2010 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
```

![](master_files/figure-gfm/Lung%20Cancer-8.png)<!-- -->

``` r
x1 = na.omit(no1_2010[df$lung_cancer==1])
x2 = na.omit(no1_2010[df$lung_cancer==0])
plot_mult_density("no1_2010 (blue=Lung Cancer, red=No Lung Cancer)", x1,x2)
```

![](master_files/figure-gfm/Lung%20Cancer-9.png)<!-- -->

``` r
#define data
x1 = na.omit(pm10_2007[df$ageBaseline>=60])
x2 = na.omit(pm10_2007[df$ageBaseline<60])

#plot two histograms in same graph
hist(x1, col='red', main='pm10_2007', xlab='(μg/m3)')
hist(x2, col='green', add=TRUE)

#add legend
legend('topright', c('60 or Over', 'Under 60'), fill=c('red', 'green'))
```

![](master_files/figure-gfm/histograms%20age-1.png)<!-- -->

There are 4081 cases of lungcancer in the data set.

``` r
hist(pm25_2010, 
     main="Particulate matter air pollution (pm2.5) 2010",
     xlab="PM2.5 (μg/m3)",
     col="cadetblue",
     freq=FALSE,
     ylim=c(0,0.7))

#Plot lognormal distribution
xfit <- seq(min(pm25_2010, na.rm=TRUE), max(pm25_2010, na.rm=TRUE), length=40)
yfit <- dlnorm(xfit,meanlog=log(mean(pm25_2010)), sdlog=log(sd(pm25_2010)))
lines(xfit, yfit, col="black", lwd=2)
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

``` r
plot(pm10_2010, 
     no2_2010, 
     )
```

![](master_files/figure-gfm/scatterplot%20PM10%20NO2-1.png)<!-- -->

``` r
cor(pm10_2010, no2_2010, method="pearson", use="complete.obs")
```

    ## [1] 0.5055037

``` r
cor(pm10_2010, no2_2010, method="spearman", use="complete.obs")
```

    ## [1] 0.5398056

``` r
plot(pm10_2010, 
     pm25_2010 
     )
```

![](master_files/figure-gfm/scatterplot%20PM10%20PM2.5-1.png)<!-- -->

``` r
cor(pm10_2010, pm25_2010, method="pearson", use="complete.obs")
```

    ## [1] 0.5325037

``` r
cor(pm10_2010, pm25_2010, method="spearman", use="complete.obs")
```

    ## [1] 0.5687892

``` r
plot(no1_2010, 
     no2_2010, 
     )
```

![](master_files/figure-gfm/scatterplot%20NO1%20NO2-1.png)<!-- -->

``` r
cor(no1_2010, no2_2010, method="pearson", use="complete.obs")
```

    ## [1] 0.9219059

``` r
cor(no1_2010, no2_2010, method="spearman", use="complete.obs")
```

    ## [1] 0.9144932

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

``` r
qqnorm(pm25_2010)
qqline(pm25_2010)
```

![](master_files/figure-gfm/qqplot-1.png)<!-- -->

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

``` r
extremeOut <- 3*iqr
mildOut <- 1.5*iqr

extremePM25 <- subset(df, pm25_2010 > (mean(pm25_2010, na.rm=TRUE)+ extremeOut))
mildPM25 <- subset(df, pm25_2010 > (mean(pm25_2010, na.rm=TRUE)+ mildOut))
```

There are 958 extreme outliers and 20992 mild outliers for PM2.5 data
from 2010.

``` r
attach(extremePM25)
```

    ## The following objects are masked from df:
    ## 
    ##     ageBaseline, baselineDate, bmi, cancerBehaviour, cancerDate,
    ##     cancerDate_Lung, cancerHistology, cancerICD10, date_of_death,
    ##     dateAssesment, dateCensor, dateCutoff, dateLostFollowUp, dob,
    ##     education, eid, exposeSmokeHomeRaw, fuel, householdIncomeCat,
    ##     ICD10group, lung_cancer, meaning, no1_2010, no1_2010per20,
    ##     no2_2005, no2_2005per10, no2_2006, no2_2006per10, no2_2007,
    ##     no2_2007per10, no2_2010, no2_2010per10, packYear, pm10_2007,
    ##     pm10_2007per10, pm10_2010, pm10_2010per10, pm25_2010,
    ##     pm25_2010per5, pm25Absorb_2010, pmcourse_2010, pmcourse_2010per5,
    ##     prior_cancer, race, sex, smokingCat, t_lungCancer,
    ##     timeCurrentAddress, townsend

``` r
cor(pm25_2010, ageBaseline)
```

    ## [1] 0.04268743

``` r
cor(pm25_2010, bmi, use="pairwise.complete.obs")
```

    ## [1] 0.0300583

``` r
cor(pm25_2010, packYear, use="pairwise.complete.obs")
```

    ## [1] -0.01779504

``` r
detach(extremePM25)
```

``` r
attach(mildPM25)
```

    ## The following objects are masked from df:
    ## 
    ##     ageBaseline, baselineDate, bmi, cancerBehaviour, cancerDate,
    ##     cancerDate_Lung, cancerHistology, cancerICD10, date_of_death,
    ##     dateAssesment, dateCensor, dateCutoff, dateLostFollowUp, dob,
    ##     education, eid, exposeSmokeHomeRaw, fuel, householdIncomeCat,
    ##     ICD10group, lung_cancer, meaning, no1_2010, no1_2010per20,
    ##     no2_2005, no2_2005per10, no2_2006, no2_2006per10, no2_2007,
    ##     no2_2007per10, no2_2010, no2_2010per10, packYear, pm10_2007,
    ##     pm10_2007per10, pm10_2010, pm10_2010per10, pm25_2010,
    ##     pm25_2010per5, pm25Absorb_2010, pmcourse_2010, pmcourse_2010per5,
    ##     prior_cancer, race, sex, smokingCat, t_lungCancer,
    ##     timeCurrentAddress, townsend

``` r
cor(pm25_2010, ageBaseline, use="pairwise.complete.obs")
```

    ## [1] 0.003296757

``` r
cor(pm25_2010, bmi, use="pairwise.complete.obs")
```

    ## [1] -0.004101232

``` r
cor(pm25_2010, packYear, use="pairwise.complete.obs")
```

    ## [1] 0.009053578

``` r
detach(mildPM25)

rm(mildPM25, extremePM25)
```

``` r
##Cox Regression Model 1 - Age and Sex covariates only
res.model1 <- coxph(
  Surv(t_lungCancer, lung_cancer) ~  pm25_2010per5 + ageBaseline + sex,
  data = df,
  ties = "efron"
)
```

\##Paper uses exposeSmokeHomeImputed, bmiCat, and lungFamilyHistory.
These variables haven’t been generated

``` r
##Model 2 - Multiple covariates
res.model2 <- coxph(
  Surv(t_lungCancer, lung_cancer) ~ pm25_2010per5 + ageBaseline + sex + householdIncomeCat + education + bmi + smokingCat +  exposeSmokeHomeRaw,
  data = df,
  ties = "efron"
)
```
