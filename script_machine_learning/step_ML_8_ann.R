annFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "nnet",trControl=ctrl, tuneLength=10)
rdaGrid = data.frame(size=11, decay=0.1)
annFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "nnet",trControl=ctrl, tuneGrid = rdaGrid)

annClasses <- predict(annFit, newdata = test.data12_i)
annProbs <- predict(annFit, newdata = test.data12_i, type = "prob")

confusionMatrix(data = annClasses , test.data12_i$dp12) 

saveRDS(annFit, "C:/Users/sarad/OneDrive/Escritorio/EPIICAL/EARTH/19- Machine Learning/ML May 2020/Models/annFit.rds")

system.time(annFit <- train(dp12 ~ .,data = train.data12_i[,c(2:13)],method = "nnet",trControl=ctrl, tuneGrid = rdaGrid) #2.3
)

time_ann<-c(2.58, 2.45, 2.5,2.56,2.54, 2.5,2.5, 2.5, 2.5, 2.43)
summary(time_ann)

#Variable importance
annImp <- varImp(annFit, scale = FALSE)
plot(annImp)