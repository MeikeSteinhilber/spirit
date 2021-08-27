
# sprtt Shiny App

<!-- badges: start -->

[![codecov](https://codecov.io/gh/MeikeSteinhilber/sprtt/branch/master/graph/badge.svg?token=IQHTDTRBAW)](https://codecov.io/gh/MeikeSteinhilber/sprtt)
[![R-CMD-check-ubuntu20.04](https://github.com/MeikeSteinhilber/Snowflake/actions/workflows/R-CMD-check-ubuntu20.4.yaml/badge.svg?branch=master)](https://github.com/MeikeSteinhilber/Snowflake/actions/workflows/R-CMD-check-ubuntu20.4.yaml)
[![R-CMD-check-windows-macOs](https://github.com/MeikeSteinhilber/Snowflake/actions/workflows/R-CMD-check-windows-macOs.yaml/badge.svg?branch=master)](https://github.com/MeikeSteinhilber/Snowflake/actions/workflows/R-CMD-check-windows-macOs.yaml)
[![lint](https://github.com/MeikeSteinhilber/Snowflake/actions/workflows/lint.yaml/badge.svg?branch=master)](https://github.com/MeikeSteinhilber/Snowflake/actions/workflows/lint.yaml)

<!-- badges: end -->

## Overview

**Snowflake** is the shiny app to the
[sprtt](https://meikesteinhilber.github.io/sprtt/ "https://meikesteinhilber.github.io/sprtt/")
package on CRAN. Please click
[**here**](meike-steinhilber.shinyapps.io/sprtt/ "meike-steinhilber.shinyapps.io/sprtt/")
to open the app in your browser!

No R knowledge is required to use the app!

The `sprtt` package is the implementation of **s**equential
**p**robability **r**atio **t**ests using the associated **t**-statistic
(**sprtt**).

The package contains:

-   `seq_ttest()` calculates the sequential test statistic and

-   three data sets (`df_income`, `df_stress`, `df_cancer`) to run the
    examples in the documentation

## Installation

There is no need to install the shiny app on your computer - you can
access the app on the internet! Please click
[**here**](meike-steinhilber.shinyapps.io/sprtt/ "meike-steinhilber.shinyapps.io/sprtt/")
to open the app in your browser!

If you want to use the app *without* an internet connection, please
download the app as an R package on your computer. To run the app
locally on your computer, R (and RStudio) have to be already installed .

### Development version from GitHub

To get a bug fix or to use a feature from the development version, you
can install the development version from GitHub.

``` r
# the installation requires the "devtools" package
# install.packages("devtools")
devtools::install_github("MeikeSteinhilber/Snowflake")
```
