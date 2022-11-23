#crossvalidation
set.seed(123)
ctrl <- trainControl(method = "repeatedcv", repeats = 10,
                     classProbs = TRUE,
                     summaryFunction = twoClassSummary,
                     ## new option here:
                     sampling = "down", savePredictions = T)