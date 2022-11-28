glmnetFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "glmnet",trControl=ctrl, tuneLength=10)
rdaGrid = data.frame(alpha=0.8, lambda=0.210781)
glmnetFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "glmnet",trControl=ctrl, tuneGrid = rdaGrid)

glmnetClasses <- predict(glmnetFit , newdata = test.data12_i)
glmnetProbs <- predict(glmnetFit , newdata = test.data12_i, type = "prob")

confusionMatrix(data = glmnetClasses , test.data12_i$dp12) #sensitiviy 0.8 #specificity 0.7

saveRDS(glmnetFit, "C:/Users/sarad/OneDrive/Escritorio/EPIICAL/EARTH/19- Machine Learning/ML May 2020/Models/glmnetFit.rds")

system.time(glmnetFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "glmnet",trControl=ctrl, tuneGrid = rdaGrid)) #1.81

time_glmnet<-c(1.95,1.75,1.79, 1.83, 1.87, 1.78, 1.81, 1.8,1.8,1.86)
summary(time_glmnet)

#Variable importance
glmnetImp <- varImp(glmnetFit, scale = FALSE)
plot(glmnetImp)