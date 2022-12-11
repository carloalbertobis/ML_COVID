
nb_dir <- naive_bayes_dir

# load
load(paste0(intermediate_file_dir, "train_data.RData"))
load(paste0(intermediate_file_dir, "test_data.RData"))
load(paste0(intermediate_file_dir, "ctrl.RData"))

# train svm
nb_fit <- train(outcome ~ .,data = train_data,method = "nb", trControl=ctrl, tuneLength=10)
nb_fit2 <- train(outcome ~ .,data = train_data,method = "nb", tuneLength=10)
nb_fit3 <- train(outcome ~ .,data = train_data,method = "nb")

rdaGrid <- nb_fit$bestTune
rdaGrid2 <- nb_fit2$bestTune
rdaGrid3 <- nb_fit3$bestTune

nb_fit <- train(outcome ~ .,data = train_data, method = "nb", trControl=ctrl, tuneGrid = rdaGrid)
nb_fit2 <- train(outcome ~ .,data = train_data, method = "nb", trControl=ctrl, tuneGrid = rdaGrid2)
nb_fit3 <- train(outcome ~ .,data = train_data, method = "nb", trControl=ctrl, tuneGrid = rdaGrid3)

# predict
nbClasses <- predict(nb_fit, newdata = test_data)
nbClasses2 <- predict(nb_fit2, newdata = test_data)
nbClasses3 <- predict(nb_fit3, newdata = test_data)

nb_conf_matrix <- confusionMatrix(data = nbClasses , test_data$outcome) 
nb_conf_matrix2 <- confusionMatrix(data = nbClasses2 , test_data$outcome) 
nb_conf_matrix3 <- confusionMatrix(data = nbClasses3 , test_data$outcome) 

# roc
nbProbs <- predict(nb_fit, newdata = test_data, type = "prob")
nbProbs2 <- predict(nb_fit2, newdata = test_data, type = "prob")
nbProbs3 <- predict(nb_fit3, newdata = test_data, type = "prob")

nb_result_roc <- roc(test_data$outcome, nbProbs$Nosurvivor)
nb_result_roc2 <- roc(test_data$outcome, nbProbs2$Nosurvivor)
nb_result_roc3 <- roc(test_data$outcome, nbProbs3$Nosurvivor)

#save train
save(nb_fit, file = paste0(nb_dir, "nb_fit.RData"))
saveRDS(nb_fit, file = paste0(nb_dir, "nb_fit.rds"))
save(nb_fit2, file = paste0(nb_dir, "nb_fit2.RData"))
saveRDS(nb_fit2, file = paste0(nb_dir, "nb_fit2.rds"))
save(nb_fit3, file = paste0(nb_dir, "nb_fit3.RData"))
saveRDS(nb_fit3, file = paste0(nb_dir, "nb_fit3.rds"))

#save ROC
save(nb_result_roc, file = paste0(nb_dir, "nb_result_roc.RData"))
saveRDS(nb_result_roc, file = paste0(nb_dir, "nb_result_roc.rds"))
save(nb_result_roc2, file = paste0(nb_dir, "nb_result_roc2.RData"))
saveRDS(nb_result_roc2, file = paste0(nb_dir, "nb_result_roc2.rds"))
save(nb_result_roc3, file = paste0(nb_dir, "nb_result_roc3.RData"))
saveRDS(nb_result_roc3, file = paste0(nb_dir, "nb_result_roc3.rds"))

# save confusion matrix
save(nb_conf_matrix, file = paste0(nb_dir, "nb_conf_matrix.RData"))
saveRDS(nb_conf_matrix, file = paste0(nb_dir, "nb_conf_matrix.rds"))
save(nb_conf_matrix2, file = paste0(nb_dir, "nb_conf_matrix2.RData"))
saveRDS(nb_conf_matrix2, file = paste0(nb_dir, "nb_conf_matrix2.rds"))
save(nb_conf_matrix3, file = paste0(nb_dir, "nb_conf_matrix3.RData"))
saveRDS(nb_conf_matrix3, file = paste0(nb_dir, "nb_conf_matrix3.rds"))


# clean
rm(test_data, train_data, ctrl, rdaGrid, rdaGrid2, rdaGrid3)
rm(nb_conf_matrix, nb_fit, nb_result_roc, nbProbs)
rm(nb_conf_matrix2, nb_fit2, nb_result_roc2, nbProbs2)
rm(nb_conf_matrix3, nb_fit3, nb_result_roc3, nbProbs3)

