

test_data <- readRDS(paste0(intermediate_file_dir,"test_data_ein.rds"))
train_data <- readRDS(paste0(intermediate_file_dir,"train_data_ein.rds"))
test_data_ein_lite <- readRDS(paste0(intermediate_file_dir,"test_data_ein_lite.rds"))
train_data_ein_lite <- readRDS(paste0(intermediate_file_dir,"train_data_ein_lite.rds"))
ctrl <- readRDS(paste0(intermediate_file_dir,"ctrl.rds"))

#### lite
xxx <- polr(care ~ .,data = train_data_ein_lite)
zzz <- stepAIC(xxx, trace = FALSE)
zzz <- formula(zzz)
glm_fit_aic <- train(zzz, data = train_data_ein_lite,  method = "polr", trControl=ctrl)
glmClasses <- predict(glm_fit_aic, newdata = test_data_ein_lite)
glmProbs <- predict(glm_fit_aic, newdata = test_data_ein_lite, type = "prob")
glm_conf_matrix <- confusionMatrix(data = glmClasses, test_data_ein_lite$care)
glm_result_roc <- multiclass.roc(test_data_ein_lite$care, glmProbs)

table_auc_acc_kappa <- data.table()
table_auc_acc_kappa$Test <- c( "AUC" ,rownames(data.frame(glm_conf_matrix$overall)))
table_auc_acc_kappa$OLR <- c(round(glm_result_roc$auc, 3) ,round(glm_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa, file = paste0(output_dir, "table_auc_acc_kappa.rds"))

table_sens_spec <- data.table()
table_sens_spec$Test <- c(colnames(data.frame(glm_conf_matrix$byClass))) 
table_sens_spec$"Discharged" <- c(round(glm_conf_matrix$byClass, 3)[1,])
table_sens_spec$"Regular Ward" <- c(round(glm_conf_matrix$byClass, 3)[2,])
table_sens_spec$"Semi Intensive" <- c(round(glm_conf_matrix$byClass, 3)[3,])
table_sens_spec$"Intensivec Care Unit" <- c(round(glm_conf_matrix$byClass, 3)[4,])
table_sens_spec[, `:=`("Machine Learning" = "OLR")]
table_sens_spec <- table_sens_spec[,c(6,1:5)]
saveRDS(table_sens_spec, file = paste0(output_dir, "table_sens_spec.rds"))

#### imputed

xxx <- polr(care ~ .,data = train_data)
zzz <- stepAIC(xxx, trace = FALSE)
zzz <- formula(zzz)
glm_fit_aic <- train(zzz, data = train_data,  method = "polr", trControl=ctrl)
glmClasses <- predict(glm_fit_aic, newdata = test_data)
glmProbs <- predict(glm_fit_aic, newdata = test_data, type = "prob")
glm_conf_matrix <- confusionMatrix(data = glmClasses, test_data$care)
glm_result_roc <- multiclass.roc(test_data$care, glmProbs)

table_auc_acc_kappa_imp <- data.table()
table_auc_acc_kappa_imp$Test <- c( "AUC" ,rownames(data.frame(glm_conf_matrix$overall)))
table_auc_acc_kappa_imp$OLR <- c(round(glm_result_roc$auc, 3) ,round(glm_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa_imp, file = paste0(output_dir, "table_auc_acc_kappa_imp.rds"))

table_sens_spec_imp <- data.table()
table_sens_spec_imp$Test <- c(colnames(data.frame(glm_conf_matrix$byClass))) 
table_sens_spec_imp$discharged <- c(round(glm_conf_matrix$byClass, 3)[1,])
table_sens_spec_imp$regular_ward <- c(round(glm_conf_matrix$byClass, 3)[2,])
table_sens_spec_imp$semi_intensive <- c(round(glm_conf_matrix$byClass, 3)[3,])
table_sens_spec_imp$intensivec_care_unit <- c(round(glm_conf_matrix$byClass, 3)[4,])
table_sens_spec_imp[, `:=`("Machine Learning" = "OLR")]
table_sens_spec_imp <- table_sens_spec_imp[,c(6,1:5)]
saveRDS(table_sens_spec_imp, file = paste0(output_dir, "table_sens_spec_imp.rds"))



