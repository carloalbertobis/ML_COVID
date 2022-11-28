nbFit <- train(dp12 ~ .,data = train.data12_i[,c(2:7,9:13)],method = "nb")
rdaGrid = data.frame(fL=0, usekernel=TRUE, adjust=1)
nbFit <- train(dp12 ~ .,data = train.data12_i[,c(2:7,9:13)],method = "nb",trControl=ctrl, tuneGrid = rdaGrid)

nbClasses <- predict(nbFit, newdata = test.data12_i)
nbProbs <- predict(nbFit, newdata = test.data12_i, type = "prob")

confusionMatrix(data = nbClasses , test.data12_i$dp12) #sensitiviy 0.8 #specificity 0.7


saveRDS(nbFit, "C:/Users/sarad/OneDrive/Escritorio/EPIICAL/EARTH/19- Machine Learning/ML May 2020/Models/nbFit.rds")


system.time(nbFit <- train(dp12 ~ .,data = train.data12_i[,c(2:7,9:13)],method = "nb",trControl=ctrl, tuneGrid = rdaGrid)) #2.47

time_nb<-c(2.5,2.69,2.58,2.61, 2.83, 2.52, 2.61, 2.56,2.64, 2.61)
summary(time_nb)

#Variable importance
nbImp <- varImp(nbFit, scale = FALSE)
plot(nbImp)