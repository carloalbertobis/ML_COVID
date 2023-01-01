
# lite
# nb
set.seed(123)
nb_for_rda <- train(care ~ .,data = train_data_ein_lite, method = "nb", trControl=ctrl)
rdaGrid = nb_for_rda$bestTune
nb_fit <- train(care ~ .,data = train_data_ein_lite,method = "nb", trControl=ctrl, tuneGrid = rdaGrid)

saveRDS(nb_fit, file = paste0(data_EIN_fit, "nb_lite.rds"))

nbClasses <- predict(nb_fit, newdata = test_data_ein_lite)
nbProbs <- predict(nb_fit, newdata = test_data_ein_lite, type = "prob")
nb_conf_matrix <- confusionMatrix(data = nbClasses , test_data_ein_lite$care)
nb_result_roc <- multiclass.roc(test_data_ein_lite$care, nbProbs)

table_auc_acc_kappa$NB <- c(round(nb_result_roc$auc, 3) ,round(nb_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa, file = paste0(output_dir, "table_auc_acc_kappa.rds"))

time <- data.table()
time$Test <- c(colnames(data.frame(nb_conf_matrix$byClass))) 
time$"Discharged" <- c(round(nb_conf_matrix$byClass, 3)[1,])
time$"Regular Ward" <- c(round(nb_conf_matrix$byClass, 3)[2,])
time$"Semi Intensive" <- c(round(nb_conf_matrix$byClass, 3)[3,])
time$"Intensivec Care Unit" <- c(round(nb_conf_matrix$byClass, 3)[4,])
time[, `:=`("Machine Learning" = "NB")]
time <- time[,c(6,1:5)]

table_sens_spec <- rbind(table_sens_spec, time) 
saveRDS(table_sens_spec, file = paste0(output_dir, "table_sens_spec.rds"))

#### imputed
# nb
set.seed(123)
nb_for_rda <- train(care ~ .,data = train_data, method = "nb",trControl=ctrl)
rdaGrid = nb_for_rda$bestTune
nb_fit <- train(care ~ .,data = train_data, method = "nb", trControl=ctrl, tuneGrid = rdaGrid)

saveRDS(nb_fit, file = paste0(data_EIN_fit, "nb_imp.rds"))

nbClasses <- predict(nb_fit, newdata = test_data)
nbProbs <- predict(nb_fit, newdata = test_data, type = "prob")
nb_conf_matrix <- confusionMatrix(data = nbClasses , test_data$care)
nb_result_roc <- multiclass.roc(test_data$care, nbProbs)

table_auc_acc_kappa_imp$NB <- c(round(nb_result_roc$auc, 3) ,round(nb_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa_imp, file = paste0(output_dir, "table_auc_acc_kappa_imp.rds"))

time <- data.table()
time$Test <- c(colnames(data.frame(nb_conf_matrix$byClass))) 
time$"Discharged" <- c(round(nb_conf_matrix$byClass, 3)[1,])
time$"Regular Ward" <- c(round(nb_conf_matrix$byClass, 3)[2,])
time$"Semi Intensive" <- c(round(nb_conf_matrix$byClass, 3)[3,])
time$"Intensivec Care Unit" <- c(round(nb_conf_matrix$byClass, 3)[4,])
time[, `:=`("Machine Learning" = "NB")]
time <- time[,c(6,1:5)]

table_sens_spec_imp <- rbind(table_sens_spec_imp, time) 
saveRDS(table_sens_spec_imp, file = paste0(output_dir, "table_sens_spec_imp.rds"))