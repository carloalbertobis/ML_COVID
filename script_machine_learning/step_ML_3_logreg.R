# Logistic Regression

glm_model <-glm(severity ~ .,data = train_data[,c(2:13)], family=binomial)
stepAIC(glm_model)

glm_fit <- train(severity ~ .,data = train_data[,c(2:13)],method = "glm", family="binomial",trControl=ctrl)

glmClasses <- predict(glm_fit, newdata = test_data)
glmProbs <- predict(glm_fit, newdata = test_data, type = "prob")

confusionMatrix(data = glmClasses , test_data$severity)

save(glm_fit, file = paste0(intermediate_file_dir, "glm_fit.RData"))
saveRDS(glm_fit, file = paste0(intermediate_file_dir,"glm_fit.rds"))

#system time
#system.time(glmFit <- train(severity ~ .,data = train_data[,c(2:13)],method = "glm", family="binomial",trControl=ctrl)) #1.48
#time_glm<-c(1.36, 1.35,1.35,1.31,1.39,1.31,1.39,1.35,1.33,1.32)
#summary(time_glm)

#AUC
result.roc <- roc(test_data$severity, glmProbs$Yes)
save(result.roc, file = paste0(intermediate_file_dir, "result.roc.RData"))
saveRDS(result.roc, file = paste0(intermediate_file_dir,"result.roc.rds"))

#Variable importance
var_imp_glm <- varImp(glm_fit, scale = FALSE)
save(var_imp_glm, file = paste0(intermediate_file_dir, "var_imp_glm.RData"))
saveRDS(var_imp_glm, file = paste0(intermediate_file_dir,"var_imp_glm.rds"))
#plot(var_imp_glm)

#rm()