#crossvalidation
set.seed(123)
ctrl <- trainControl(method = "repeatedcv", repeats = 10,
                     classProbs = TRUE,
                     summaryFunction = twoClassSummary,
                     ## new option here:
                     sampling = "down", savePredictions = T)


# Clean and save

save(ctrl, file = paste0(intermediate_file_dir, "ctrl.RData"))
#saveRDS(ctrl, file = paste0(intermediate_file_dir,"ctrl.rds"))
rm(ctrl)
