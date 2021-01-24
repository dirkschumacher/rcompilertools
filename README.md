
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rcompilertools

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of rcompilertools is access work with R’s bytecode. Not a lot
to see at the moment.

## Installation

``` r
remotes::install_github("dirkschumacher/rcompilertools")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(rcompilertools)

some_code <- quote({
  x <- 1
  for (i in 1:10) x <- x + 1
  x
})

tidy_bytecode(some_code)
#> $code
#> # A tibble: 28 x 3
#>    op_code     op_code_int type    
#>    <chr>             <int> <chr>   
#>  1 12                   12 OPERAND 
#>  2 LDCONST.OP           16 OPERATOR
#>  3 1                     1 OPERAND 
#>  4 SETVAR.OP            22 OPERATOR
#>  5 3                     3 OPERAND 
#>  6 POP.OP                4 OPERATOR
#>  7 LDCONST.OP           16 OPERATOR
#>  8 5                     5 OPERAND 
#>  9 STARTFOR.OP          11 OPERATOR
#> 10 9                     9 OPERAND 
#> # … with 18 more rows
#> 
#> $constant_pool
#> $constant_pool[[1]]
#> {
#>     x <- 1
#>     for (i in 1:10) x <- x + 1
#>     x
#> }
#> 
#> $constant_pool[[2]]
#> [1] 1
#> 
#> $constant_pool[[3]]
#> x <- 1
#> 
#> $constant_pool[[4]]
#> x
#> 
#> $constant_pool[[5]]
#> x <- 1
#> 
#> $constant_pool[[6]]
#>  [1]  1  2  3  4  5  6  7  8  9 10
#> 
#> $constant_pool[[7]]
#> 1:10
#> 
#> $constant_pool[[8]]
#> for (i in 1:10) x <- x + 1
#> 
#> $constant_pool[[9]]
#> i
#> 
#> $constant_pool[[10]]
#> for (i in 1:10) x <- x + 1
#> 
#> $constant_pool[[11]]
#> x + 1
#> 
#> $constant_pool[[12]]
#> x <- x + 1
#> 
#> $constant_pool[[13]]
#> x
#> 
#> $constant_pool[[14]]
#>  [1] NA  1  1  4  4  4  6  6  9  9  9  9  3  3  1  1 10 10 11 11  9  9  9  9  9
#> [26]  3  3  3
#> attr(,"class")
#> [1] "expressionsIndex"
#> 
#> $constant_pool[[15]]
#>  [1] NA  2  2  2  2  2  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7  7
#> [26] 12 12 12
#> attr(,"class")
#> [1] "srcrefsIndex"
#> 
#> 
#> attr(,"class")
#> [1] "tidy_bytecode"
```

You can also get all OP codes

``` r
opcodes()
#> # A tibble: 129 x 3
#>    name               args  code
#>    <chr>             <int> <int>
#>  1 BCMISMATCH.OP         0     0
#>  2 RETURN.OP             0     1
#>  3 GOTO.OP               1     2
#>  4 BRIFNOT.OP            2     3
#>  5 POP.OP                0     4
#>  6 DUP.OP                0     5
#>  7 PRINTVALUE.OP         0     6
#>  8 STARTLOOPCNTXT.OP     2     7
#>  9 ENDLOOPCNTXT.OP       1     8
#> 10 DOLOOPNEXT.OP         0     9
#> # … with 119 more rows
```

You can also evaluate the byte code

``` r
eval_code(tidy_bytecode(some_code))
#> [1] 11
```
