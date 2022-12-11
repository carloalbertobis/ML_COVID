# load
load(paste0(intermediate_file_dir, "train_data.RData"))
load(paste0(intermediate_file_dir, "test_data.RData"))
load(paste0(intermediate_file_dir, "ctrl.RData"))

# train glmnet
glmnet_fit <- train(outcome ~ .,data = train_data,method = "glmnet", trControl=ctrl, tuneLength=10)
rdaGrid <- glmnet_fit$bestTune
glmnet_fit <- train(outcome ~ .,data = train_data, method = "glmnet", trControl=ctrl, tuneGrid = rdaGrid)

# predict
glmnetClasses <- predict(glmnet_fit, newdata = test_data)
glmnetProbs <- predict(glmnet_fit, newdata = test_data, type = "prob")

glmnet_conf_matrix <- confusionMatrix(data = glmnetClasses , test_data$outcome) 

# roc
glmnet_result_roc <- roc(test_data$outcome, glmnetProbs$Nosurvivor)


#save train
save(glmnet_fit, file = paste0(glmnet_dir, "glmnet_fit.RData"))
saveRDS(glmnet_fit, file = paste0(glmnet_dir, "glmnet_fit.rds"))

#save ROC
save(glmnet_result_roc, file = paste0(glmnet_dir, "glmnet_result_roc.RData"))
saveRDS(glmnet_result_roc, file = paste0(glmnet_dir, "glmnet_result_roc.rds"))

# save confusion matrix
save(glmnet_conf_matrix, file = paste0(glmnet_dir, "glmnet_conf_matrix.RData"))
saveRDS(glmnet_conf_matrix, file = paste0(glmnet_dir, "glmnet_conf_matrix.rds"))

# clean
rm(ctrl, test_data, train_data, glmnetProbs, rdaGrid, glmnetClasses)
rm(glmnet_conf_matrix, glmnet_fit, glmnet_result_roc)
