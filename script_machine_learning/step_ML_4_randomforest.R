rfFit2 <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "rf",trControl=ctrl, tuneLength=10)
rdaGrid = data.frame(mtry = 12)
rfFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "rf",trControl=ctrl, tuneGrid = rdaGrid)

rfClasses <- predict(rfFit, newdata = test.data12_i)
rfProbs <- predict(rfFit, newdata = test.data12_i, type = "prob")

confusionMatrix(data = rfClasses , test.data12_i$dp12) #sensitiviy 0.7 #specificity 0.8 
saveRDS(rfFit, "C:/Users/sarad/OneDrive/Escritorio/EPIICAL/EARTH/19- Machine Learning/ML May 2020/Models/rfFit.rds")

vari<-varImp(rfFit$finalModel)
varImpPlot(rfFit$finalModel)


system.time(rfFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "rf",trControl=ctrl, tuneGrid = rdaGrid)) #1.89

time_rf<-c(1.95, 1.98, 1.92, 2, 2, 2.03, 2.0, 1.98, 1.96, 2.0)
summary(time_rf)

#Variable importance
rfImp <- varImp(rfFit, scale = FALSE)
plot(rfImp)