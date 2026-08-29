<!-- badges: start -->
[![Actions Status](https://github.com/waldronbios2/session8/workflows/build/badge.svg)](https://github.com/waldronbios2/templatesession/actions)
<!-- badges: end -->

# Session 8: Survival Analysis 3

## Lecture

**Learning Objectives**


1. Check model assumptions and fit of the Cox model
    + residuals analysis
    + log-minus-log plot
2. Fit and interpret multivariate Cox models
    + perform tests for trend
    + predict survival for specific covariate patterns
    + predict survival for adjusted coefficients
3. Explain stratified analysis
4. Identify situations of competing risks
5. Describe the application of Propensity Score analysis

* Vittinghoff sections 6.2-6.4

**Outline**


1. Review
2. Assumptions of Cox PH model
3. Tests for trend
4. Predictions for specific covariate patterns
5. Stratification
6. Competing risks
7. Propensity Score analysis to control for confounding

## Lab

**Learning Objectives**

1. Make stratified and unstratified Kaplan-Meier plots
2. Perform Cox proportional hazards regression
3. Assess proportional hazards assumption

**Exercises**

1. Load the Primary Biliary Cirrhosis (pbc) dataset from the survival package
2. Create a `Surv` object using variables "time" and "status", add this to the pbc dataframe
3. Plot a KM curve for all participants using `library(survminer)` function `ggsurvplot()`
4. Stratify by treatment and add a p-value to this plot (see `?ggsurvplot`)
5. Check whether these p-values correspond to results from a log-rank test
6. Perform a Cox proportional hazards regression, using the "trt" variable as a predictor
7. Create a log-minus-log plot to test the proportional hazards assumption
8. Plot Schoenfeld residuals and perform Schoenfeld test for the above Cox model
