
# spirit: Shiny App to the [sprtt](https://meikesteinhilber.github.io/sprtt/ "https://meikesteinhilber.github.io/sprtt/") Package on CRAN

<!-- badges: start -->

[![codecov](https://codecov.io/gh/MeikeSteinhilber/spirit/branch/master/graph/badge.svg?token=9I3uy1Gt8w)](https://codecov.io/gh/MeikeSteinhilber/spirit)
[![R-CMD-check-ubuntu20.04](https://github.com/MeikeSteinhilber/spirit/actions/workflows/R-CMD-check-ubuntu20.4.yaml/badge.svg?branch=master)](https://github.com/MeikeSteinhilber/spirit/actions/workflows/R-CMD-check-ubuntu20.4.yaml)
[![R-CMD-check-windows-macOs](https://github.com/MeikeSteinhilber/spirit/actions/workflows/R-CMD-check-windows-macOs.yaml/badge.svg?branch=master)](https://github.com/MeikeSteinhilber/spirit/actions/workflows/R-CMD-check-windows-macOs.yaml)
[![lint](https://github.com/MeikeSteinhilber/spirit/actions/workflows/lint.yaml/badge.svg?branch=master)](https://github.com/MeikeSteinhilber/spirit/actions/workflows/lint.yaml)

<!-- badges: end -->

## Open the app

Please click
[**here**](https://meike-steinhilber.shinyapps.io/spirit/ "https://meike-steinhilber.shinyapps.io/spirit/")
to open the app in your internet browser!

## Requirements to use the app

-   **Internet connection** (otherwise you have to install the app
    locally on your computer)

-   No R knowledge is required to use the app

-   No installation of R & RStudio is necessary

The `spirit` app allows you to use the
[sprtt](https://meikesteinhilber.github.io/sprtt/ "https://meikesteinhilber.github.io/sprtt/")
package via a user interface. The
[sprtt](https://meikesteinhilber.github.io/sprtt/ "https://meikesteinhilber.github.io/sprtt/")
package is the implementation of **s**equential **p**robability
**r**atio **t**ests using the associated **t**-statistic (**sprtt**).

## Installation

There is no need to install the `spirit` shiny app on your computer -
you can access the app on the internet! Please click
[**here**](https://meike-steinhilber.shinyapps.io/spirit/ "https://meike-steinhilber.shinyapps.io/spirit/")
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
devtools::install_github("MeikeSteinhilber/spirit")
```
