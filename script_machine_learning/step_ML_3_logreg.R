# Logistic Regression
load(paste0(intermediate_file_dir, "train_data.RData"))
load(paste0(intermediate_file_dir, "test_data.RData"))

glm_model <- glm(outcome ~ .,data = train_data, family="binomial")
#summary(glm_model)
stepAIC(glm_model, trace = FALSE)
step_mlrC <- glm_model %>% stepAIC(trace = FALSE)

formula(step_mlrC)

glm_fit <- train(outcome ~ .,data = train_data, method = "glm", family="binomial",trControl=ctrl)

glmClasses <- predict(glm_fit, newdata = test_data)
glmProbs <- predict(glm_fit, newdata = test_data, type = "prob")

confusionMatrix(data = glmClasses , test_data$outcome)

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