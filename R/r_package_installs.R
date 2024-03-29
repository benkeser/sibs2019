#!/usr/bin/env Rscript

# attempt to quiet down the package install outputs

# store a copy of system2
assign("system2.default", base::system2, baseenv())

# create a quiet version of system2
assign("system2.quiet", function(...){
  dots <- list(...)
  dots$stdout <- FALSE
  do.call("system2.default", dots)
}, baseenv())
# overwrite system2 with the quiet version
assignInNamespace("system2", system2.quiet, "base")

grbg <- function(...){
  a <- list(...)
}


# install packages
pkg <- c(
  "xgboost",
  "nnet",
  "glmnet",
  "ranger",
  "rpart",
  "SuperLearner",
  "nloptr",
  "quadprog",
  "ggplot2", 
  "SuperLearner"
)


for(p in pkg){
	suppressMessages(install.packages(p))
}