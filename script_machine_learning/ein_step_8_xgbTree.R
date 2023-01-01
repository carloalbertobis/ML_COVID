
# lite
# xgbTree
set.seed(123)
xgbTree_for_rda <- train(care ~ .,data = train_data_ein_lite, trControl = ctrl,
                         #tuneGrid = grid_default,
                         method = "xgbTree",
                         verbose = TRUE,
                         verbosity = 0)

rdaGrid = xgbTree_for_rda$bestTune
xgbTree_fit <- train(care ~ .,data = train_data_ein_lite,method = "xgbTree", trControl=ctrl_fit, tuneGrid = rdaGrid)

saveRDS(xgbTree_fit, file = paste0(data_EIN_fit, "xgbTree_lite.rds"))

xgbTreeClasses <- predict(xgbTree_fit, newdata = test_data_ein_lite)
xgbTreeProbs <- predict(xgbTree_fit, newdata = test_data_ein_lite, type = "prob")
xgbTree_conf_matrix <- confusionMatrix(data = xgbTreeClasses , test_data_ein_lite$care)
xgbTree_result_roc <- multiclass.roc(test_data_ein_lite$care, xgbTreeProbs)

table_auc_acc_kappa$xgbTree <- c(round(xgbTree_result_roc$auc, 3) ,round(xgbTree_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa, file = paste0(output_dir, "table_auc_acc_kappa.rds"))

time <- data.table()
time$Test <- c(colnames(data.frame(xgbTree_conf_matrix$byClass))) 
time$"Discharged" <- c(round(xgbTree_conf_matrix$byClass, 3)[1,])
time$"Regular Ward" <- c(round(xgbTree_conf_matrix$byClass, 3)[2,])
time$"Semi Intensive" <- c(round(xgbTree_conf_matrix$byClass, 3)[3,])
time$"Intensivec Care Unit" <- c(round(xgbTree_conf_matrix$byClass, 3)[4,])
time[, `:=`("Machine Learning" = "xgbTree")]
time <- time[,c(6,1:5)]

table_sens_spec <- rbind(table_sens_spec, time) 
saveRDS(table_sens_spec, file = paste0(output_dir, "table_sens_spec.rds"))

#### imputed
# xgbTree
set.seed(123)
xgbTree_for_rda <- train(care ~ .,data = train_data, method = "xgbTree",trControl=ctrl)
rdaGrid = xgbTree_for_rda$bestTune
xgbTree_fit <- train(care ~ .,data = train_data, method = "xgbTree", trControl=ctrl_fit, tuneGrid = rdaGrid)

saveRDS(xgbTree_fit, file = paste0(data_EIN_fit, "xgbTree_imp.rds"))

xgbTreeClasses <- predict(xgbTree_fit, newdata = test_data)
xgbTreeProbs <- predict(xgbTree_fit, newdata = test_data, type = "prob")
xgbTree_conf_matrix <- confusionMatrix(data = xgbTreeClasses , test_data$care)
xgbTree_result_roc <- multiclass.roc(test_data$care, xgbTreeProbs)

table_auc_acc_kappa_imp$xgbTree <- c(round(xgbTree_result_roc$auc, 3) ,round(xgbTree_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa_imp, file = paste0(output_dir, "table_auc_acc_kappa_imp.rds"))

time <- data.table()
time$Test <- c(colnames(data.frame(xgbTree_conf_matrix$byClass))) 
time$"Discharged" <- c(round(xgbTree_conf_matrix$byClass, 3)[1,])
time$"Regular Ward" <- c(round(xgbTree_conf_matrix$byClass, 3)[2,])
time$"Semi Intensive" <- c(round(xgbTree_conf_matrix$byClass, 3)[3,])
time$"Intensivec Care Unit" <- c(round(xgbTree_conf_matrix$byClass, 3)[4,])
time[, `:=`("Machine Learning" = "xgbTree")]
time <- time[,c(6,1:5)]

table_sens_spec_imp <- rbind(table_sens_spec_imp, time) 
saveRDS(table_sens_spec_imp, file = paste0(output_dir, "table_sens_spec_imp.rds"))