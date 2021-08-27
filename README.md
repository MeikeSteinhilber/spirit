
# sprtt Shiny App

<!-- badges: start -->

[![test-coverage](https://github.com/MeikeSteinhilber/Snowflake/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/MeikeSteinhilber/Snowflake/actions/workflows/test-coverage.yaml)

<!-- badges: end -->

## Overview

Snowflake is the shiny app to the sprtt package on CRAN.

The `sprtt` package is the implementation of **s**equential
**p**robability **r**atio **t**ests using the associated **t**-statistic
(**sprtt**).

The package contains:

-   `seq_ttest()` calculates the sequential test statistic and

-   three data sets (`df_income`, `df_stress`, `df_cancer`) to run the
    examples in the documentation

## Installation

### Development version from GitHub

To get a bug fix or to use a feature from the development version, you
can install the development version from GitHub.

``` r
# the installation requires the "devtools" package
# install.packages("devtools")
devtools::install_github("MeikeSteinhilber/Snowflake")
```