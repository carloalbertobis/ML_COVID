#crossvalidation
set.seed(123)
ctrl <- trainControl(method = "repeatedcv", 
                     number = 10,
                     repeats = 10,
                     classProbs = T,
                     summaryFunction = twoClassSummary,
                     ## new option here:
                     sampling = "down", 
                     savePredictions = T,
                     seeds = set.seed(123),
                     allowParallel = F,
                     verboseIter = F)


# Clean and save

saveRDS(ctrl, file = paste0(intermediate_file_dir,"ctrl.rds"))
rm(ctrl)





set.seed(123)
ctrl_fit <- trainControl(method = "repeatedcv", 
                     number = 10,
                     repeats = 10,
                     classProbs = T,
                     summaryFunction = twoClassSummary,
                     ## new option here:
                     sampling = "down", 
                     savePredictions = T,
                     seeds = set.seed(123),
                     allowParallel = F,
                     verboseIter = F)

saveRDS(ctrl_fit, file = paste0(intermediate_file_dir,"ctrl_fit.rds"))
rm(ctrl_fit)