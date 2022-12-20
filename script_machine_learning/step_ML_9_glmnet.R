# load
test_data <- readRDS(paste0(intermediate_file_dir,"test_data.rds"))
train_data <- readRDS(paste0(intermediate_file_dir,"train_data.rds"))
ctrl <- readRDS(paste0(intermediate_file_dir,"ctrl.rds"))
ctrl_fit <- readRDS(paste0(intermediate_file_dir,"ctrl_fit.rds"))

# train glmnet
glmnet_fit <- train(outcome ~ .,data = train_data,method = "glmnet", trControl=ctrl, tuneLength=10)
rdaGrid <- glmnet_fit$bestTune
glmnet_fit <- train(outcome ~ .,data = train_data, method = "glmnet", trControl=ctrl_fit, tuneGrid = rdaGrid)

# predict
glmnetClasses <- predict(glmnet_fit, newdata = test_data)
glmnetProbs <- predict(glmnet_fit, newdata = test_data, type = "prob")

glmnet_conf_matrix <- confusionMatrix(data = glmnetClasses , test_data$outcome) 

# roc
glmnet_result_roc <- roc(test_data$outcome, glmnetProbs$Nosurvivor)

# load table
table_con_matrix <- readRDS(paste0(output_dir, "table_con_matrix.rds"))
table_con_matrix$"GLMNET"  <- c(round(glmnet_result_roc$auc, 3) ,round(glmnet_conf_matrix$byClass, 3))
saveRDS(table_con_matrix, file = paste0(output_dir, "table_con_matrix.rds"))

#save train
saveRDS(glmnet_fit, file = paste0(glmnet_dir, "glmnet_fit.rds"))

#save ROC
saveRDS(glmnet_result_roc, file = paste0(glmnet_dir, "glmnet_result_roc.rds"))

# save confusion matrix
saveRDS(glmnet_conf_matrix, file = paste0(glmnet_dir, "glmnet_conf_matrix.rds"))

# clean
rm(ctrl, test_data, train_data, glmnetProbs, rdaGrid, glmnetClasses)
rm(glmnet_conf_matrix, glmnet_fit, glmnet_result_roc)
