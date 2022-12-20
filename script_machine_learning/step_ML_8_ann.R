# load
test_data <- readRDS(paste0(intermediate_file_dir,"test_data.rds"))
train_data <- readRDS(paste0(intermediate_file_dir,"train_data.rds"))
ctrl <- readRDS(paste0(intermediate_file_dir,"ctrl.rds"))
ctrl_fit <- readRDS(paste0(intermediate_file_dir,"ctrl_fit.rds"))

# train ann
ann_fit <- train(outcome ~ .,data = train_data,method = "nnet", trControl=ctrl)
rdaGrid <- ann_fit$bestTune
ann_fit <- train(outcome ~ .,data = train_data, method = "nnet", trControl=ctrl_fit, tuneGrid = rdaGrid)

# predict
annClasses <- predict(ann_fit, newdata = test_data)
annProbs <- predict(ann_fit, newdata = test_data, type = "prob")

ann_conf_matrix <- confusionMatrix(data = annClasses , test_data$outcome) 

# roc
ann_result_roc <- roc(test_data$outcome, annProbs$Nosurvivor)

# load table
table_con_matrix <- readRDS(paste0(output_dir, "table_con_matrix.rds"))
table_con_matrix$"ANN"  <- c(round(ann_result_roc$auc, 3) ,round(ann_conf_matrix$byClass, 3))
saveRDS(table_con_matrix, file = paste0(output_dir, "table_con_matrix.rds"))

#save train
saveRDS(ann_fit, file = paste0(ann_dir, "ann_fit.rds"))

#save ROC
saveRDS(ann_result_roc, file = paste0(ann_dir, "ann_result_roc.rds"))

# save confusion matrix
saveRDS(ann_conf_matrix, file = paste0(ann_dir, "ann_conf_matrix.rds"))

# clean
rm(ctrl, test_data, train_data, annProbs, rdaGrid, annClasses)
rm(ann_conf_matrix, ann_fit, ann_result_roc)
