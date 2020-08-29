![.github/workflows/build.yaml](https://github.com/waldronbios2/cunybios2/workflows/.github/workflows/build.yaml/badge.svg)

# Lecture and lab materials for CUNY SPH Biostatistics 2

This course is designed to expand on the biostatistical methods
covered in Applied Biostatistics I. It introduces generalized linear
regression including logistic regression, loglinear models (including
Poisson and Negative Binomial models of count data), survival
analysis, and longitudinal data including random and mixed effect
models.

# RStudio primers 

I fetched the primers dependencies from a renv.lock file like this,
then inserted pkgs.txt into my DESCRIPTION. It's a lot of dependencies
but I think that's OK. I realize the primers may not all work without
restoring the same versions that rstudio-education fixed, but let's
cross that bridge later. In the meantime it would be annoying to be
stuck with R 3.6.3.


```bash
grep Package primers/renv.lock  | sed -e 's/      "Package": "/    /' | sed -e 's/",/,/' | uniq | sort > pkgs.txt 
```

