## Starter code for predicting drug addiction

# load training data
load("/home/data/drugs_data.RData")

# load testing data
load("/home/data/new_drugs_data.RData")

# show objects loaded in memory
ls()

# data = training data
# new_data = testing data => we need predictions for these folks

# The goal of this exercise is to use "data" to fit an ML algorithm
# and obtain predictions on "new_data". I have hidden the true outcomes
# of new_data from you, but we will use them to evaluate the quality of 
# your predictions. Your predictions will be judged based on a measure
# known as AUC. AUC is the probability that a randomly selected case (i.e,
# outcome = 1) has higher predicted probability of the outcome than a 
# randomly selected control (i.e., outcome = 0). To compute AUC we can use
# the cvAUC package. 

# Here's a simple example using logistic regression
glm_fit <- glm(outcome ~ age , data = data, family = binomial())
# get predictions
glm_pred <- predict(glm_fit, newdata = data, type = "response")
# evaluate AUC
AUC(glm_pred, data$outcome) # < 0.5 is bad; close to 1 is good

# Note that we used the same data to fit and evaluate here, which 
# may not be the best choice... Could we consider cross-validation?.......

#----------------------------------------------------------------------
# WHEN YOU ARE DONE: STORE YOUR FINAL PREDICTIONS IN A VECTOR CALLED
# final_pred. I WILL GIVE YOU CODE TO OBTAIN TO THE TRUE LABELS AND 
# WE WILL EVALUATE YOUR PREDICTIONS. HIGHEST AUC WINS!!!
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# More information on the data set:
# age = age of participant and has one of the values: 
# Value Meaning Cases Fraction 
# -0.95197 18-24 643 34.11% 
# -0.07854 25-34 481 25.52% 
# 0.49788 35-44 356 18.89% 
# 1.09449 45-54 294 15.60% 
# 1.82213 55-64 93 4.93% 
# 2.59171 65+ 18 0.95% 

# gender = gender of participant: 
# Value Meaning Cases Fraction 
# 0.48246 Female 942 49.97% 
# -0.48246 Male 943 50.03% 

# education = level of education of participant and has one of the values: 
# Value Meaning Cases Fraction 
# -2.43591 Left school before 16 years 28 1.49% 
# -1.73790 Left school at 16 years 99 5.25% 
# -1.43719 Left school at 17 years 30 1.59% 
# -1.22751 Left school at 18 years 100 5.31% 
# -0.61113 Some college or university, no certificate or degree 506 26.84% 
# -0.05921 Professional certificate/ diploma 270 14.32% 
# 0.45468 University degree 480 25.46% 
# 1.16365 Masters degree 283 15.01% 
# 1.98437 Doctorate degree 89 4.72% 

# country = country of current residence of participant and has one of the values: 
# Value Meaning Cases Fraction 
# -0.09765 Australia 54 2.86% 
# 0.24923 Canada 87 4.62% 
# -0.46841 New Zealand 5 0.27% 
# -0.28519 Other 118 6.26% 
# 0.21128 Republic of Ireland 20 1.06% 
# 0.96082 UK 1044 55.38% 
# -0.57009 USA 557 29.55% 

# ethnicity = ethnicity of participant and has one of the values: 
# Value Meaning Cases Fraction 
# -0.50212 Asian 26 1.38% 
# -1.10702 Black 33 1.75% 
# 1.90725 Mixed-Black/Asian 3 0.16% 
# 0.12600 Mixed-White/Asian 20 1.06% 
# -0.22166 Mixed-White/Black 20 1.06% 
# 0.11440 Other 63 3.34% 
# -0.31685 White 1720 91.25% 

# nscore = NEO-FFI-R Neuroticism. Possible values are presented in table below: 
# Nscore Cases Value Nscore Cases Value Nscore Cases Value 
# 12 1 -3.46436 29 60 -0.67825 46 67 1.02119 
# 13 1 -3.15735 30 61 -0.58016 47 27 1.13281 
# 14 7 -2.75696 31 87 -0.46725 48 49 1.23461 
# 15 4 -2.52197 32 78 -0.34799 49 40 1.37297 
# 16 3 -2.42317 33 68 -0.24649 50 24 1.49158 
# 17 4 -2.34360 34 76 -0.14882 51 27 1.60383 
# 18 10 -2.21844 35 69 -0.05188 52 17 1.72012 
# 19 16 -2.05048 36 73 0.04257 53 20 1.83990 
# 20 24 -1.86962 37 67 0.13606 54 15 1.98437 
# 21 31 -1.69163 38 63 0.22393 55 11 2.12700 
# 22 26 -1.55078 39 66 0.31287 56 10 2.28554 
# 23 29 -1.43907 40 80 0.41667 57 6 2.46262 
# 24 35 -1.32828 41 61 0.52135 58 3 2.61139 
# 25 56 -1.19430 42 77 0.62967 59 5 2.82196 
# 26 57 -1.05308 43 49 0.73545 60 2 3.27393 
# 27 65 -0.92104 44 51 0.82562 
# 28 70 -0.79151 45 37 0.91093 

# escore = NEO-FFI-R Extraversion. Possible values are presented in table below: 
# Escore Cases Value Escore Cases Value Escore Cases Value 
# 16 2 -3.27393 31 55 -1.23177 45 91 0.80523 
# 18 1 -3.00537 32 52 -1.09207 46 69 0.96248 
# 19 6 -2.72827 33 77 -0.94779 47 64 1.11406 
# 20 3 -2.53830 34 68 -0.80615 48 62 1.28610 
# 21 3 -2.44904 35 58 -0.69509 49 37 1.45421 
# 22 8 -2.32338 36 89 -0.57545 50 25 1.58487 
# 23 5 -2.21069 37 90 -0.43999 51 34 1.74091 
# 24 9 -2.11437 38 106 -0.30033 52 21 1.93886 
# 25 4 -2.03972 39 107 -0.15487 53 15 2.12700 
# 26 21 -1.92173 40 130 0.00332 54 10 2.32338 
# 27 23 -1.76250 41 116 0.16767 55 9 2.57309 
# 28 23 -1.63340 42 109 0.32197 56 2 2.85950 
# 29 32 -1.50796 43 105 0.47617 58 1 3.00537 
# 30 38 -1.37639 44 103 0.63779 59 2 3.27393 

# oscore = NEO-FFI-R Openness to experience. Possible values are presented in table below: 
# Oscore Cases Value Oscore Cases Value Oscore Cases Value 
# 24 2 -3.27393 38 64 -1.11902 50 83 0.58331 
# 26 4 -2.85950 39 60 -0.97631 51 87 0.72330 
# 28 4 -2.63199 40 68 -0.84732 52 87 0.88309 
# 29 11 -2.39883 41 76 -0.71727 53 81 1.06238 
# 30 9 -2.21069 42 87 -0.58331 54 57 1.24033 
# 31 9 -2.09015 43 86 -0.45174 55 63 1.43533 
# 32 13 -1.97495 44 101 -0.31776 56 38 1.65653 
# 33 23 -1.82919 45 103 -0.17779 57 34 1.88511 
# 34 25 -1.68062 46 134 -0.01928 58 19 2.15324 
# 35 26 -1.55521 47 107 0.14143 59 13 2.44904 
# 36 39 -1.42424 48 116 0.29338 60 7 2.90161 
# 37 51 -1.27553 49 98 0.44585 
# Descriptive statistics 
# Min Max Mean Std.dev. 
# -3.27393 2.90161 -0.00053 0.99623 

# ascore = NEO-FFI-R Agreeableness. Possible values are presented in table below: 
# Ascore Cases Value Ascore Cases Value Ascore Cases Value 
# 12 1 -3.46436 34 42 -1.34289 48 104 0.76096 
# 16 1 -3.15735 35 45 -1.21213 49 85 0.94156 
# 18 1 -3.00537 36 62 -1.07533 50 68 1.11406 
# 23 1 -2.90161 37 83 -0.91699 51 58 1.2861 
# 24 2 -2.78793 38 82 -0.76096 52 39 1.45039 
# 25 1 -2.70172 39 102 -0.60633 53 36 1.61108 
# 26 7 -2.53830 40 98 -0.45321 54 36 1.81866 
# 27 7 -2.35413 41 114 -0.30172 55 16 2.03972 
# 28 8 -2.21844 42 101 -0.15487 56 14 2.23427 
# 29 13 -2.07848 43 105 -0.01729 57 8 2.46262 
# 30 18 -1.92595 44 118 0.13136 58 7 2.75696 
# 31 24 -1.77200 45 112 0.28783 59 1 3.15735 
# 32 30 -1.62090 46 100 0.43852 60 1 3.46436 
# 33 34 -1.47955 47 100 0.59042 

# cscore = is NEO-FFI-R Conscientiousness. Possible values are presented in table below: 
# Cscore Cases Value Cscore Cases Value Cscore Cases Value 
# 17 1 -3.46436 32 39 -1.25773 46 113 0.58489 
# 19 1 -3.15735 33 49 -1.13788 47 95 0.7583 
# 20 3 -2.90161 34 55 -1.01450 48 95 0.93949 
# 21 2 -2.72827 35 55 -0.89891 49 76 1.13407 
# 22 5 -2.57309 36 69 -0.78155 50 47 1.30612 
# 23 5 -2.42317 37 81 -0.65253 51 43 1.46191 
# 24 6 -2.30408 38 77 -0.52745 52 34 1.63088 
# 25 9 -2.18109 39 87 -0.40581 53 28 1.81175 
# 26 13 -2.04506 40 97 -0.27607 54 27 2.04506 
# 27 13 -1.92173 41 99 -0.14277 55 13 2.33337 
# 28 25 -1.78169 42 105 -0.00665 56 8 2.63199 
# 29 24 -1.64101 43 90 0.12331 57 3 3.00537 
# 30 29 -1.51840 44 111 0.25953 59 1 3.46436 
# 31 41 -1.38502 45 111 0.41594 

# imp = impulsiveness measured by BIS-11. Possible values are presented in table below: 
# Impulsiveness Cases Fraction 
# -2.55524 20 1.06% 
# -1.37983 276 14.64% 
# -0.71126 307 16.29% 
# -0.21712 355 18.83% 
# 0.19268 257 13.63% 
# 0.52975 216 11.46% 
# 0.88113 195 10.34% 
# 1.29221 148 7.85% 
# 1.86203 104 5.52% 
# 2.90161 7 0.37% 

# ss = sensation seeing measured by ImpSS. Possible values are presented in table below: 
# SS Cases Fraction 
# -2.07848 71 3.77% 
# -1.54858 87 4.62% 
# -1.18084 132 7.00% 
# -0.84637 169 8.97% 
# -0.52593 211 11.19% 
# -0.21575 223 11.83% 
# 0.07987 219 11.62% 
# 0.40148 249 13.21% 
# 0.76540 211 11.19% 
# 1.22470 210 11.14% 
# 1.92173 103 5.46% 

# outcome = whether or not the participant has an opioid addiction