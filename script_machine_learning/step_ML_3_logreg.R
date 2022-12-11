
# Logistic Regression
load(paste0(intermediate_file_dir, "train_data.RData"))
load(paste0(intermediate_file_dir, "test_data.RData"))
load(paste0(intermediate_file_dir, "ctrl.RData"))

#test_data <- readRDS(paste0(data_sample_dir,"test_data.rds"))
#train_data <- readRDS(paste0(data_sample_dir,"train_data.rds"))

#cambio levels
levels(train_data$outcome) <- c("Nosurvivor","Survivor")
levels(test_data$outcome) <- c("Nosurvivor","Survivor")

# glm full model
glm_full_model <- glm(outcome ~ .,data = train_data,  family = "binomial")
formula_glm_full <- formula(glm_full_model)
#summary(glm_model)

# seleccion AIC variables mas significativas
aic_model <- stepAIC(glm_full_model, trace = FALSE)
formula_glm_aic_model <- formula(aic_model)

glm_aic_model <- glm(formula_glm_aic_model, data = train_data, family = "binomial")
summary(glm_aic_model)

# train 
glm_fit_aic <- train(formula_glm_aic_model, data = train_data, method = "glm", family="binomial",trControl=ctrl)
glm_fit_full <- train(formula_glm_full, data = train_data, method = "glm", family="binomial",trControl=ctrl)

# predict

glmClasses <- predict(glm_fit_aic, newdata = test_data)
glmProbs <- predict(glm_fit_aic, newdata = test_data, type = "prob")

#xxx <- (test_data[,1])
#xxx <- xxx$outcome
#confusionMatrix(data = glmClasses, xxx)

glm_conf_matrix <- confusionMatrix(data = glmClasses, test_data$outcome)

#AUC
glm_result_roc <- roc(test_data$outcome, glmProbs$Nosurvivor)

#################################
#library(ROCR)
#glmProbs <- predict(glm_fit_aic, newdata = test_data, type = "prob")

#pred <- prediction(glmProbs$Survivor, test_data$outcome)

#roc <- performance(pred, measure = "fpr", x.measure = "tpr")
#plot(roc)

#roc2 <- performance(pred, measure = "auc")
#auc <- roc2@y.values
#auc
######################################

#save fit 
save(glm_fit_aic, file = paste0(glm_dir, "glm_fit_aic.RData"))
saveRDS(glm_fit_aic, file = paste0(glm_dir, "glm_fit_aic.rds"))
        
# save ROC
save(glm_result_roc, file = paste0(glm_dir, "glm_result_roc.RData"))
saveRDS(glm_result_roc, file = paste0(glm_dir, "glm_result_roc.rds"))

# save confusion matrix
save(glm_conf_matrix, file = paste0(glm_dir, "glm_conf_matrix.RData"))
saveRDS(glm_conf_matrix, file = paste0(glm_dir, "glm_conf_matrix.rds"))

# save formula model AIC
save(formula_glm_aic_model, file = paste0(glm_dir, "formula_glm_aic_model.RData"))
saveRDS(formula_glm_aic_model, file = paste0(glm_dir, "formula_glm_aic_model.rds"))

#clean
rm(glm_result_roc, glm_conf_matrix, aic_model, ctrl, glm_aic_model, glm_fit_aic, glm_fit_full, glm_full_model, glmProbs, test_data, train_data)



