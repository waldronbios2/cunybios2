<!-- badges: start -->
[![Actions Status](https://github.com/waldronbios2/session5/workflows/build/badge.svg)](https://github.com/waldronbios2/templatesession/actions)
<!-- badges: end -->

# Session 5: Log-linear models part 2

## Lecture

**Learning Objectives**

1. Define and identify over-dispersion in count data
2. Define the negative binomial (NB) distribution and identify applications for it
3. Define zero-inflated count models
4. Fit and interpret Poisson and NB, with and without zero inflation

**Outline**

1. Review of log-linear Poisson glm
2. Review of diagnostics and interpretation of coefficients
3. Over-dispersion
    + Negative Binomial distribution
4. Zero-inflated models

* Vittinghoff section 8.1-8.3

## Lab

**Learning Objectives**

1. Fit Poisson, NB, and zero-inflated loglinear models
2. Perform nested deviance test for model selection
3. Make diagnostic plots of loglinear models

**Exercises**

1. Load the needle-sharing dataset. 
    + Compare the mean to the variance of the outcome variable. 
    + Calculate what fraction of the counts are zero.
    + Create a histogram of the outcome variable.

2. Fit Poisson and Negative Binomial models as in the lecture, with and without zero inflation.

3. Use chi-square nested deviance tests to assess which model seems to fit best.

4. Create residual deviance plots using the functions defined in the lecture.

5. Plot the frequences of predicted and observed counts for each model.
