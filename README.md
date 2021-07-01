# smartOASYS

## Overview

This package implements methodologies for smart meters data.

## Installation

``` r
#install the package
devtools::install_github("aefdz/smartOASYS")
```

    ## mvtnorm    (1.1-1  -> 1.1-2 ) [CRAN]
    ## cli        (2.5.0  -> 3.0.0 ) [CRAN]
    ## colorspace (2.0-0  -> 2.0-2 ) [CRAN]
    ## mime       (0.10   -> 0.11  ) [CRAN]
    ## pillar     (1.6.0  -> 1.6.1 ) [CRAN]
    ## fansi      (0.4.2  -> 0.5.0 ) [CRAN]
    ## stringi    (1.5.3  -> 1.6.2 ) [CRAN]
    ## xfun       (0.23   -> 0.24  ) [CRAN]
    ## tibble     (3.1.1  -> 3.1.2 ) [CRAN]
    ## viridis    (0.6.0  -> 0.6.1 ) [CRAN]
    ## htmlTable  (2.1.0  -> 2.2.1 ) [CRAN]
    ## ggplot2    (3.3.3  -> 3.3.5 ) [CRAN]
    ## plot3D     (1.3    -> 1.4   ) [CRAN]
    ## multicool  (0.1-11 -> 0.1-12) [CRAN]
    ## ks         (1.12.0 -> 1.13.1) [CRAN]
    ## fdapace    (0.5.6  -> 0.5.7 ) [CRAN]
    ## 
    ##   There are binary versions available but the source versions are later:
    ##            binary source needs_compilation
    ## cli         2.5.0  3.0.0              TRUE
    ## colorspace  2.0-1  2.0-2              TRUE
    ## 
    ##   Binaries will be installed
    ## package 'mvtnorm' successfully unpacked and MD5 sums checked
    ## package 'cli' successfully unpacked and MD5 sums checked
    ## package 'colorspace' successfully unpacked and MD5 sums checked
    ## package 'mime' successfully unpacked and MD5 sums checked
    ## package 'pillar' successfully unpacked and MD5 sums checked
    ## package 'fansi' successfully unpacked and MD5 sums checked
    ## package 'stringi' successfully unpacked and MD5 sums checked

    ## Warning: cannot remove prior installation of package 'stringi'

    ## Warning in file.copy(savedcopy, lib, recursive = TRUE): problema al copiar C:
    ## \Users\UX325\Documents\R\win-library\4.0\00LOCK\stringi\libs\icudt61l.dat a C:
    ## \Users\UX325\Documents\R\win-library\4.0\stringi\libs\icudt61l.dat: Invalid
    ## argument

    ## Warning in file.copy(savedcopy, lib, recursive = TRUE): problema al copiar C:
    ## \Users\UX325\Documents\R\win-library\4.0\00LOCK\stringi\libs\x64\stringi.dll
    ## a C:\Users\UX325\Documents\R\win-library\4.0\stringi\libs\x64\stringi.dll:
    ## Permission denied

    ## Warning: restored 'stringi'

    ## package 'xfun' successfully unpacked and MD5 sums checked

    ## Warning: cannot remove prior installation of package 'xfun'

    ## Warning in file.copy(savedcopy, lib, recursive = TRUE): problema al copiar C:
    ## \Users\UX325\Documents\R\win-library\4.0\00LOCK\xfun\libs\x64\xfun.dll a C:
    ## \Users\UX325\Documents\R\win-library\4.0\xfun\libs\x64\xfun.dll: Permission
    ## denied

    ## Warning: restored 'xfun'

    ## package 'tibble' successfully unpacked and MD5 sums checked
    ## package 'viridis' successfully unpacked and MD5 sums checked
    ## package 'htmlTable' successfully unpacked and MD5 sums checked
    ## package 'ggplot2' successfully unpacked and MD5 sums checked
    ## package 'plot3D' successfully unpacked and MD5 sums checked
    ## package 'multicool' successfully unpacked and MD5 sums checked
    ## package 'ks' successfully unpacked and MD5 sums checked
    ## package 'fdapace' successfully unpacked and MD5 sums checked
    ## 
    ## The downloaded binary packages are in
    ##  C:\Users\UX325\AppData\Local\Temp\Rtmp271vpT\downloaded_packages
    ##          checking for file 'C:\Users\UX325\AppData\Local\Temp\Rtmp271vpT\remotes437c6b5353e4\groupoasys-smartOASYS-cab5897/DESCRIPTION' ...  v  checking for file 'C:\Users\UX325\AppData\Local\Temp\Rtmp271vpT\remotes437c6b5353e4\groupoasys-smartOASYS-cab5897/DESCRIPTION'
    ##       -  preparing 'smartOASYS':
    ##    checking DESCRIPTION meta-information ...     checking DESCRIPTION meta-information ...   v  checking DESCRIPTION meta-information
    ##       -  checking for LF line-endings in source and make files and shell scripts
    ##   -  checking for empty or unneeded directories
    ##       -  building 'smartOASYS_0.1.0.tar.gz'
    ##      
    ## 

``` r
#load the package
library(smartOASYS)
```

## Test usage

Load the example data and plot one day for the 22 inverters.

``` r
data("solarPlant1")


matplot(solarPlant1$raw0[,1,], type = "l", main = "Raw")
```

![](README_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
matplot(solarPlant1$smooth0[,1,], type = "l", main = "Zero derivative smooth")
```

![](README_files/figure-markdown_github/unnamed-chunk-3-2.png)

``` r
matplot(solarPlant1$smooth1[,1,], type = "l", main = "First derivative smooth")
```

![](README_files/figure-markdown_github/unnamed-chunk-3-3.png)

## References

Elías, A., Morales. J. M. and Pineda, S. (2021). Depth-based Outlier
Detection for Grouped SmartMeters: a Functional Data Analysis Toolbox.
\[link\]<link>.
