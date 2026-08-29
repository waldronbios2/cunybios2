<!-- badges: start -->
[![Actions Status](https://github.com/waldronbios2/session8/workflows/build/badge.svg)](https://github.com/waldronbios2/templatesession/actions)
<!-- badges: end -->

# Session 7: Proportional hazards and AFT models

## Lecture

**Learning objectives**

1. Define proportional hazards
2. Perform and interpret Cox proportional hazards regression
3. Define time-dependent covariates and their use
4. Identify the differences between parametric and semi-parametric survival models
5. Identify situations when a parametric survival model might be useful

**Outline**

1. Review of survival and hazard functions
2. The Cox proportional hazards model
    + interpretation and inference
    + what are proportional hazards
    + when hazards aren't proportional
3. Parametric vs semi-parametric survival models

* Vittinghoff sections 6.1-6.2, 6.4

## Lab

**Learning Objectives**

1. Fit a Cox proportional hazard model
2. Create a stratified Kaplan-Meier plot
3. Fit exponential and Weibull accelerated failure time models
4. Fit a model using strata and a time-dependent covariate
5. Create a DAG using dagitty

**Exercises**

1. Fit a Cox proportional hazard model to the Leukemia 6 MP clinical trial dataset
2. Create a stratified Kaplan-Meier plot
3. Fit exponential and Weibull accelerated failure time (AFT) models
4. Fit a stratified coxph model with a time-dependent covariate using an example from ?coxph
5. Draw a DAG starting from dagitty.net and re-create it in R
