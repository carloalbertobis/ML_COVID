
# load
load(paste0(intermediate_file_dir, "train_data.RData"))
load(paste0(intermediate_file_dir, "test_data.RData"))
load(paste0(intermediate_file_dir, "ctrl.RData"))

# train svm
svm_fit_radial <- train(outcome ~ .,data = train_data,method = "svmRadial", trControl=ctrl, tuneLength=10)
svm_fit_linear <- train(outcome ~ .,data = train_data,method = "svmLinear", trControl=ctrl, tuneLength=10)

#rdaGrid = data.frame(C = svm_fit_radial[["bestTune"]][["C"]], sigma= svm_fit_radial[["bestTune"]][["sigma"]])
#rdaGrid2 <- data.frame(C = svm_fit_linear[["bestTune"]][["C"]])

rdaGrid <- svm_fit_radial$bestTune
rdaGrid2 <- svm_fit_linear$bestTune

svm_fit_radial <- train(outcome ~ .,data = train_data, method = "svmRadial", trControl=ctrl, tuneGrid = rdaGrid)
svm_fit_linear <- train(outcome ~ .,data = train_data, method = "svmLinear", trControl=ctrl, tuneGrid = rdaGrid2)

# predictr svm
svmClasses <- predict(svm_fit_radial, newdata = test_data)
svmProbs <- predict(svm_fit_radial, newdata = test_data, type = "prob")
svm_conf_matrix_radial <- confusionMatrix(data = svmClasses , test_data$outcome) 
svm_result_roc_radial <- roc(test_data$outcome, svmProbs$Nosurvivor)

svmClasses <- predict(svm_fit_linear, newdata = test_data)
svmProbs <- predict(svm_fit_linear, newdata = test_data, type = "prob")
svm_conf_matrix_linear <- confusionMatrix(data = svmClasses , test_data$outcome) 
svm_result_roc_linear <- roc(test_data$outcome, svmProbs$Nosurvivor)

#save train
save(svm_fit_radial, file = paste0(svm_dir, "svm_fit_radial.RData"))
saveRDS(svm_fit_radial, file = paste0(svm_dir, "svm_fit_radial.rds"))
save(svm_fit_linear, file = paste0(svm_dir, "svm_fit_linear.RData"))
saveRDS(svm_fit_linear, file = paste0(svm_dir, "svm_fit_linear.rds"))

#save ROC
save(svm_result_roc_radial, file = paste0(svm_dir, "svm_result_roc_radial.RData"))
saveRDS(svm_result_roc_radial, file = paste0(svm_dir, "svm_result_roc_radial.rds"))
save(svm_result_roc_linear, file = paste0(svm_dir, "svm_result_roc_linear.RData"))
saveRDS(svm_result_roc_linear, file = paste0(svm_dir, "svm_result_roc_linear.rds"))

# save confusion matrix
save(svm_conf_matrix_radial, file = paste0(svm_dir, "svm_conf_matrix_radial.RData"))
saveRDS(svm_conf_matrix_radial, file = paste0(svm_dir, "svm_conf_matrix_radial.rds"))
save(svm_conf_matrix_linear, file = paste0(svm_dir, "svm_conf_matrix_linear.RData"))
saveRDS(svm_conf_matrix_linear, file = paste0(svm_dir, "svm_conf_matrix_linear.rds"))

#clean
rm(ctrl, test_data, train_data, svm_conf_matrix_radial, svm_fit_radial, svm_result_roc_radial, svmProbs, rdaGrid, svmClasses)
rm(svm_fit_linear, svm_result_roc_linear, rdaGrid2, svm_conf_matrix_linear)
