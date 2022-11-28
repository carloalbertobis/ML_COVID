knnFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "knn",trControl=ctrl, tuneLength=10)
rdaGrid = data.frame(k=5)
knnFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "knn",trControl=ctrl, tuneGrid = rdaGrid)

knnClasses <- predict(knnFit, newdata = test.data12_i)
knnProbs <- predict(knnFit, newdata = test.data12_i, type = "prob")

confusionMatrix(data = knnClasses , test.data12_i$dp12) 

saveRDS(knnFit, "C:/Users/sarad/OneDrive/Escritorio/EPIICAL/EARTH/19- Machine Learning/ML May 2020/Models/knnFit.rds")


system.time(knnFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "knn",trControl=ctrl, tuneGrid = rdaGrid)) #0.95

time_knn<-c(0.99,1.05,1.01,1.05,1.06,1.05, 1.07,1.04,1.05,1)
summary(time_knn)

#Variable importance
knnImp <- varImp(knnFit, scale = FALSE)
plot(knnImp)