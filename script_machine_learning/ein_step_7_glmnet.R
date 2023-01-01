
# lite
# glmnet
set.seed(123)
glmnet_for_rda <- train(care ~ .,data = train_data_ein_lite, method = "glmnet",trControl=ctrl)
rdaGrid = glmnet_for_rda$bestTune
glmnet_fit <- train(care ~ .,data = train_data_ein_lite,method = "glmnet", trControl=ctrl_fit, tuneGrid = rdaGrid)

saveRDS(glmnet_fit, file = paste0(data_EIN_fit, "glmnet_lite.rds"))

glmnetClasses <- predict(glmnet_fit, newdata = test_data_ein_lite)
glmnetProbs <- predict(glmnet_fit, newdata = test_data_ein_lite, type = "prob")
glmnet_conf_matrix <- confusionMatrix(data = glmnetClasses , test_data_ein_lite$care)
glmnet_result_roc <- multiclass.roc(test_data_ein_lite$care, glmnetProbs)

table_auc_acc_kappa$GLMNET <- c(round(glmnet_result_roc$auc, 3) ,round(glmnet_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa, file = paste0(output_dir, "table_auc_acc_kappa.rds"))

time <- data.table()
time$Test <- c(colnames(data.frame(glmnet_conf_matrix$byClass))) 
time$"Discharged" <- c(round(glmnet_conf_matrix$byClass, 3)[1,])
time$"Regular Ward" <- c(round(glmnet_conf_matrix$byClass, 3)[2,])
time$"Semi Intensive" <- c(round(glmnet_conf_matrix$byClass, 3)[3,])
time$"Intensivec Care Unit" <- c(round(glmnet_conf_matrix$byClass, 3)[4,])
time[, `:=`("Machine Learning" = "GLMNET")]
time <- time[,c(6,1:5)]

table_sens_spec <- rbind(table_sens_spec, time) 
saveRDS(table_sens_spec, file = paste0(output_dir, "table_sens_spec.rds"))

#### imputed
# glmnet
set.seed(123)
glmnet_for_rda <- train(care ~ .,data = train_data, method = "glmnet",trControl=ctrl)
rdaGrid = glmnet_for_rda$bestTune
glmnet_fit <- train(care ~ .,data = train_data, method = "glmnet", trControl=ctrl_fit, tuneGrid = rdaGrid)

saveRDS(glmnet_fit, file = paste0(data_EIN_fit, "glmnet_imp.rds"))

glmnetClasses <- predict(glmnet_fit, newdata = test_data)
glmnetProbs <- predict(glmnet_fit, newdata = test_data, type = "prob")
glmnet_conf_matrix <- confusionMatrix(data = glmnetClasses , test_data$care)
glmnet_result_roc <- multiclass.roc(test_data$care, glmnetProbs)

table_auc_acc_kappa_imp$GLMNET <- c(round(glmnet_result_roc$auc, 3) ,round(glmnet_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa_imp, file = paste0(output_dir, "table_auc_acc_kappa_imp.rds"))

time <- data.table()
time$Test <- c(colnames(data.frame(glmnet_conf_matrix$byClass))) 
time$"Discharged" <- c(round(glmnet_conf_matrix$byClass, 3)[1,])
time$"Regular Ward" <- c(round(glmnet_conf_matrix$byClass, 3)[2,])
time$"Semi Intensive" <- c(round(glmnet_conf_matrix$byClass, 3)[3,])
time$"Intensivec Care Unit" <- c(round(glmnet_conf_matrix$byClass, 3)[4,])
time[, `:=`("Machine Learning" = "GLMNET")]
time <- time[,c(6,1:5)]

table_sens_spec_imp <- rbind(table_sens_spec_imp, time) 
saveRDS(table_sens_spec_imp, file = paste0(output_dir, "table_sens_spec_imp.rds"))