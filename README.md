# smartOASYS

## Overview

This package implements methodologies for smart meters data.

## Installation

``` r
#install the package
#devtools::install_github("aefdz/smartOASYS")
devtools::load_all()
```

``` r
#load the package
library(smartOASYS)
```

## Test usage

Load the example data and plot it.

``` r
data("solarPlant1")

par(mfrow = c(3,1))

matplot(solarPlant1$raw0[,1,], type = "l", main = "Raw")
matplot(solarPlant1$smooth0[,1,], type = "l", main = "Zero derivative smooth")
matplot(solarPlant1$smooth1[,1,], type = "l", main = "First derivative smooth")
```

![](README_files/figure-markdown_github/unnamed-chunk-3-1.png)

## References

Elías, A., Morales. J. M. and Pineda, S. (2021). Depth-based Outlier
Detection for Grouped SmartMeters: a Functional Data Analysis Toolbox.
\[link\]<link>.
