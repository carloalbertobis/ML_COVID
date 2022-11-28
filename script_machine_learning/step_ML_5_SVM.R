svmFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "svmRadial",trControl=ctrl, tuneLength=10)
rdaGrid = data.frame(C = 8, sigma= 4.694759e-11)
svmFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "svmRadial",trControl=ctrl, tuneGrid = rdaGrid)

svmClasses <- predict(svmFit, newdata = test.data12_i)
svmProbs <- predict(svmFit, newdata = test.data12_i, type = "prob")

confusionMatrix(data = svmClasses , test.data12_i$dp12) 

saveRDS(svmFit, "C:/Users/sarad/OneDrive/Escritorio/EPIICAL/EARTH/19- Machine Learning/ML May 2020/Models/svmFit.rds")


system.time(svmFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "svmRadial",trControl=ctrl, tuneGrid = rdaGrid) #1.63
)

time_svm<-c(2.17,1.65, 1.68, 1.7, 1.68, 1.71, 1.7, 1.68,1.7,1.7)
summary(time_svm)

#Variable importance
svmImp <- varImp(svmFit, scale = FALSE)
plot(svmImp)