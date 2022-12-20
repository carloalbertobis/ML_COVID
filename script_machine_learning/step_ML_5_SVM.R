
# load
test_data <- readRDS(paste0(intermediate_file_dir,"test_data.rds"))
train_data <- readRDS(paste0(intermediate_file_dir,"train_data.rds"))
ctrl_fit <- readRDS(paste0(intermediate_file_dir,"ctrl_fit.rds"))
ctrl <- readRDS(paste0(intermediate_file_dir,"ctrl.rds"))

# train svm
svm_fit_radial <- train(outcome ~ .,data = train_data,method = "svmRadial", trControl=ctrl)
svm_fit_linear <- train(outcome ~ .,data = train_data,method = "svmLinear", trControl=ctrl)

#rdaGrid = data.frame(C = svm_fit_radial[["bestTune"]][["C"]], sigma= svm_fit_radial[["bestTune"]][["sigma"]])
#rdaGrid2 <- data.frame(C = svm_fit_linear[["bestTune"]][["C"]])

rdaGrid <- svm_fit_radial$bestTune
rdaGrid2 <- svm_fit_linear$bestTune

svm_fit_radial <- train(outcome ~ .,data = train_data, method = "svmRadial", trControl=ctrl_fit, tuneGrid = rdaGrid)
svm_fit_linear <- train(outcome ~ .,data = train_data, method = "svmLinear", trControl=ctrl_fit, tuneGrid = rdaGrid2)

# predictr svm
svmClasses <- predict(svm_fit_radial, newdata = test_data)
svmProbs <- predict(svm_fit_radial, newdata = test_data, type = "prob")
svm_conf_matrix_radial <- confusionMatrix(data = svmClasses , test_data$outcome) 
svm_result_roc_radial <- roc(test_data$outcome, svmProbs$Nosurvivor)

svmClasses <- predict(svm_fit_linear, newdata = test_data)
svmProbs <- predict(svm_fit_linear, newdata = test_data, type = "prob")
svm_conf_matrix_linear <- confusionMatrix(data = svmClasses , test_data$outcome) 
svm_result_roc_linear <- roc(test_data$outcome, svmProbs$Nosurvivor)

# load table
table_con_matrix <- readRDS(paste0(output_dir, "table_con_matrix.rds"))
#table_con_matrix$"SVM Linear"  <- c(round(svm_result_roc_linear$auc, 3) ,round(svm_conf_matrix_linear$byClass, 3))
table_con_matrix$"SVM Radial"  <- c(round(svm_result_roc_radial$auc, 3) ,round(svm_conf_matrix_radial$byClass, 3))
saveRDS(table_con_matrix, file = paste0(output_dir, "table_con_matrix.rds"))

#save train
saveRDS(svm_fit_radial, file = paste0(svm_dir, "svm_fit_radial.rds"))
saveRDS(svm_fit_linear, file = paste0(svm_dir, "svm_fit_linear.rds"))

#save ROC
saveRDS(svm_result_roc_radial, file = paste0(svm_dir, "svm_result_roc_radial.rds"))
saveRDS(svm_result_roc_linear, file = paste0(svm_dir, "svm_result_roc_linear.rds"))

# save confusion matrix
saveRDS(svm_conf_matrix_radial, file = paste0(svm_dir, "svm_conf_matrix_radial.rds"))
saveRDS(svm_conf_matrix_linear, file = paste0(svm_dir, "svm_conf_matrix_linear.rds"))

#clean
rm(ctrl, test_data, train_data, svm_conf_matrix_radial, svm_fit_radial, svm_result_roc_radial, svmProbs, rdaGrid, svmClasses)
rm(svm_fit_linear, svm_result_roc_linear, rdaGrid2, svm_conf_matrix_linear)
