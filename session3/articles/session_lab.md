# Sessions 3 lab exercise: Regression analysis of contraceptive use data

**Learning objectives**

1.  perform and interpret logistic regression
    - interpret logistic regression coefficients
    - make predictions based on a logistic regression model
2.  perform and interpret likelihood ratio test

**Exercises**

1.  What is the mean fraction of women using birth control for each age
    group? Each education level? For women who do or don’t want more
    children?
    - Hint: look at the “data wrangling” cheat sheet functions `mutate`,
      `group_by`, and `summarize`
2.  Based on `fit1`, write on paper the model for expected probability
    of using birth control. Don’t forget the logit function.
3.  Based on `fit1`, what is the expected probability of an individual
    25-29 years old, with high education, who wants more children, using
    birth control? Calculate it manually, and using `predict(fit1)`
4.  Based on `fit1`: Relative to women under 25 who want to have
    children, what is the predicted increase in odds that a woman 40-49
    years old who does *not* want to have children will be taking birth
    control?
5.  Using a likelihood ratio test, is there evidence that a model with
    interactions improves on `fit1` (no interactions)?
6.  Which, if any, variables have the strongest interactions?
7.  Looking at the effect of age only, consider contrasts between *every
    pair* of age groups. Between which age groups is the contrast
    significant?

## Load and explore the contraceptive use data

Load the data from <http://data.princeton.edu/wws509/datasets/#cuse>.
From this page: \> These data show the distribution of 1607 currently
married and fecund women interviewed in the Fiji Fertility Survey,
according to age, education, desire for more children and current use of
contraception.

See Session 2 for some discussion about reading this file. Here we just
do it.

[`library`](https://rdrr.io/r/base/library.html)`(`[`readr`](https://readr.tidyverse.org)`)`` ``cuse`` ``<-`` `[`read_table`](https://readr.tidyverse.org/reference/read_table.html)`(``"cuse.dat"``,`` `` col_types ``=`` `[`cols`](https://readr.tidyverse.org/reference/cols.html)`(`` `` age ``=`` `[`col_factor`](https://readr.tidyverse.org/reference/parse_factor.html)`(``levels ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"<25"``, ``"25-29"``, ``"30-39"``, ``"40-49"``)``)``,`` `` education ``=`` `[`col_factor`](https://readr.tidyverse.org/reference/parse_factor.html)`(``levels ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"low"``, ``"high"``)``)``,`` `` wantsMore ``=`` `[`col_factor`](https://readr.tidyverse.org/reference/parse_factor.html)`(``levels ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"no"``, ``"yes"``)``)``,`` `` X6 ``=`` `[`col_skip`](https://readr.tidyverse.org/reference/col_skip.html)`(``)`` `` ``)`` `` ``)`

    ## Warning: Missing column names filled in: 'X6' [6]

    ## Warning: 16 parsing failures.
    ## row col  expected    actual       file
    ##   1  -- 6 columns 5 columns 'cuse.dat'
    ##   2  -- 6 columns 5 columns 'cuse.dat'
    ##   3  -- 6 columns 5 columns 'cuse.dat'
    ##   4  -- 6 columns 5 columns 'cuse.dat'
    ##   5  -- 6 columns 5 columns 'cuse.dat'
    ## ... ... ......... ......... ..........
    ## See problems(...) for more details.

[`summary`](https://rdrr.io/r/base/summary.html)`(``cuse``)`

    ##     age    education wantsMore    notUsing          using      
    ##  <25  :4   low :8    no :8     Min.   :  8.00   Min.   : 4.00  
    ##  25-29:4   high:8    yes:8     1st Qu.: 31.00   1st Qu.: 9.50  
    ##  30-39:4                       Median : 56.50   Median :29.00  
    ##  40-49:4                       Mean   : 68.75   Mean   :31.69  
    ##                                3rd Qu.: 85.75   3rd Qu.:49.00  
    ##                                Max.   :212.00   Max.   :80.00

## What is the mean fraction of women using birth control for…

What is the mean fraction of women using birth control for each age
group? Each education level? For women who do or don’t want more
children? - Hint: look at the [“Data Transformation
Cheatsheet”](https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf)
functions `mutate`, `group_by`, and `summarize`. This is one of several
very handy cheatsheets produced by RStudio, see
<https://rstudio.com/resources/cheatsheets/> for a list.

**Solution**

First create a new column containing the fraction using contraception:

[`library`](https://rdrr.io/r/base/library.html)`(`[`dplyr`](https://dplyr.tidyverse.org)`)`` ``cuse2`` ``<-`` `[`mutate`](https://dplyr.tidyverse.org/reference/mutate.html)`(``cuse``, fracusing ``=`` ``using`` ``/`` ``(``using`` ``+`` ``notUsing``)``)`` ``cuse2`

    ## # A tibble: 16 × 6
    ##    age   education wantsMore notUsing using fracusing
    ##    <fct> <fct>     <fct>        <dbl> <dbl>     <dbl>
    ##  1 <25   low       yes             53     6     0.102
    ##  2 <25   low       no              10     4     0.286
    ##  3 <25   high      yes            212    52     0.197
    ##  4 <25   high      no              50    10     0.167
    ##  5 25-29 low       yes             60    14     0.189
    ##  6 25-29 low       no              19    10     0.345
    ##  7 25-29 high      yes            155    54     0.258
    ##  8 25-29 high      no              65    27     0.293
    ##  9 30-39 low       yes            112    33     0.228
    ## 10 30-39 low       no              77    80     0.510
    ## 11 30-39 high      yes            118    46     0.280
    ## 12 30-39 high      no              68    78     0.534
    ## 13 40-49 low       yes             35     6     0.146
    ## 14 40-49 low       no              46    48     0.511
    ## 15 40-49 high      yes              8     8     0.5  
    ## 16 40-49 high      no              12    31     0.721

Now, group and summarize by age:

`cuse2`` `[`%>%`](https://magrittr.tidyverse.org/reference/pipe.html)` `[`group_by`](https://dplyr.tidyverse.org/reference/group_by.html)`(``age``)`` `[`%>%`](https://magrittr.tidyverse.org/reference/pipe.html)` `[`summarize`](https://dplyr.tidyverse.org/reference/summarise.html)`(`[`mean`](https://rdrr.io/r/base/mean.html)`(``fracusing``)``)`

    ## # A tibble: 4 × 2
    ##   age   `mean(fracusing)`
    ##   <fct>             <dbl>
    ## 1 <25               0.188
    ## 2 25-29             0.271
    ## 3 30-39             0.388
    ## 4 40-49             0.469

`cuse2`

    ## # A tibble: 16 × 6
    ##    age   education wantsMore notUsing using fracusing
    ##    <fct> <fct>     <fct>        <dbl> <dbl>     <dbl>
    ##  1 <25   low       yes             53     6     0.102
    ##  2 <25   low       no              10     4     0.286
    ##  3 <25   high      yes            212    52     0.197
    ##  4 <25   high      no              50    10     0.167
    ##  5 25-29 low       yes             60    14     0.189
    ##  6 25-29 low       no              19    10     0.345
    ##  7 25-29 high      yes            155    54     0.258
    ##  8 25-29 high      no              65    27     0.293
    ##  9 30-39 low       yes            112    33     0.228
    ## 10 30-39 low       no              77    80     0.510
    ## 11 30-39 high      yes            118    46     0.280
    ## 12 30-39 high      no              68    78     0.534
    ## 13 40-49 low       yes             35     6     0.146
    ## 14 40-49 low       no              46    48     0.511
    ## 15 40-49 high      yes              8     8     0.5  
    ## 16 40-49 high      no              12    31     0.721

Here the `%>%` is called a “pipe”, and it sends the output of the
previous function to the input of the next function. This could also
have been done in one step:

[`mutate`](https://dplyr.tidyverse.org/reference/mutate.html)`(``cuse``, fracusing ``=`` ``using`` ``/`` ``(``using`` ``+`` ``notUsing``)``)`` `[`%>%`](https://magrittr.tidyverse.org/reference/pipe.html)` `` `[`group_by`](https://dplyr.tidyverse.org/reference/group_by.html)`(``age``)`` `[`%>%`](https://magrittr.tidyverse.org/reference/pipe.html)` `` `` `[`summarize`](https://dplyr.tidyverse.org/reference/summarise.html)`(`[`mean`](https://rdrr.io/r/base/mean.html)`(``fracusing``)``)`

    ## # A tibble: 4 × 2
    ##   age   `mean(fracusing)`
    ##   <fct>             <dbl>
    ## 1 <25               0.188
    ## 2 25-29             0.271
    ## 3 30-39             0.388
    ## 4 40-49             0.469

Here the result is not stored anywhere; if you wanted to store it in a
variable called `myanswer`, you could have started the above command
with `myanswer <-` or `myanswer =`.

Also note that the line breaks are optional: you could put this all on
one line, but breaking it up makes it more readable.

## Write on paper the model for expected probability of using birth control

Based on `fit1`, write on paper the model for expected probability of
using birth control? Don’t forget the (inverse) logit function.

**Solution**

`fit1`` ``<-`` `[`glm`](https://rdrr.io/r/stats/glm.html)`(`` `` `[`cbind`](https://rdrr.io/r/base/cbind.html)`(``using``, ``notUsing``)`` ``~`` ``age`` ``+`` ``education`` ``+`` ``wantsMore``,`` `` data ``=`` ``cuse``,`` `` family ``=`` `[`binomial`](https://rdrr.io/r/stats/family.html)`(``"logit"``)`` ``)`

I’m going to store the coefficients of `fit1` in a new variable `b` just
to save typing when writing out the formula, and round to two decimal
places:

`bcoef`` ``<-`` `[`round`](https://rdrr.io/r/base/Round.html)`(`[`coef`](https://rdrr.io/r/stats/coef.html)`(``fit1``)``, ``2``)`

Here I’m going to take advantage of R Markdown’s support for LaTeX
formulae to write out the fitted regression model. I also use the \` r
2+2 \` syntax (the result is 4) for putting results of R code inline,
instead of writing out numbers of the coefficients. I never wrote the
number “four”, but you’ll have to look at the .Rmd to see how I did
that! Doing this in reports allows you to update them as input data
changes, without having to manually re-enter or copy numbers.

$`P = \textit{logit}^{-1} \left(
   -1.13 + 0.39 \times \textit{age25-29} +
   0.91 \times \textit{age30-39} +
   1.19 \times \textit{age40-49} +
   0.32 \times \textit{educationhigh} +
   -0.83 \times \textit{wantsMoreyes}
   \right)`$

$`\textit{logit}^{-1}(x) = \frac{1}{1+e^{-x}}`$

## What is the expected probability…

Based on `fit1`, what is the expected probability of an individual 25-29
years old, with high education, who wants more children, using birth
control? Calculate it manually, and using `predict(fit1)`

**Solution**

This can be done using the
[`predict()`](https://rdrr.io/r/stats/predict.html) function, using a
new `data.frame` giving the values that you want to predict for:

`invLogit`` ``<-`` ``function``(``x``)`` ``1``/``(``1``+`[`exp`](https://rdrr.io/r/base/Log.html)`(``-``x``)``)`` ``q4data`` ``<-`` `[`data.frame`](https://rdrr.io/r/base/data.frame.html)`(``age``=``"25-29"``, education``=``"high"``, wantsMore``=``"yes"``)`` ``invLogit``(`` `[`predict`](https://rdrr.io/r/stats/predict.html)`(``fit1``, newdata``=``q4data``)`` ``)`

    ##         1 
    ## 0.2223899

By default, [`predict()`](https://rdrr.io/r/stats/predict.html) predicts
on the original data, and taking a look, I noticed that the 7th value is
the one we want to predict on:

`invLogit``(`` `[`predict`](https://rdrr.io/r/stats/predict.html)`(``fit1``)``[``7``]`` ``)`

    ##         7 
    ## 0.2223899

If we were really doing this manually, on paper, we would just calculate
the linear predictor, then use the inverse logit function. Note that
education=“high” is the reference group, so we don’t use it here:

`invLogit``(`` ``bcoef``[``"(Intercept)"``]`` ``+`` ``bcoef``[``"age25-29"``]`` ``+`` ``bcoef``[``"wantsMoreyes"``]`` ``)`

    ## (Intercept) 
    ##   0.1722164

I don’t *really* care, but if the remnant “(Intercept)” name there were
annoying me, I would assign this to a variable then get rid of that
name:

`res`` ``<-`` ``invLogit``(`` ``bcoef``[``"(Intercept)"``]`` ``+`` ``bcoef``[``"age25-29"``]`` ``+`` ``bcoef``[``"wantsMoreyes"``]`` ``)`` `[`names`](https://rdrr.io/r/base/names.html)`(``res``)`` ``<-`` ``NULL`` ``res`

    ## [1] 0.1722164

## Predicted odds ratio

Based on `fit1`: Relative to women under 25 who want to have children,
what is the predicted odds ratio for a woman 40-49 years old who does
*not* want to have children will be taking birth control?

**Solution**

[`exp`](https://rdrr.io/r/base/Log.html)`(`` `[`coef`](https://rdrr.io/r/stats/coef.html)`(``fit1``)``[``"age40-49"``]`` ``-`` `[`coef`](https://rdrr.io/r/stats/coef.html)`(``fit1``)``[``"wantsMoreyes"``]``)`

    ## age40-49 
    ##  7.55488

## Likelihood Ratio Test

Using a likelihood ratio test, is there evidence that a model with
interactions improves on `fit1` (no interactions)?

**Solution**

`fit1.int`` ``<-`` `[`glm`](https://rdrr.io/r/stats/glm.html)`(`[`cbind`](https://rdrr.io/r/base/cbind.html)`(``using``, ``notUsing``)`` ``~`` ``age`` ``*`` ``education`` ``*`` ``wantsMore``, `` `` data``=``cuse``, family``=`[`binomial`](https://rdrr.io/r/stats/family.html)`(``"logit"``)``)`` `[`anova`](https://rdrr.io/r/stats/anova.html)`(``fit1``, ``fit1.int``, test``=``"LRT"``)`

    ## Analysis of Deviance Table
    ## 
    ## Model 1: cbind(using, notUsing) ~ age + education + wantsMore
    ## Model 2: cbind(using, notUsing) ~ age * education * wantsMore
    ##   Resid. Df Resid. Dev Df Deviance  Pr(>Chi)    
    ## 1        10     29.917                          
    ## 2         0      0.000 10   29.917 0.0008838 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

## A model with interactions

Which, if any, variables have the strongest interactions? I use the
“stargazer” package here which is extremely flexible for showing
regression results from all kinds of models, capable of comparing
multiple models or multiple dependent variables in the same table, and
providing formatting customized to numerous journal styles.

**Solution**

We see here that the strongest interaction coeffient is for
`age30-39:wantsMoreyes`. It is statistically significant and negative
(0). It appears that being 30-39 years old and wanting more children has
a multiplicative effect against using birth control, moreso than
expected based on the age or wanting more children alone.

The *stargazer* package is a good way to create nicely-formatted tables
of regression results.

|  |  |  |
|----|----|----|
|  |  |  |
|  |  |  |
|  |  |  |
|  | Outcome: Using Birth Control |  |
|  | No Interaction | With Interactions |
|  | \(1\) | \(2\) |
|  |  |  |
| age25-29 | 0.39^(\*\*) (0.04, 0.73) | 0.27 (-1.12, 1.66) |
| age30-39 | 0.91^(\*\*\*) (0.59, 1.23) | 0.95 (-0.25, 2.16) |
| age40-49 | 1.19^(\*\*\*) (0.77, 1.61) | 0.96 (-0.27, 2.19) |
| educationhigh | 0.32^(\*\*\*) (0.08, 0.57) | -0.69 (-2.04, 0.65) |
| wantsMoreyes | -0.83^(\*\*\*) (-1.06, -0.60) | -1.26^(\*) (-2.70, 0.17) |
| age25-29:educationhigh |  | 0.46 (-1.15, 2.07) |
| age30-39:educationhigh |  | 0.79 (-0.63, 2.21) |
| age40-49:educationhigh |  | 1.60^(\*\*) (0.05, 3.15) |
| age25-29:wantsMoreyes |  | 0.45 (-1.28, 2.18) |
| age30-39:wantsMoreyes |  | 0.002 (-1.52, 1.52) |
| age40-49:wantsMoreyes |  | -0.54 (-2.27, 1.18) |
| educationhigh:wantsMoreyes |  | 1.47^(\*) (-0.15, 3.08) |
| age25-29:educationhigh:wantsMoreyes |  | -0.83 (-2.79, 1.13) |
| age30-39:educationhigh:wantsMoreyes |  | -1.29 (-3.04, 0.47) |
| age40-49:educationhigh:wantsMoreyes |  | -0.61 (-2.83, 1.61) |
| Constant | -1.13^(\*\*\*) (-1.50, -0.77) | -0.92 (-2.08, 0.24) |
|  |  |  |
| Observations | 16 | 16 |
| Log Likelihood | -50.71 | -35.75 |
| Akaike Inf. Crit. | 113.43 | 103.51 |
|  |  |  |
| *Note:* | p\<0.1; p\<0.05; p\<0.01 |  |

## Contrasts between every pair of age groups

Create a model matrix for a fit on age only, with contrasts between
*every pair* of age groups. Between which age groups is the contrast
significant?

**Solution**

### semi-manually

First, I’ll do it manually, using the `multcomp` package and following
an example from [`?glht`](https://rdrr.io/pkg/multcomp/man/glht.html).
I’m not going to bother anymore creating pretty tables with `stargazer`
though…

`fit`` ``=`` `[`glm`](https://rdrr.io/r/stats/glm.html)`(`[`cbind`](https://rdrr.io/r/base/cbind.html)`(``using``, ``notUsing``)`` ``~`` ``age``, data``=``cuse``, family``=`[`binomial`](https://rdrr.io/r/stats/family.html)`(``"logit"``)``)`` `[`coef`](https://rdrr.io/r/stats/coef.html)`(``fit``)`

    ## (Intercept)    age25-29    age30-39    age40-49 
    ##  -1.5071591   0.4606758   1.0482932   1.4246380

`K`` ``<-`` `[`rbind`](https://rdrr.io/r/base/cbind.html)`(``"25-29 - <25"`` ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``0``, ``1``, ``0``, ``0``)``,`` `` ``"30-39 - <25"`` ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``0``, ``0``, ``1``, ``0``)``,`` `` ``"40-49 - <25"`` ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``0``, ``0``, ``0``, ``1``)``,`` `` ``"30-39 - 25-29"`` ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``0``, ``-``1``, ``1``, ``0``)``,`` `` ``"40-49 - 25-29"`` ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``0``, ``-``1``, ``0``, ``1``)``,`` `` ``"40-49 - 30-39"`` ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``0``, ``0``, ``-``1``, ``1``)``)`` ``K`

    ##               [,1] [,2] [,3] [,4]
    ## 25-29 - <25      0    1    0    0
    ## 30-39 - <25      0    0    1    0
    ## 40-49 - <25      0    0    0    1
    ## 30-39 - 25-29    0   -1    1    0
    ## 40-49 - 25-29    0   -1    0    1
    ## 40-49 - 30-39    0    0   -1    1

`fit.all.cont`` ``=`` ``multcomp``::`[`glht`](https://rdrr.io/pkg/multcomp/man/glht.html)`(``fit``, linfct``=``K``)`` `[`summary`](https://rdrr.io/r/base/summary.html)`(``fit.all.cont``)`

    ## 
    ##   Simultaneous Tests for General Linear Hypotheses
    ## 
    ## Fit: glm(formula = cbind(using, notUsing) ~ age, family = binomial("logit"), 
    ##     data = cuse)
    ## 
    ## Linear Hypotheses:
    ##                    Estimate Std. Error z value Pr(>|z|)    
    ## 25-29 - <25 == 0     0.4607     0.1727   2.667   0.0377 *  
    ## 30-39 - <25 == 0     1.0483     0.1544   6.788   <0.001 ***
    ## 40-49 - <25 == 0     1.4246     0.1940   7.345   <0.001 ***
    ## 30-39 - 25-29 == 0   0.5876     0.1406   4.181   <0.001 ***
    ## 40-49 - 25-29 == 0   0.9640     0.1831   5.265   <0.001 ***
    ## 40-49 - 30-39 == 0   0.3763     0.1660   2.268   0.1035    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## (Adjusted p values reported -- single-step method)

### Using Tukey contrasts

There is an easier way if you realize that these are the “Tukey”
contrasts and use the `contrMat` function from the `multcomp` package.
These automatic contrasts assume a no-intercept model, which would be
hard to interpret outside the context of
[`multcomp::contrMat`](https://rdrr.io/pkg/multcomp/man/contrMat.html),
but can be used as an intermediate step to get here.

`fitnoint`` ``=`` `[`glm`](https://rdrr.io/r/stats/glm.html)`(`[`cbind`](https://rdrr.io/r/base/cbind.html)`(``using``, ``notUsing``)`` ``~`` ``age``-``1``, data``=``cuse``, family``=`[`binomial`](https://rdrr.io/r/stats/family.html)`(``"logit"``)``)`` ``K2`` ``=`` ``multcomp``::`[`contrMat`](https://rdrr.io/pkg/multcomp/man/contrMat.html)`(``1``:``4``, type``=``"Tukey"``)`` ``K2`

    ## 
    ##   Multiple Comparisons of Means: Tukey Contrasts
    ## 
    ##        1  2  3 4
    ## 2 - 1 -1  1  0 0
    ## 3 - 1 -1  0  1 0
    ## 4 - 1 -1  0  0 1
    ## 3 - 2  0 -1  1 0
    ## 4 - 2  0 -1  0 1
    ## 4 - 3  0  0 -1 1

`fit.all.cont2`` ``=`` ``multcomp``::`[`glht`](https://rdrr.io/pkg/multcomp/man/glht.html)`(``fitnoint``, linfct``=``K2``)`` `[`summary`](https://rdrr.io/r/base/summary.html)`(``fit.all.cont2``)`

    ## 
    ##   Simultaneous Tests for General Linear Hypotheses
    ## 
    ## Multiple Comparisons of Means: Tukey Contrasts
    ## 
    ## 
    ## Fit: glm(formula = cbind(using, notUsing) ~ age - 1, family = binomial("logit"), 
    ##     data = cuse)
    ## 
    ## Linear Hypotheses:
    ##            Estimate Std. Error z value Pr(>|z|)    
    ## 2 - 1 == 0   0.4607     0.1727   2.667   0.0376 *  
    ## 3 - 1 == 0   1.0483     0.1544   6.788   <0.001 ***
    ## 4 - 1 == 0   1.4246     0.1940   7.345   <0.001 ***
    ## 3 - 2 == 0   0.5876     0.1406   4.181   <0.001 ***
    ## 4 - 2 == 0   0.9640     0.1831   5.265   <0.001 ***
    ## 4 - 3 == 0   0.3763     0.1660   2.268   0.1033    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## (Adjusted p values reported -- single-step method)

We didn’t get the same informative coefficient names this time, but we
can rename the rows in `K2`, for example:

[`rownames`](https://rdrr.io/r/base/colnames.html)`(``K2``)`` ``=`` `[`rownames`](https://rdrr.io/r/base/colnames.html)`(``K``)`` ``K2`

    ## 
    ##   Multiple Comparisons of Means: Tukey Contrasts
    ## 
    ##                1  2  3 4
    ## 25-29 - <25   -1  1  0 0
    ## 30-39 - <25   -1  0  1 0
    ## 40-49 - <25   -1  0  0 1
    ## 30-39 - 25-29  0 -1  1 0
    ## 40-49 - 25-29  0 -1  0 1
    ## 40-49 - 30-39  0  0 -1 1

[`summary`](https://rdrr.io/r/base/summary.html)`(`` ``multcomp``::`[`glht`](https://rdrr.io/pkg/multcomp/man/glht.html)`(``fit``, linfct``=``K2``)`` ``)`

    ## 
    ##   Simultaneous Tests for General Linear Hypotheses
    ## 
    ## Multiple Comparisons of Means: Tukey Contrasts
    ## 
    ## 
    ## Fit: glm(formula = cbind(using, notUsing) ~ age, family = binomial("logit"), 
    ##     data = cuse)
    ## 
    ## Linear Hypotheses:
    ##                    Estimate Std. Error z value Pr(>|z|)    
    ## 25-29 - <25 == 0     1.9678     0.2841   6.926   <0.001 ***
    ## 30-39 - <25 == 0     2.5555     0.2734   9.347   <0.001 ***
    ## 40-49 - <25 == 0     2.9318     0.2975   9.854   <0.001 ***
    ## 30-39 - 25-29 == 0   0.5876     0.1406   4.181   <0.001 ***
    ## 40-49 - 25-29 == 0   0.9640     0.1831   5.265   <0.001 ***
    ## 40-49 - 30-39 == 0   0.3763     0.1660   2.268   0.0979 .  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## (Adjusted p values reported -- single-step method)

### Other contrast schemes

There are plenty of canned contrast schemes provided by
[`multcomp::contrMat`](https://rdrr.io/pkg/multcomp/man/contrMat.html).
Note use of the [`example()`](https://rdrr.io/r/utils/example.html)
function to run all examples from the `contrmat()` function. This is a
great example of how there are **many** ways to analyze one particular
experimental design, but that you need to know design matrices to
utilize many of them.

In these examples, the first line `n <- c(10,20,30,40)` just signifies
four levels, `n = 1:4` would do exactly the same thing.

[`library`](https://rdrr.io/r/base/library.html)`(`[`multcomp`](https://codeberg.org/thothorn/multcomp)`)`` `[`example`](https://rdrr.io/r/utils/example.html)`(``"contrMat"``)`

    ## 
    ## cntrMt>  n <- c(10,20,30,40)
    ## 
    ## cntrMt>  names(n) <- paste("group", 1:4, sep="")
    ## 
    ## cntrMt>  contrMat(n) # Dunnett is default
    ## 
    ##   Multiple Comparisons of Means: Dunnett Contrasts
    ## 
    ##                 group1 group2 group3 group4
    ## group2 - group1     -1      1      0      0
    ## group3 - group1     -1      0      1      0
    ## group4 - group1     -1      0      0      1
    ## 
    ## cntrMt>  contrMat(n, base = 2)   # use second level as baseline
    ## 
    ##   Multiple Comparisons of Means: Dunnett Contrasts
    ## 
    ##                 group1 group2 group3 group4
    ## group1 - group2      1     -1      0      0
    ## group3 - group2      0     -1      1      0
    ## group4 - group2      0     -1      0      1
    ## 
    ## cntrMt>  contrMat(n, type = "Tukey")
    ## 
    ##   Multiple Comparisons of Means: Tukey Contrasts
    ## 
    ##                 group1 group2 group3 group4
    ## group2 - group1     -1      1      0      0
    ## group3 - group1     -1      0      1      0
    ## group4 - group1     -1      0      0      1
    ## group3 - group2      0     -1      1      0
    ## group4 - group2      0     -1      0      1
    ## group4 - group3      0      0     -1      1
    ## 
    ## cntrMt>  contrMat(n, type = "Sequen")
    ## 
    ##   Multiple Comparisons of Means: Sequen Contrasts
    ## 
    ##                 group1 group2 group3 group4
    ## group2 - group1     -1      1      0      0
    ## group3 - group2      0     -1      1      0
    ## group4 - group3      0      0     -1      1
    ## 
    ## cntrMt>  contrMat(n, type = "AVE")
    ## 
    ##   Multiple Comparisons of Means: AVE Contrasts
    ## 
    ##      group1  group2  group3  group4
    ## C 1  1.0000 -0.2222 -0.3333 -0.4444
    ## C 2 -0.1250  1.0000 -0.3750 -0.5000
    ## C 3 -0.1429 -0.2857  1.0000 -0.5714
    ## C 4 -0.1667 -0.3333 -0.5000  1.0000
    ## 
    ## cntrMt>  contrMat(n, type = "Changepoint")
    ## 
    ##   Multiple Comparisons of Means: Changepoint Contrasts
    ## 
    ##      group1  group2  group3 group4
    ## C 1 -1.0000  0.2222  0.3333 0.4444
    ## C 2 -0.3333 -0.6667  0.4286 0.5714
    ## C 3 -0.1667 -0.3333 -0.5000 1.0000
    ## 
    ## cntrMt>  contrMat(n, type = "Williams")
    ## 
    ##   Multiple Comparisons of Means: Williams Contrasts
    ## 
    ##     group1 group2 group3 group4
    ## C 1     -1 0.0000 0.0000 1.0000
    ## C 2     -1 0.0000 0.4286 0.5714
    ## C 3     -1 0.2222 0.3333 0.4444
    ## 
    ## cntrMt>  contrMat(n, type = "Marcus")
    ## 
    ##   Multiple Comparisons of Means: Marcus Contrasts
    ## 
    ##      group1  group2  group3 group4
    ## C 1 -1.0000  0.2222  0.3333 0.4444
    ## C 2 -1.0000  0.0000  0.4286 0.5714
    ## C 3 -0.3333 -0.6667  0.4286 0.5714
    ## C 4 -1.0000  0.0000  0.0000 1.0000
    ## C 5 -0.3333 -0.6667  0.0000 1.0000
    ## C 6 -0.1667 -0.3333 -0.5000 1.0000
    ## 
    ## cntrMt>  contrMat(n, type = "McDermott")
    ## 
    ##   Multiple Comparisons of Means: McDermott Contrasts
    ## 
    ##      group1  group2 group3 group4
    ## C 1 -1.0000  1.0000    0.0      0
    ## C 2 -0.3333 -0.6667    1.0      0
    ## C 3 -0.1667 -0.3333   -0.5      1
    ## 
    ## cntrMt>  ### Umbrella-protected Williams contrasts, i.e. a sequence of 
    ## cntrMt>  ### Williams-type contrasts with groups of higher order 
    ## cntrMt>  ### stepwise omitted
    ## cntrMt>  contrMat(n, type = "UmbrellaWilliams")
    ## 
    ##   Multiple Comparisons of Means: UmbrellaWilliams Contrasts
    ## 
    ##     group1 group2 group3 group4
    ## C 1     -1 0.0000 0.0000 1.0000
    ## C 2     -1 0.0000 0.4286 0.5714
    ## C 3     -1 0.2222 0.3333 0.4444
    ## C 4     -1 0.0000 1.0000 0.0000
    ## C 5     -1 0.4000 0.6000 0.0000
    ## C 6     -1 1.0000 0.0000 0.0000
    ## 
    ## cntrMt>  ### comparison of each group with grand mean of all groups
    ## cntrMt>  contrMat(n, type = "GrandMean")
    ## 
    ##   Multiple Comparisons of Means: GrandMean Contrasts
    ## 
    ##        group1 group2 group3 group4
    ## group1    0.9   -0.2   -0.3   -0.4
    ## group2   -0.1    0.8   -0.3   -0.4
    ## group3   -0.1   -0.2    0.7   -0.4
    ## group4   -0.1   -0.2   -0.3    0.6
