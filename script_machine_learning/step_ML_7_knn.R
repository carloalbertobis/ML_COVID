
# load
load(paste0(intermediate_file_dir, "train_data.RData"))
load(paste0(intermediate_file_dir, "test_data.RData"))
load(paste0(intermediate_file_dir, "ctrl.RData"))

# train knn
knn_fit <- train(outcome ~ .,data = train_data,method = "knn", trControl=ctrl, tuneLength=10)
rdaGrid <- knn_fit$bestTune
knn_fit <- train(outcome ~ .,data = train_data, method = "knn", trControl=ctrl, tuneGrid = rdaGrid)

# predict
knnClasses <- predict(knn_fit, newdata = test_data)
knnProbs <- predict(knn_fit, newdata = test_data, type = "prob")

knn_conf_matrix <- confusionMatrix(data = knnClasses , test_data$outcome) 

# roc
knn_result_roc <- roc(test_data$outcome, knnProbs$Nosurvivor)


#save train
save(knn_fit, file = paste0(knn_dir, "knn_fit.RData"))
saveRDS(knn_fit, file = paste0(knn_dir, "knn_fit.rds"))

#save ROC
save(knn_result_roc, file = paste0(knn_dir, "knn_result_roc.RData"))
saveRDS(knn_result_roc, file = paste0(knn_dir, "knn_result_roc.rds"))

# save confusion matrix
save(knn_conf_matrix, file = paste0(knn_dir, "knn_conf_matrix.RData"))
saveRDS(knn_conf_matrix, file = paste0(knn_dir, "knn_conf_matrix.rds"))

# clean
rm(ctrl, test_data, train_data, knnProbs, rdaGrid, knnClasses)
rm(knn_conf_matrix, knn_fit, knn_result_roc)
