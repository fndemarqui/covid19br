
<!-- README.md is generated from README.Rmd. Please edit that file -->

# covid19br

<!-- badges: start -->

[![R build
status](https://github.com/fndemarqui/covid19br/workflows/R-CMD-check/badge.svg)](https://github.com/fndemarqui/covid19br/actions)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/covid19br)](https://cran.r-project.org/package=covid19br)
[![Downloads](https://cranlogs.r-pkg.org/badges/covid19br)](https://cran.r-project.org/package=covid19br)
[![Total
Downloads](https://cranlogs.r-pkg.org/badges/grand-total/covid19br?color=orange)](https://cran.r-project.org/package=covid19br)
<!-- [![R-CMD-check](https://github.com/fndemarqui/covid19br/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/fndemarqui/covid19br/actions/workflows/R-CMD-check.yaml) -->
<!-- badges: end -->

The goal of the package is to provide a function to automatically import
the Brazilian COVID-19 pandemic data into R. Brazilian data is available
on country, region, state, and city levels, and are downloaded from the
official Brazilian repository at \<<https://covid.saude.gov.br/>\>. The
package also enables one to download the world-level COVID-19 data from
the Johns Hopkins University’s repository at
\<<https://github.com/CSSEGISandData/COVID-19>\>.

## Installation

You can install the released version of covid19br from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("covid19br")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("fndemarqui/covid19br")
```

## Example

Downloading COVID-19 pandemic data:

``` r
library(covid19br)
library(tidyverse)

brazil <- downloadCovid19("brazil")
regions <- downloadCovid19("regions")
states <- downloadCovid19("states")
cities <- downloadCovid19("cities")
world <- downloadCovid19("world")
```
