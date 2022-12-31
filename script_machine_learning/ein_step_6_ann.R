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
# ann
set.seed(123)
ann_for_rda <- train(care ~ .,data = train_data_ein_lite, method = "ann",trControl=ctrl)
rdaGrid = ann_for_rda$bestTune
ann_fit <- train(care ~ .,data = train_data_ein_lite,method = "ann", trControl=ctrl_fit, tuneGrid = rdaGrid)

annClasses <- predict(ann_fit, newdata = test_data_ein_lite)
annProbs <- predict(ann_fit, newdata = test_data_ein_lite, type = "prob")
ann_conf_matrix <- confusionMatrix(data = annClasses , test_data_ein_lite$care)
ann_result_roc <- multiclass.roc(test_data_ein_lite$care, annProbs)

table_auc_acc_kappa$ann <- c(round(ann_result_roc$auc, 3) ,round(ann_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa, file = paste0(output_dir, "table_auc_acc_kappa.rds"))

time <- data.table()
time$Test <- c(colnames(data.frame(ann_conf_matrix$byClass))) 
time$"Discharged" <- c(round(ann_conf_matrix$byClass, 3)[1,])
time$"Regular Ward" <- c(round(ann_conf_matrix$byClass, 3)[2,])
time$"Semi Intensive" <- c(round(ann_conf_matrix$byClass, 3)[3,])
time$"Intensivec Care Unit" <- c(round(ann_conf_matrix$byClass, 3)[4,])
time[, `:=`("Machine Learning" = "ann")]
time <- time[,c(6,1:5)]

table_sens_spec <- rbind(table_sens_spec, time) 
saveRDS(table_sens_spec, file = paste0(output_dir, "table_sens_spec.rds"))

#### imputed
# ann
set.seed(123)
ann_for_rda <- train(care ~ .,data = train_data, method = "ann",trControl=ctrl)
rdaGrid = ann_for_rda$bestTune
ann_fit <- train(care ~ .,data = train_data, method = "ann", trControl=ctrl_fit, tuneGrid = rdaGrid)

annClasses <- predict(ann_fit, newdata = test_data)
annProbs <- predict(ann_fit, newdata = test_data, type = "prob")
ann_conf_matrix <- confusionMatrix(data = annClasses , test_data$care)
ann_result_roc <- multiclass.roc(test_data$care, annProbs)

table_auc_acc_kappa_imp$ann <- c(round(ann_result_roc$auc, 3) ,round(ann_conf_matrix$overall, 3))
saveRDS(table_auc_acc_kappa_imp, file = paste0(output_dir, "table_auc_acc_kappa_imp.rds"))

time <- data.table()
time$Test <- c(colnames(data.frame(ann_conf_matrix$byClass))) 
time$"Discharged" <- c(round(ann_conf_matrix$byClass, 3)[1,])
time$"Regular Ward" <- c(round(ann_conf_matrix$byClass, 3)[2,])
time$"Semi Intensive" <- c(round(ann_conf_matrix$byClass, 3)[3,])
time$"Intensivec Care Unit" <- c(round(ann_conf_matrix$byClass, 3)[4,])
time[, `:=`("Machine Learning" = "ann")]
time <- time[,c(6,1:5)]

table_sens_spec_imp <- rbind(table_sens_spec_imp, time) 
saveRDS(table_sens_spec_imp, file = paste0(output_dir, "table_sens_spec_imp.rds"))