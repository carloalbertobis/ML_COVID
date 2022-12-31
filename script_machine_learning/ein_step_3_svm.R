
test_data <- readRDS(paste0(intermediate_file_dir,"test_data_ein.rds"))
train_data <- readRDS(paste0(intermediate_file_dir,"train_data_ein.rds"))
test_data_ein_lite <- readRDS(paste0(intermediate_file_dir,"test_data_ein_lite.rds"))
train_data_ein_lite <- readRDS(paste0(intermediate_file_dir,"train_data_ein_lite.rds"))
ctrl <- readRDS(paste0(intermediate_file_dir,"ctrl.rds"))

table_auc_acc_kappa <- readRDS(paste0(output_dir, "table_auc_acc_kappa.rds"))
table_sens_spec <- readRDS(paste0(output_dir, "table_sens_spec.rds"))
table_auc_acc_kappa_imp <- readRDS(paste0(output_dir, "table_auc_acc_kappa_imp.rds"))
table_sens_spec_imp <- readRDS(paste0(output_dir, "table_sens_spec_imp.rds"))


# lite
# svm
set.seed(123)
svm_for_rda <- train(care ~ .,data = train_data_ein_lite, method = "svmRadial",trControl=ctrl)
rdaGrid = svm_for_rda$bestTune
svm_fit <- train(care ~ .,data = train_data_ein_lite,method = "svmRadial", trControl=ctrl_fit, tuneGrid = rdaGrid)

svmClasses <- predict(svm_fit, newdata = test_data_ein_lite)
svmProbs <- predict(svm_fit, newdata = test_data_ein_lite, type = "prob")
svm_conf_matrix <- confusionMatrix(data = svmClasses , test_data_ein_lite$care)
svm_result_roc <- multiclass.roc(test_data_ein_lite$care, svmProbs)

table_auc_acc_kappa$svm <- c(round(svm_result_roc$auc, 3) ,round(svm_conf_matrix$overall, 3))
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

svmClasses <- predict(svm_fit, newdata = test_data)
svmProbs <- predict(svm_fit, newdata = test_data, type = "prob")
svm_conf_matrix <- confusionMatrix(data = svmClasses , test_data$care)
svm_result_roc <- multiclass.roc(test_data$care, svmProbs)

table_auc_acc_kappa_imp$svm <- c(round(svm_result_roc$auc, 3) ,round(svm_conf_matrix$overall, 3))
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