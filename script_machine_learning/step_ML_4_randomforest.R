
# load
load(paste0(intermediate_file_dir, "train_data.RData"))
load(paste0(intermediate_file_dir, "test_data.RData"))
load(paste0(intermediate_file_dir, "ctrl.RData"))

# train random forest
rf_for_rda <- train(outcome ~ .,data = train_data, method = "rf",trControl=ctrl, tuneLength=10)
rdaGrid = data.frame(mtry = rf_for_rda[["bestTune"]][["mtry"]])
rf_fit <- train(outcome ~ .,data = train_data,method = "rf",trControl=ctrl, tuneGrid = rdaGrid)


# predict random forest
rfClasses <- predict(rf_fit, newdata = test_data)
rfProbs <- predict(rf_fit, newdata = test_data, type = "prob")

rf_conf_matrix <- confusionMatrix(data = rfClasses , test_data$outcome)

#AUC
rf_result_roc <- roc(test_data$outcome, rfProbs$Nosurvivor)


#save train
save(rf_fit, file = paste0(random_forest_dir, "rf_fit.RData"))
saveRDS(rf_fit, file = paste0(random_forest_dir, "rf_fit.rds"))

#save ROC
save(rf_result_roc, file = paste0(random_forest_dir, "rf_result_roc.RData"))
saveRDS(rf_result_roc, file = paste0(random_forest_dir, "rf_result_roc.rds"))

# save confusion matrix
save(rf_conf_matrix, file = paste0(random_forest_dir, "rf_conf_matrix.RData"))
saveRDS(rf_conf_matrix, file = paste0(random_forest_dir, "rf_conf_matrix.rds"))


#clean
rm(ctrl, ddd, test_data, train_data, rf_conf_matrix, rf_fit, rf_result_roc, rfProbs, rdaGrid, rf_for_rda)
