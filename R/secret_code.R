# load outcomes
load("/home/secret/new_drugs_data_outcomes.RData")

# compute AUC
library(cvAUC)
AUC(final_pred, new_outcomes)