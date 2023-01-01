test_data <- readRDS(paste0(intermediate_file_dir,"test_data_ein.rds"))
train_data <- readRDS(paste0(intermediate_file_dir,"train_data_ein.rds"))
test_data_ein_lite <- readRDS(paste0(intermediate_file_dir,"test_data_ein_lite.rds"))
train_data_ein_lite <- (readRDS(paste0(intermediate_file_dir,"train_data_ein_lite.rds")))
ctrl <- readRDS(paste0(intermediate_file_dir,"ctrl.rds"))
table_auc_acc_kappa <- readRDS(paste0(output_dir, "table_auc_acc_kappa.rds"))
table_sens_spec <- readRDS(paste0(output_dir, "table_sens_spec.rds"))
table_auc_acc_kappa_imp <- readRDS(paste0(output_dir, "table_auc_acc_kappa_imp.rds"))
table_sens_spec_imp <- readRDS(paste0(output_dir, "table_sens_spec_imp.rds"))

# lite
# train random forest
set.seed(123)
rf_for_rda <- train(cov_result ~ .,data = train_data_ein_lite[,-1], method = "rf",trControl=ctrl)
rdaGrid = rf_for_rda$bestTune
rf_fit <- train(cov_result ~ .,data = train_data_ein_lite[,-1], trControl=ctrl_fit, tuneGrid = rdaGrid)

saveRDS(rf_fit, file = paste0(data_EIN_fit, "rf_lite_covid.rds"))

rfClasses <- predict(rf_fit, newdata = test_data_ein_lite[,-1])
rfProbs <- predict(rf_fit, newdata = test_data_ein_lite[,-1], type = "prob")
rf_conf_matrix <- confusionMatrix(data = rfClasses , test_data_ein_lite$cov_result)
rf_result_roc <- multiclass.roc(test_data_ein_lite$cov_result, rfProbs)

table_auc_acc_kappa_covid <- data.table()
table_auc_acc_kappa_covid$Test <- c( "AUC" ,rownames(data.frame(rf_conf_matrix$overall)))
table_auc_acc_kappa_covid$"RF COVID Results" <- c(round(rf_result_roc$auc, 3) ,round(rf_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa_covid, file = paste0(output_dir, "table_auc_acc_kappa_covid.rds"))

time <- data.table()
time$"RF COVID Results" <- c(rownames(data.frame(rf_conf_matrix$byClass))) 
time$"Values" <- c(round(rf_conf_matrix$byClass, 3))
saveRDS(time, file = paste0(output_dir, "table_sens_spec_covid.rds"))

#### imputed
# train random forest
set.seed(123)
rf_for_rda <- train(cov_result ~ .,data = train_data[,-1], method = "rf",trControl=ctrl)
rdaGrid = rf_for_rda$bestTune
rf_fit <- train(cov_result ~ .,data = train_data[,-1], method = "rf", trControl=ctrl_fit, tuneGrid = rdaGrid)

saveRDS(rf_fit, file = paste0(data_EIN_fit, "rf_imp_covid.rds"))

rfClasses <- predict(rf_fit, newdata = test_data[,-1])
rfProbs <- predict(rf_fit, newdata = test_data[,-1], type = "prob")
rf_conf_matrix <- confusionMatrix(data = rfClasses , test_data$cov_result)
rf_result_roc <- multiclass.roc(test_data$cov_result, rfProbs)

table_auc_acc_kappa_imp_covid <- data.table()
table_auc_acc_kappa_imp_covid$Test <- c( "AUC" ,rownames(data.frame(rf_conf_matrix$overall)))
table_auc_acc_kappa_imp_covid$"RF COVID Results" <- c(round(rf_result_roc$auc, 3) ,round(rf_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa_imp_covid, file = paste0(output_dir, "table_auc_acc_kappa_imp_covid.rds"))

time <- data.table()
time$"RF COVID Results" <- c(rownames(data.frame(rf_conf_matrix$byClass))) 
time$"Values" <- c(round(rf_conf_matrix$byClass, 3))
saveRDS(time, file = paste0(output_dir, "table_sens_spec_imp_covid.rds"))

rm(time, rfClasses, rfProbs, rf_result_roc, rf_conf_matrix, rf_fit, rf_for_rda, rdaGrid)
