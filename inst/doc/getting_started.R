### R code from vignette source 'getting_started.Rnw'

###################################################
### code chunk number 1: setup
###################################################
library(knitr)
opts_chunk$set(size='small')


###################################################
### code chunk number 2: getting_started.Rnw:40-42
###################################################
library(rspa)
library(editrules)


###################################################
### code chunk number 3: getting_started.Rnw:130-135
###################################################
E <- editmatrix(expression(
    x5 == x1 + x8,
    x5 == x3 + x4,
    x8 == x6 + x7,
    x4 > 0))


###################################################
### code chunk number 4: getting_started.Rnw:140-149
###################################################
x <- c(
   x1=330,
   x2=20,
   x3=1000,
   x4=30,
   x5=950,
   x6=500,
   x7=200,
   x8=700)


###################################################
### code chunk number 5: getting_started.Rnw:153-154
###################################################
violatedEdits(E,x,tol=1e-2)


###################################################
### code chunk number 6: getting_started.Rnw:164-165
###################################################
E <- reduce(substValue(E,'x5',x['x5']))


###################################################
### code chunk number 7: getting_started.Rnw:170-171
###################################################
(y <- adjust(E, x))


###################################################
### code chunk number 8: getting_started.Rnw:178-179
###################################################
violatedEdits(E, y$x, tol = 1e-2)


###################################################
### code chunk number 9: getting_started.Rnw:207-208
###################################################
set.seed(1976)


###################################################
### code chunk number 10: getting_started.Rnw:210-222
###################################################
F <- editmatrix(expression(
   x + y == z,
   x >= 0,
   y >= 0,
   z >=0
))
N <- 100
dat <- data.frame(
   x = runif(100),
   y = rnorm(100),
   z = rlnorm(100)
)


###################################################
### code chunk number 11: getting_started.Rnw:227-229
###################################################
A <- adjustRecords(F,dat)
summary(A)


###################################################
### code chunk number 12: getting_started.Rnw:239-240
###################################################
plot(A)


###################################################
### code chunk number 13: getting_started.Rnw:295-296
###################################################
E


###################################################
### code chunk number 14: getting_started.Rnw:301-307
###################################################
rc <- data.frame(
   row = c( 1, 1, 2, 2, 3, 3, 3, 4),
   col = c( 1, 2, 3, 4, 2, 5, 6, 4),
  coef = c(-1,-1,-1,-1, 1,-1,-1,-1)
)
b <- c(-950, -950, 0,0)


###################################################
### code chunk number 15: getting_started.Rnw:311-313
###################################################
e <- sparseConstraints(rc, b, neq=3, sorted=TRUE)
e


###################################################
### code chunk number 16: getting_started.Rnw:336-338
###################################################
x_sparse <- c(330, 700, 1000, 30, 500, 200) 
(adjust(e, x_sparse))


###################################################
### code chunk number 17: getting_started.Rnw:357-394 (eval = FALSE)
###################################################
## library(LaF)
## ## Loading required package: Rcpp
## library(rspa)
## ## Loading required package: editrules
##  
## # read A-matrix
## laf <- laf_open_fwf(
##     file = "prob2A.txt",
##     column_types = c("integer","integer","double"),
##     column_widths = c(10,10,4)
##     )
## rowcol <- laf[]
## laf <- close(laf)
##  
## # read b-vector
## b <- read.csv("prob2b.txt",header=FALSE)[,1]
##  
## # read x-vector
## x <- read.csv("prob2x.txt",header=FALSE)[,1]
##  
## e <- sparseConstraints(rowcol,b,neq=length(b))
## e
## ## Sparse numerical constraints.
## ##  Variables   : 474948
## ##  Restrictions: 60675 (printing 0)
##  
## y <- adjust(e, x)
## y
## ## Object of class 'adjusted'
## ##  Status    : success (using 'sparse' method)
## ##  Accuracy  : 0.00770226
## ##  Objective : 47430.5
## ##  Iterations: 552
## ##  Timing (s): 5.661
## ## Solution (truncated at 10):
## ## [1]  5.4028322  3.5246546  3.7979088  1.1202164  2.5304367  0.2037056
## ## [7] 97.9161357  1.5714899  4.5743395 -1.1756605


###################################################
### code chunk number 18: getting_started.Rnw:460-463
###################################################
e <- editmatrix(expression( x < 0, x > 1))
isFeasible(e)
adjust(e,c(x=0.5))


