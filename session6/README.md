<!-- badges: start -->
[![Actions Status](https://github.com/waldronbios2/session6/workflows/build/badge.svg)](https://github.com/waldronbios2/templatesession/actions)
<!-- badges: end -->

# Session 6: Survival Analysis I

## Lecture

**Learning Objectives**

1. Define main types of censoring
2. Define the assumption of uninformative censoring
3. Define survival function, hazard functions, cumulative event function
4. Perform a Kaplan-Meier estimate
5. Perform, interpret, and identify assumptions of the logrank test
6. Define and calculate potential follow-up time
7. Calculate median survival time

**Outline**

1. Introduction to censored data
    + Outcome variable: time-to-event
    + Types of censored data
    + Assumption of uninformative censoring
2. Survival function and Kaplan-Meier estimator
3. Comparing groups: Log-rank test

* Vittinghoff sections 3.1-3.5
* Tutorial Paper _Survival Analysis Part I: Basic concepts and first analyses_ by Clark, Bradburn, Love, Altman. British Journal of Cancer (2003) 89, 232 – 238

## Lab

**Learning Objectives**

1. Calculate Kaplan-Meier estimates of survival probability over time
2. Plot survival curves for censored time-to-event data
3. Perform and interpret log-rank test
4. Define "informative" censoring

**Exercises**

1. Calculate the follow-up table for 6 MP patients in the leukemia study
2. Plot the Kaplan-Meier estimate of the follow-up table from 1. `library(survminer)` is recommendable. 
3. What is the 75th percentile of survival times for the 6 MP group? For the Placebo group? This is the time that 75% of the patients survive.
4. Suppose you were instructed to cap follow-up times at 20 weeks. Re-do the Kaplan-Meier plot for both groups, and re-do the logrank test.
5. Give a hypothetical example of how censoring in this example might be "informative."
