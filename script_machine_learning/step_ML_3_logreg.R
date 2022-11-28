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

as.vector(test_data[,1])

xxx <- (test_data[,1])
xxx <- xxx$outcome

confusionMatrix(data = glmClasses, xxx)

#AUC
result.roc <- roc(xxx, glmProbs$Nosurvivor)


levels(test_data$outcome)
levels(glmClasses)



library(ROCR)
pred <- prediction(xxx, glmClasses)

is.data.table(test_data@outcome)

step_mlrC <- glm_model %>% stepAIC(trace = FALSE)

foriA <- formula(step_mlrC)

full_mlrA<- glm(foriA, data = train_data, family = 'binomial')
summary(full_mlrA)


glm_fit <- train(outcome ~ .,data = train_data, method = "glm", family="binomial",trControl=ctrl)





save(glm_fit, file = paste0(intermediate_file_dir, "glm_fit.RData"))
saveRDS(glm_fit, file = paste0(intermediate_file_dir,"glm_fit.rds"))

#AUC
result.roc <- roc(test_data$outcome, glmProbs$Yes)
save(result.roc, file = paste0(intermediate_file_dir, "result.roc.RData"))
saveRDS(result.roc, file = paste0(intermediate_file_dir,"result.roc.rds"))

#Variable importance
var_imp_glm <- varImp(glm_fit, scale = FALSE)
save(var_imp_glm, file = paste0(intermediate_file_dir, "var_imp_glm.RData"))
saveRDS(var_imp_glm, file = paste0(intermediate_file_dir,"var_imp_glm.rds"))
#plot(var_imp_glm)

# rm()