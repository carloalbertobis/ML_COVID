
glm_fit_aic <- readRDS(paste0(log_reg_dir, "glm_fit_aic.rds"))
rf_fit <- readRDS(paste0(random_forest_dir, "rf_fit.rds"))
svm_fit_radial <- readRDS(paste0(svm_dir, "svm_fit_radial.rds"))
svm_fit_linear <- readRDS(paste0(svm_dir, "svm_fit_linear.rds"))
nb_fit <- readRDS(paste0(nb_dir, "nb_fit.rds"))
nb_fit2 <- readRDS(paste0(nb_dir, "nb_fit2.rds"))
nb_fit3 <- readRDS(paste0(nb_dir, "nb_fit3.rds"))
knn_fit <- readRDS(paste0(knn_dir, "knn_fit.rds"))
ann_fit <- readRDS(paste0(ann_dir, "ann_fit.rds"))
glmnet_fit <- readRDS(paste0(glmnet_dir, "glmnet_fit.rds"))

#xgbTree_fit <- readRDS(paste0(xgbTree_dir, "xgbTree_fit.rds"))


#varimp()
var_imp <- data.table()

#log reg
var_imp_temp <- data.table()
var_imp_temp$"Var Log Reg" <- row.names((varImp(glm_fit_aic)$importance))
var_imp_temp$"Value Log Reg" <- ((varImp(glm_fit_aic)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#random forest
var_imp_temp <- data.table()
var_imp_temp$"Var RF" <- row.names((varImp(rf_fit)$importance))
var_imp_temp$"Value RF" <- ((varImp(rf_fit)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#svm radial
var_imp_temp <- data.table()
var_imp_temp$"Var SVM Radial" <- row.names((varImp(svm_fit_radial)$importance))
var_imp_temp$"Value Radial" <- varImp(svm_fit_radial)$importance[1]
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#svm linear
#var_imp_temp <- data.table()
#var_imp_temp$"Var SVM Linear" <- row.names((varImp(svm_fit_linear, scale = FALSE)$importance))
#var_imp_temp$"Value Linear" <- varImp(svm_fit_linear)$importance[1]
#var_imp_temp <- setorder(var_imp_temp, -Value)
#var_imp_temp <- var_imp_temp[1:10,]

#var_imp <- cbind(var_imp, var_imp_temp)

#nb
var_imp_temp <- data.table()
var_imp_temp$"Var Naive Bayes" <- row.names((varImp(nb_fit, scale = FALSE)$importance))
var_imp_temp$"Value NB" <- varImp(nb_fit)$importance[1]
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#KNN
var_imp_temp <- data.table()
var_imp_temp$"Var K-NN" <- row.names((varImp(knn_fit, scale = FALSE)$importance))
var_imp_temp$"Value K-NN" <- varImp(knn_fit)$importance[1]
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#ANN
var_imp_temp <- data.table()
var_imp_temp$"Var ANN" <- row.names((varImp(ann_fit, scale = FALSE)$importance))
var_imp_temp$"Value ANN" <- varImp(ann_fit)$importance[1]
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#ANN
var_imp_temp <- data.table()
var_imp_temp$"Var XGBoost" <- row.names((varImp(xgbTree_fit, scale = FALSE)$importance))
var_imp_temp$"Value XGBoost" <- varImp(xgbTree_fit)$importance[1]
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)



# SAVE
saveRDS(var_imp, file = paste0(output_dir, "var_imp.rds"))