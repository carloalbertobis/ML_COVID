
# lite
# knn
set.seed(123)
knn_for_rda <- train(care ~ .,data = train_data_ein_lite, method = "knn",trControl=ctrl)
rdaGrid = knn_for_rda$bestTune
knn_fit <- train(care ~ .,data = train_data_ein_lite,method = "knn", trControl=ctrl_fit, tuneGrid = rdaGrid)

saveRDS(knn_fit, file = paste0(data_EIN_fit, "knn_lite.rds"))

knnClasses <- predict(knn_fit, newdata = test_data_ein_lite)
knnProbs <- predict(knn_fit, newdata = test_data_ein_lite, type = "prob")
knn_conf_matrix <- confusionMatrix(data = knnClasses , test_data_ein_lite$care)
knn_result_roc <- multiclass.roc(test_data_ein_lite$care, knnProbs)

table_auc_acc_kappa$KNN <- c(round(knn_result_roc$auc, 3) ,round(knn_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa, file = paste0(output_dir, "table_auc_acc_kappa.rds"))

time <- data.table()
time$Test <- c(colnames(data.frame(knn_conf_matrix$byClass))) 
time$"Discharged" <- c(round(knn_conf_matrix$byClass, 3)[1,])
time$"Regular Ward" <- c(round(knn_conf_matrix$byClass, 3)[2,])
time$"Semi Intensive" <- c(round(knn_conf_matrix$byClass, 3)[3,])
time$"Intensivec Care Unit" <- c(round(knn_conf_matrix$byClass, 3)[4,])
time[, `:=`("Machine Learning" = "KNN")]
time <- time[,c(6,1:5)]

table_sens_spec <- rbind(table_sens_spec, time) 
saveRDS(table_sens_spec, file = paste0(output_dir, "table_sens_spec.rds"))

#### imputed
# knn
set.seed(123)
knn_for_rda <- train(care ~ .,data = train_data, method = "knn",trControl=ctrl)
rdaGrid = knn_for_rda$bestTune
knn_fit <- train(care ~ .,data = train_data, method = "knn", trControl=ctrl_fit, tuneGrid = rdaGrid)

saveRDS(knn_fit, file = paste0(data_EIN_fit, "knn_imp.rds"))

knnClasses <- predict(knn_fit, newdata = test_data)
knnProbs <- predict(knn_fit, newdata = test_data, type = "prob")
knn_conf_matrix <- confusionMatrix(data = knnClasses , test_data$care)
knn_result_roc <- multiclass.roc(test_data$care, knnProbs)

table_auc_acc_kappa_imp$KNN <- c(round(knn_result_roc$auc, 3) ,round(knn_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa_imp, file = paste0(output_dir, "table_auc_acc_kappa_imp.rds"))

time <- data.table()
time$Test <- c(colnames(data.frame(knn_conf_matrix$byClass))) 
time$"Discharged" <- c(round(knn_conf_matrix$byClass, 3)[1,])
time$"Regular Ward" <- c(round(knn_conf_matrix$byClass, 3)[2,])
time$"Semi Intensive" <- c(round(knn_conf_matrix$byClass, 3)[3,])
time$"Intensivec Care Unit" <- c(round(knn_conf_matrix$byClass, 3)[4,])
time[, `:=`("Machine Learning" = "KNN")]
time <- time[,c(6,1:5)]

table_sens_spec_imp <- rbind(table_sens_spec_imp, time) 
saveRDS(table_sens_spec_imp, file = paste0(output_dir, "table_sens_spec_imp.rds"))