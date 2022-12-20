
# load
test_data <- readRDS(paste0(intermediate_file_dir,"test_data.rds"))
train_data <- readRDS(paste0(intermediate_file_dir,"train_data.rds"))
ctrl <- readRDS(paste0(intermediate_file_dir,"ctrl.rds"))
ctrl_fit <- readRDS(paste0(intermediate_file_dir,"ctrl_fit.rds"))

# train random forest
set.seed(123)
rf_for_rda <- train(outcome ~ .,data = train_data, method = "rf",trControl=ctrl)
rdaGrid = rf_for_rda$bestTune
rf_fit <- train(outcome ~ .,data = train_data,method = "rf", trControl=ctrl_fit, tuneGrid = rdaGrid)


# predict random forest
rfClasses <- predict(rf_fit, newdata = test_data)
rfProbs <- predict(rf_fit, newdata = test_data, type = "prob")

rf_conf_matrix <- confusionMatrix(data = rfClasses , test_data$outcome)

#AUC
rf_result_roc <- roc(test_data$outcome, rfProbs$Nosurvivor)

# load table
table_con_matrix <- readRDS(paste0(output_dir, "table_con_matrix.rds"))
table_con_matrix$"Random Forest"  <- c(round(rf_result_roc$auc, 3) ,round(rf_conf_matrix$byClass, 3))
saveRDS(table_con_matrix, file = paste0(output_dir, "table_con_matrix.rds"))


#save train
saveRDS(rf_fit, file = paste0(random_forest_dir, "rf_fit.rds"))

#save ROC
saveRDS(rf_result_roc, file = paste0(random_forest_dir, "rf_result_roc.rds"))

# save confusion matrix
saveRDS(rf_conf_matrix, file = paste0(random_forest_dir, "rf_conf_matrix.rds"))


#clean
rm(ctrl, test_data, train_data, rf_conf_matrix, rf_fit, rf_result_roc, rfProbs, rdaGrid, rf_for_rda)
