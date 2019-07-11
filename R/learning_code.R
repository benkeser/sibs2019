## An R-script demonstrating some ML algorithms

# first load two data sets
load("/home/data/train_data.RData")
load("/home/data/test_data.RData")
# two data.frames now in memory
ls()

# check out what the "training data" look like
head(a) # first six rows
dim(a) # dimension of data

# check out what the "test data" look like
head(b) # first six rows
dim(b) # dimension of data

# make a version for fitting continuous models
a_cont <- a[ , -ncol(a)]
# make a version for fitting binary models
a_bin <- a[ , -(ncol(a) - 1)]

#-------------------------------
# generalized linear models
#-------------------------------
# we use the familiar glm function
# linear regression for continuous outcome
# continuous_Y ~ . means fit main terms
lm_fit <- glm(continuous_Y ~ ., data = a_cont) 

# look at fitted model
lm_fit

# get predicted outcomes on new data
lm_test_pred <- predict(lm_fit, newdata = b, type = "response")

# look at predictions
lm_test_pred

# logistic regression for binary outcome
glm_fit <- glm(binary_Y ~ ., data = a_bin, family = binomial())

# look at fitted model
glm_fit

# get predicted outcomes on new data
glm_test_pred <- predict(glm_fit, newdata = b, type = "response")

# look at predictions
glm_test_pred

#-------------------------------
# stepwise regression
#-------------------------------
# we can use the step() function for fitting stepwise regression
# first fit reduced model (intercept only)
start_model <- glm(continuous_Y ~ 1, data = a_cont)
stepwise_fit  <- step(start_model, scope = formula(lm_fit), 
                      direction = "forward")

# look at fitted model
stepwise_fit

# get predicted outcomes on new data
stepwise_test_pred <- predict(stepwise_fit, newdata = b, 
                              type = "response")

#-------------------------------
# penalization
#-------------------------------
# we use the glmnet package
library(glmnet)
# glmnet needs a matrix of predictors
x <- as.matrix(a[ , paste0("X", 1:10)]) 

# linear regression for continuous outcome
glmnet_fit <- glmnet(y = a$continuous_Y, 
                     x = x)

# this fits LOTS of regression models
# one for each lambda (penalty parameter)
glmnet_fit$beta

# we can predict for a particular value of lambda
glmnet_test_pred <- predict(glmnet_fit, newx = as.matrix(b))

# this makes a matrix of predictions
dim(glmnet_test_pred)

# pick your favorite value of lambda!

# logistic regression for binary outcome
glmnet_fit2 <- glmnet(y = a$binary_Y, 
                      x = x, family = "binomial")

# we can predict for a particular value of lambda
glmnet_test_pred2 <- predict(glmnet_fit2, newx = as.matrix(b),
                             type = "response")

# this makes a matrix of predictions
dim(glmnet_test_pred)

# to use a different regression formula, first use
# model.matrix() function. this one uses all two-way interactions
another_x <- model.matrix(~ .^2, data = a[ , paste0("X", 1:10)])
# this one uses a specific regression formula
another_x <- model.matrix(~ X1 + X2 + I(X3^2) + X4*X5, data = a[ , paste0("X", 1:10)])

# linear regression for continuous outcome
glmnet_fit3 <- glmnet(y = a$continuous_Y, 
                      x = another_x, alpha = 0.5)

# to use cross-validation, use cv.glmnet
cvglmnet_fit <- cv.glmnet(y = a$continuous_Y, 
                          x = x)

# CV-selected value of lambda
cvglmnet_fit$lambda.min

# predict from regression with CV-selected lambda
cvglmnet_test_pred <- predict(cvglmnet_fit, newx = as.matrix(b),
                              s = "lambda.min")

#---------------------------------------
# regression and classification trees
#---------------------------------------
# load rpart package
library(rpart)

# fit a regression tree for continuous outcome
rpart_fit <- rpart(continuous_Y ~ ., data = a_cont)

# visualize the tree
par(mar = c(0,0,0,0))
plot(rpart_fit); text(rpart_fit)

# get predictions on new data
rpart_test_pred <- predict(rpart_fit, newdata = b)

# fit a regression tree for binary outcome
rpart_fit2 <- rpart(binary_Y ~ ., data = a_bin, 
                    method = "class")

# visualize the tree
par(mar = c(0,0,0,0))
plot(rpart_fit2); text(rpart_fit2)

# get predictions on new data
rpart_test_pred2 <- predict(rpart_fit2, newdata = b)

# look at how it's formatted
head(rpart_test_pred2) 

# various options controlled by rpart.control()
my_control <- rpart.control(minsplit = 2, maxdepth = 20, 
                            cp = 0.001)

another_rpart_fit <- rpart(continuous_Y ~ ., 
                           data = a_cont,
                           control = my_control)
# visualize the tree
plot(another_rpart_fit); text(another_rpart_fit)

#---------------------------------------
# random forest
#---------------------------------------
# we use ranger package
library(ranger)

# fit a random forest for continuous outcome
ranger_fit <- ranger(continuous_Y ~ . , data = a_cont,
                     mtry = 3) # how many covariates to use in each tree

# print object
ranger_fit

# get predictions on new data
ranger_test_pred <- predict(ranger_fit, data = b)

# stored in the $predictions slot
ranger_test_pred$predictions

# for binary we need a factor outcome
ranger_fit2 <- ranger(I(factor(binary_Y)) ~ . , data = a_bin,
                      mtry = 3, probability = TRUE) 

# print object
ranger_fit2

# get predictions on new data
ranger_test_pred2 <- predict(ranger_fit2, data = b)

# stored in the $predictions slot
head(ranger_test_pred2$predictions)

#---------------------------------------
# xgboost
#---------------------------------------
# we will use xgboost package
library(xgboost)

# need to format predictors in specific way
xgmat <- xgb.DMatrix(data = as.matrix(a_cont[, -ncol(a_cont)]), 
                     label = a_cont$continuous_Y)

# fit boosted model
xgboost_fit <- xgboost(data = xgmat, objective = "reg:linear",
                       nrounds = 500)

# get predictions on new data
# make specific formatted new data
xgboost_test_pred <- predict(xgboost_fit, newdata = as.matrix(b))

#------------------------------------------
# Super Learner
#------------------------------------------
# we will use the SuperLearner package
library(SuperLearner)

# see all ML functions that play nicely with SL
listWrappers()

# fit super learner
set.seed(123)
sl_fit <- SuperLearner(
  Y = a_cont$continuous_Y,
  X = a_cont[ , -ncol(a_cont)],
  # SL.library = c("SL.ranger", "SL.glmnet",
  #                "SL.glm","SL.rpart"), # a different library
  SL.library = c("SL.mean", "SL.rpart", "SL.ranger"),
  family = "gaussian",
  verbose = TRUE
)

# look at object
sl_fit # Risk = CV-risk estimate; Coef = weight given to each algorithm

# predict from super learner model
sl_pred <- predict(sl_fit, newdata = b)

# predictions from ensemble model
sl_pred$pred

# predictions from each component model
head(sl_pred$library.predict)

# cross-validated super learner
sl_fit <- CV.SuperLearner(
  Y = a_cont$continuous_Y,
  X = a_cont[ , -ncol(a_cont)],
  SL.library = c("SL.ranger", "SL.glmnet",
                 "SL.glm","SL.rpart"),
  # SL.library = c("SL.mean", "SL.rpart", "SL.ranger"),
  family = "gaussian",
  verbose = TRUE
)

# plot results
plot(sl_fit)