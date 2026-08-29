<!-- badges: start -->
[![Actions Status](https://github.com/waldronbios2/session3/workflows/build/badge.svg)](https://github.com/waldronbios2/session3/actions)
<!-- badges: end -->

# Session 3: Regression coefficients and model matrices

## Lecture

**Learning Objectives**

1. Interpret main coefficients in logistic regression
2. Interpret interaction terms in logistic regression
3. Define and interpret model matrices for (generalized) linear models

**Outline**

1. Review of GLM
2. Interpretation of logistic regression coefficients
3. Introduction to model matrices

## Lab

**Learning objectives**

1. perform and interpret logistic regression
    + interpret logistic regression coefficients
    + make predictions based on a logistic regression model
2. perform and interpret likelihood ratio test

**Exercises**

1. What is the mean fraction of women using birth control for each age group? Each education level? For women who do or don't want more children?
     - Hint: look at the "data wrangling" cheat sheet functions `mutate`, `group_by`, and `summarize`
2. Based on ```fit1```, write on paper the model for expected probability of using birth control.  Don't forget the logit function.
3. Based on ```fit1```, what is the expected probability of an individual 25-29 years old, with high education, who wants more children, using birth control? Calculate it manually, and using `predict(fit1)`
4. Based on ```fit1```: Relative to women under 25 who want to have children, what is the predicted increase in odds that a woman 40-49 years old who does _not_ want to have children will be taking birth control?
5. Using a likelihood ratio test, is there evidence that a model with interactions improves on ```fit1``` (no interactions)?
6. Which, if any, variables have the strongest interactions?
7. Looking at the effect of age only, consider contrasts between *every pair* of age groups. Between which age groups is the contrast significant?
