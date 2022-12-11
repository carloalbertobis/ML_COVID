# load
load(paste0(intermediate_file_dir, "train_data.RData"))
load(paste0(intermediate_file_dir, "test_data.RData"))
load(paste0(intermediate_file_dir, "ctrl.RData"))

# train ann
ann_fit <- train(outcome ~ .,data = train_data,method = "nnet", trControl=ctrl)
rdaGrid <- ann_fit$bestTune
ann_fit <- train(outcome ~ .,data = train_data, method = "nnet", trControl=ctrl, tuneGrid = rdaGrid)

# predict
annClasses <- predict(ann_fit, newdata = test_data)
annProbs <- predict(ann_fit, newdata = test_data, type = "prob")

ann_conf_matrix <- confusionMatrix(data = annClasses , test_data$outcome) 

# roc
ann_result_roc <- roc(test_data$outcome, annProbs$Nosurvivor)


#save train
save(ann_fit, file = paste0(ann_dir, "ann_fit.RData"))
saveRDS(ann_fit, file = paste0(ann_dir, "ann_fit.rds"))

#save ROC
save(ann_result_roc, file = paste0(ann_dir, "ann_result_roc.RData"))
saveRDS(ann_result_roc, file = paste0(ann_dir, "ann_result_roc.rds"))

# save confusion matrix
save(ann_conf_matrix, file = paste0(ann_dir, "ann_conf_matrix.RData"))
saveRDS(ann_conf_matrix, file = paste0(ann_dir, "ann_conf_matrix.rds"))

# clean
rm(ctrl, test_data, train_data, annProbs, rdaGrid, annClasses)
rm(ann_conf_matrix, ann_fit, ann_result_roc)
