
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
#>        op_code op_code_int     type
#> 1           12          12  OPERAND
#> 2   LDCONST.OP          16 OPERATOR
#> 3            1           1  OPERAND
#> 4    SETVAR.OP          22 OPERATOR
#> 5            3           3  OPERAND
#> 6       POP.OP           4 OPERATOR
#> 7   LDCONST.OP          16 OPERATOR
#> 8            5           5  OPERAND
#> 9  STARTFOR.OP          11 OPERATOR
#> 10           9           9  OPERAND
#> 11           8           8  OPERAND
#> 12          21          21  OPERAND
#> 13   GETVAR.OP          20 OPERATOR
#> 14           3           3  OPERAND
#> 15  LDCONST.OP          16 OPERATOR
#> 16           1           1  OPERAND
#> 17      ADD.OP          44 OPERATOR
#> 18          10          10  OPERAND
#> 19   SETVAR.OP          22 OPERATOR
#> 20           3           3  OPERAND
#> 21      POP.OP           4 OPERATOR
#> 22  STEPFOR.OP          12 OPERATOR
#> 23          12          12  OPERAND
#> 24   ENDFOR.OP          13 OPERATOR
#> 25      POP.OP           4 OPERATOR
#> 26   GETVAR.OP          20 OPERATOR
#> 27           3           3  OPERAND
#> 28   RETURN.OP           1 OPERATOR
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
#>                     name args code
#> 1          BCMISMATCH.OP    0    0
#> 2              RETURN.OP    0    1
#> 3                GOTO.OP    1    2
#> 4             BRIFNOT.OP    2    3
#> 5                 POP.OP    0    4
#> 6                 DUP.OP    0    5
#> 7          PRINTVALUE.OP    0    6
#> 8      STARTLOOPCNTXT.OP    2    7
#> 9        ENDLOOPCNTXT.OP    1    8
#> 10         DOLOOPNEXT.OP    0    9
#> 11        DOLOOPBREAK.OP    0   10
#> 12           STARTFOR.OP    3   11
#> 13            STEPFOR.OP    1   12
#> 14             ENDFOR.OP    0   13
#> 15         SETLOOPVAL.OP    0   14
#> 16          INVISIBLE.OP    0   15
#> 17            LDCONST.OP    1   16
#> 18             LDNULL.OP    0   17
#> 19             LDTRUE.OP    0   18
#> 20            LDFALSE.OP    0   19
#> 21             GETVAR.OP    1   20
#> 22              DDVAL.OP    1   21
#> 23             SETVAR.OP    1   22
#> 24             GETFUN.OP    1   23
#> 25         GETGLOBFUN.OP    1   24
#> 26          GETSYMFUN.OP    1   25
#> 27         GETBUILTIN.OP    1   26
#> 28     GETINTLBUILTIN.OP    1   27
#> 29           CHECKFUN.OP    0   28
#> 30           MAKEPROM.OP    1   29
#> 31          DOMISSING.OP    0   30
#> 32             SETTAG.OP    1   31
#> 33             DODOTS.OP    0   32
#> 34            PUSHARG.OP    0   33
#> 35       PUSHCONSTARG.OP    1   34
#> 36        PUSHNULLARG.OP    0   35
#> 37        PUSHTRUEARG.OP    0   36
#> 38       PUSHFALSEARG.OP    0   37
#> 39               CALL.OP    1   38
#> 40        CALLBUILTIN.OP    1   39
#> 41        CALLSPECIAL.OP    1   40
#> 42        MAKECLOSURE.OP    1   41
#> 43             UMINUS.OP    1   42
#> 44              UPLUS.OP    1   43
#> 45                ADD.OP    1   44
#> 46                SUB.OP    1   45
#> 47                MUL.OP    1   46
#> 48                DIV.OP    1   47
#> 49               EXPT.OP    1   48
#> 50               SQRT.OP    1   49
#> 51                EXP.OP    1   50
#> 52                 EQ.OP    1   51
#> 53                 NE.OP    1   52
#> 54                 LT.OP    1   53
#> 55                 LE.OP    1   54
#> 56                 GE.OP    1   55
#> 57                 GT.OP    1   56
#> 58                AND.OP    1   57
#> 59                 OR.OP    1   58
#> 60                NOT.OP    1   59
#> 61            DOTSERR.OP    0   60
#> 62        STARTASSIGN.OP    1   61
#> 63          ENDASSIGN.OP    1   62
#> 64        STARTSUBSET.OP    2   63
#> 65         DFLTSUBSET.OP    0   64
#> 66     STARTSUBASSIGN.OP    2   65
#> 67      DFLTSUBASSIGN.OP    0   66
#> 68             STARTC.OP    2   67
#> 69              DFLTC.OP    0   68
#> 70       STARTSUBSET2.OP    2   69
#> 71        DFLTSUBSET2.OP    0   70
#> 72    STARTSUBASSIGN2.OP    2   71
#> 73     DFLTSUBASSIGN2.OP    0   72
#> 74             DOLLAR.OP    2   73
#> 75         DOLLARGETS.OP    2   74
#> 76             ISNULL.OP    0   75
#> 77          ISLOGICAL.OP    0   76
#> 78          ISINTEGER.OP    0   77
#> 79           ISDOUBLE.OP    0   78
#> 80          ISCOMPLEX.OP    0   79
#> 81        ISCHARACTER.OP    0   80
#> 82           ISSYMBOL.OP    0   81
#> 83           ISOBJECT.OP    0   82
#> 84          ISNUMERIC.OP    0   83
#> 85          VECSUBSET.OP    1   84
#> 86          MATSUBSET.OP    1   85
#> 87       VECSUBASSIGN.OP    1   86
#> 88       MATSUBASSIGN.OP    1   87
#> 89             AND1ST.OP    2   88
#> 90             AND2ND.OP    1   89
#> 91              OR1ST.OP    2   90
#> 92              OR2ND.OP    1   91
#> 93      GETVAR_MISSOK.OP    1   92
#> 94       DDVAL_MISSOK.OP    1   93
#> 95            VISIBLE.OP    0   94
#> 96            SETVAR2.OP    1   95
#> 97       STARTASSIGN2.OP    1   96
#> 98         ENDASSIGN2.OP    1   97
#> 99        SETTER_CALL.OP    2   98
#> 100       GETTER_CALL.OP    1   99
#> 101              SWAP.OP    0  100
#> 102            DUP2ND.OP    0  101
#> 103            SWITCH.OP    4  102
#> 104         RETURNJMP.OP    0  103
#> 105     STARTSUBSET_N.OP    2  104
#> 106  STARTSUBASSIGN_N.OP    2  105
#> 107        VECSUBSET2.OP    1  106
#> 108        MATSUBSET2.OP    1  107
#> 109     VECSUBASSIGN2.OP    1  108
#> 110     MATSUBASSIGN2.OP    1  109
#> 111    STARTSUBSET2_N.OP    2  110
#> 112 STARTSUBASSIGN2_N.OP    2  111
#> 113          SUBSET_N.OP    2  112
#> 114         SUBSET2_N.OP    2  113
#> 115       SUBASSIGN_N.OP    2  114
#> 116      SUBASSIGN2_N.OP    2  115
#> 117               LOG.OP    1  116
#> 118           LOGBASE.OP    1  117
#> 119             MATH1.OP    2  118
#> 120           DOTCALL.OP    2  119
#> 121             COLON.OP    1  120
#> 122          SEQALONG.OP    1  121
#> 123            SEQLEN.OP    1  122
#> 124         BASEGUARD.OP    2  123
#> 125            INCLNK.OP    0  124
#> 126            DECLNK.OP    0  125
#> 127          DECLNK_N.OP    1  126
#> 128         INCLNKSTK.OP    0  127
#> 129         DECLNKSTK.OP    0  128
```

You can also evaluate the byte code

``` r
eval_code(tidy_bytecode(some_code))
#> [1] 11
```
