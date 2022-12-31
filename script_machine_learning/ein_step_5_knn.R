
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
# knn
set.seed(123)
knn_for_rda <- train(care ~ .,data = train_data_ein_lite, method = "knn",trControl=ctrl)
rdaGrid = knn_for_rda$bestTune
knn_fit <- train(care ~ .,data = train_data_ein_lite,method = "knn", trControl=ctrl_fit, tuneGrid = rdaGrid)

knnClasses <- predict(knn_fit, newdata = test_data_ein_lite)
knnProbs <- predict(knn_fit, newdata = test_data_ein_lite, type = "prob")
knn_conf_matrix <- confusionMatrix(data = knnClasses , test_data_ein_lite$care)
knn_result_roc <- multiclass.roc(test_data_ein_lite$care, knnProbs)

table_auc_acc_kappa$knn <- c(round(knn_result_roc$auc, 3) ,round(knn_conf_matrix$overall, 3))
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

knnClasses <- predict(knn_fit, newdata = test_data)
knnProbs <- predict(knn_fit, newdata = test_data, type = "prob")
knn_conf_matrix <- confusionMatrix(data = knnClasses , test_data$care)
knn_result_roc <- multiclass.roc(test_data$care, knnProbs)

table_auc_acc_kappa_imp$knn <- c(round(knn_result_roc$auc, 3) ,round(knn_conf_matrix$overall, 3))
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