
# lite
# svm
set.seed(123)
svm_for_rda <- train(care ~ .,data = train_data_ein_lite, method = "svmRadial",trControl=ctrl)
rdaGrid = svm_for_rda$bestTune
svm_fit <- train(care ~ .,data = train_data_ein_lite,method = "svmRadial", trControl=ctrl_fit, tuneGrid = rdaGrid)

saveRDS(svm_fit, file = paste0(data_EIN_fit, "svm_lite.rds"))

svmClasses <- predict(svm_fit, newdata = test_data_ein_lite)
svmProbs <- predict(svm_fit, newdata = test_data_ein_lite, type = "prob")
svm_conf_matrix <- confusionMatrix(data = svmClasses , test_data_ein_lite$care)
svm_result_roc <- multiclass.roc(test_data_ein_lite$care, svmProbs)

table_auc_acc_kappa$SVM <- c(round(svm_result_roc$auc, 3) ,round(svm_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa, file = paste0(output_dir, "table_auc_acc_kappa.rds"))

time <- data.table()
time$Test <- c(colnames(data.frame(svm_conf_matrix$byClass))) 
time$"Discharged" <- c(round(svm_conf_matrix$byClass, 3)[1,])
time$"Regular Ward" <- c(round(svm_conf_matrix$byClass, 3)[2,])
time$"Semi Intensive" <- c(round(svm_conf_matrix$byClass, 3)[3,])
time$"Intensivec Care Unit" <- c(round(svm_conf_matrix$byClass, 3)[4,])
time[, `:=`("Machine Learning" = "SVM")]
time <- time[,c(6,1:5)]

table_sens_spec <- rbind(table_sens_spec, time) 
saveRDS(table_sens_spec, file = paste0(output_dir, "table_sens_spec.rds"))

#### imputed
# svm
set.seed(123)
svm_for_rda <- train(care ~ .,data = train_data, method = "svmRadial",trControl=ctrl)
rdaGrid = svm_for_rda$bestTune
svm_fit <- train(care ~ .,data = train_data, method = "svmRadial", trControl=ctrl_fit, tuneGrid = rdaGrid)

saveRDS(svm_fit, file = paste0(data_EIN_fit, "svm_imp.rds"))

svmClasses <- predict(svm_fit, newdata = test_data)
svmProbs <- predict(svm_fit, newdata = test_data, type = "prob")
svm_conf_matrix <- confusionMatrix(data = svmClasses , test_data$care)
svm_result_roc <- multiclass.roc(test_data$care, svmProbs)

table_auc_acc_kappa_imp$SVM <- c(round(svm_result_roc$auc, 3) ,round(svm_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa_imp, file = paste0(output_dir, "table_auc_acc_kappa_imp.rds"))

time <- data.table()
time$Test <- c(colnames(data.frame(svm_conf_matrix$byClass))) 
time$"Discharged" <- c(round(svm_conf_matrix$byClass, 3)[1,])
time$"Regular Ward" <- c(round(svm_conf_matrix$byClass, 3)[2,])
time$"Semi Intensive" <- c(round(svm_conf_matrix$byClass, 3)[3,])
time$"Intensivec Care Unit" <- c(round(svm_conf_matrix$byClass, 3)[4,])
time[, `:=`("Machine Learning" = "SVM")]
time <- time[,c(6,1:5)]

table_sens_spec_imp <- rbind(table_sens_spec_imp, time) 
saveRDS(table_sens_spec_imp, file = paste0(output_dir, "table_sens_spec_imp.rds"))

rm(time, svmClasses, svmProbs, svm_result_roc, svm_conf_matrix, svm_fit, svm_for_rda, rdaGrid)