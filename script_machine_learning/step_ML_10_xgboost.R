# load
test_data <- readRDS(paste0(intermediate_file_dir,"test_data.rds"))
train_data <- readRDS(paste0(intermediate_file_dir,"train_data.rds"))
ctrl <- readRDS(paste0(intermediate_file_dir,"ctrl.rds"))
ctrl_fit <- readRDS(paste0(intermediate_file_dir,"ctrl_fit.rds"))

# train xgbTree
xgbTree_fit <- train(outcome ~ .,data = train_data,method = "xgbTree", trControl = ctrl)
rdaGrid <- xgbTree_fit$bestTune
xgbTree_fit <- train(outcome ~ .,data = train_data, method = "xgbTree", trControl = ctrl , tuneGrid = rdaGrid)

# predict
xgbTreeClasses <- predict(xgbTree_fit, newdata = test_data)
xgbTreeProbs <- predict(xgbTree_fit, newdata = test_data, type = "prob")

xgbTree_conf_matrix <- confusionMatrix(data = xgbTreeClasses , test_data$outcome) 

# roc
xgbTree_result_roc <- roc(test_data$outcome, xgbTreeProbs$Nosurvivor)

# load table
table_con_matrix <- readRDS(paste0(output_dir, "table_con_matrix.rds"))
table_con_matrix$"XGBOOST"  <- c(round(xgbTree_result_roc$auc, 3) ,round(xgbTree_conf_matrix$byClass, 3))
saveRDS(table_con_matrix, file = paste0(output_dir, "table_con_matrix.rds"))


#save train
saveRDS(xgbTree_fit, file = paste0(xgbTree_dir, "xgbTree_fit.rds"))

#save ROC
saveRDS(xgbTree_result_roc, file = paste0(xgbTree_dir, "xgbTree_result_roc.rds"))

# save confusion matrix
saveRDS(xgbTree_conf_matrix, file = paste0(xgbTree_dir, "xgbTree_conf_matrix.rds"))

# clean
rm(ctrl, test_data, train_data, xgbTreeProbs, rdaGrid, xgbTreeClasses)
rm(xgbTree_conf_matrix, xgbTree_fit, xgbTree_result_roc)
