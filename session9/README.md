<!-- badges: start -->
[![Actions Status](https://github.com/waldronbios2/session9/workflows/build/badge.svg)](https://github.com/waldronbios2/templatesession/actions)
<!-- badges: end -->

# Session 9: Repeated Measures and Longitudinal Data Analysis I

## Lecture

**Learning Objectives**

1. Identify and define hierarchical and longitudinal data
2. Analyze correlated data using Analysis of Variance
3. Define and calculate Intraclass Correlation
4. Identify and define random and fixed effects

Textbook sections:

* Vittinghoff sections 7.1 (7.2-7.3 next class)

**Outline**

1. Introduction to hierarchical and longitudinal data
2. Fecal Fat example
3. Correlations within subjects (ICC)
4. Random and fixed effects

## Lab

**Learning Objectives**

1. Create and interpret a notched barplot
2. Create spaghetti / line plots for grouped data
3. Use `pivot_wider` to create a wide-format dataframe
4. Do a manual ICC calculation
5. Write a function
6. Perform a permutation simulation

**Exercises**

1. Read the fecal fat dataset and convert pilltype and subject to factors
2. Create a notched boxplot of the data.
3. Interpret the notches. What is wrong with the usual interpretation in this example?
4. Subtract subject means from the fecal fat data, manually and using residuals of a one-way AOV
5. Make line plots for each subject, with and without subject mean centering
6. Convert to a wide-format dataset and remove the subject column
7. Write a function to calculate subject and residual variance and ICC of this dataset as a vector
8. Create a simulated dataset where subjects are randomized for each treatment
9. compare ICC for your original and simulated dataset
10. Repeat the simulation 999 times, and compare to your original dataset
