

polr_lite <- readRDS(paste0(data_EIN_dir, "polr_lite.rds"))
polr_imp <- readRDS(paste0(data_EIN_dir, "polr_imp.rds"))

rf_lite <- readRDS(paste0(data_EIN_dir, "rf_lite.rds"))
rf_imp <- readRDS(paste0(data_EIN_dir, "rf_imp.rds"))

svm_lite <- readRDS(paste0(data_EIN_dir, "svm_lite.rds"))
svm_imp <- readRDS(paste0(data_EIN_dir, "svm_imp.rds"))

xgbTree_lite <- readRDS(paste0(data_EIN_dir, "xgbTree_lite.rds"))
xgbTree_imp <- readRDS(paste0(data_EIN_dir, "xgbTree_imp.rds"))

nb_lite <- readRDS(paste0(data_EIN_dir, "nb_lite.rds"))
nb_imp <- readRDS(paste0(data_EIN_dir, "nb_imp.rds"))

knn_lite <- readRDS(paste0(data_EIN_dir, "knn_lite.rds"))
knn_imp <- readRDS(paste0(data_EIN_dir, "knn_imp.rds"))

ann_lite <- readRDS(paste0(data_EIN_dir, "ann_lite.rds"))
ann_imp <- readRDS(paste0(data_EIN_dir, "ann_imp.rds"))

glmnet_lite <- readRDS(paste0(data_EIN_dir, "glmnet_lite.rds"))
glmnet_imp <- readRDS(paste0(data_EIN_dir, "glmnet_imp.rds"))

###########################################################

#varimp()
var_imp <- data.table()

#olr
var_imp_temp <- data.table()
var_imp_temp$OLR <- row.names((varImp(polr_lite)$importance))
var_imp_temp$Value <- ((varImp(polr_lite)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#rf
var_imp_temp <- data.table()
var_imp_temp$RF <- row.names((varImp(rf_lite)$importance))
var_imp_temp$Value <- ((varImp(rf_lite)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#svm
var_imp_temp <- data.table()
var_imp_temp$SVM <- row.names((varImp(svm_lite)$importance))
var_imp_temp$Value <- ((varImp(svm_lite)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#nb
var_imp_temp <- data.table()
var_imp_temp$NB <- row.names((varImp(nb_lite)$importance))
var_imp_temp$Value <- ((varImp(nb_lite)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#knn
var_imp_temp <- data.table()
var_imp_temp$KNN <- row.names((varImp(knn_lite)$importance))
var_imp_temp$Value <- ((varImp(knn_lite)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)


#ann
var_imp_temp <- data.table()
var_imp_temp$ANN <- row.names((varImp(ann_lite)$importance))
var_imp_temp$Value <- ((varImp(ann_lite)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)


#glmnet
var_imp_temp <- data.table()
var_imp_temp$GLMNET <- row.names((varImp(glmnet_lite)$importance))
var_imp_temp$Value <- ((varImp(glmnet_lite)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)


#xgbTree
var_imp_temp <- data.table()
var_imp_temp$XGB <- row.names((varImp(xgbTree_lite)$importance))
var_imp_temp$Value <- ((varImp(xgbTree_lite)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

# SAVE
saveRDS(var_imp, file = paste0(output_dir, "var_imp_lite.rds"))

######################################################################

#varimp()
var_imp <- data.table()

#olr
var_imp_temp <- data.table()
var_imp_temp$OLR <- row.names((varImp(polr_imp)$importance))
var_imp_temp$Value <- ((varImp(polr_imp)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#rf
var_imp_temp <- data.table()
var_imp_temp$RF <- row.names((varImp(rf_imp)$importance))
var_imp_temp$Value <- ((varImp(rf_imp)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#svm
var_imp_temp <- data.table()
var_imp_temp$SVM <- row.names((varImp(svm_imp)$importance))
var_imp_temp$Value <- ((varImp(svm_imp)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#nb
var_imp_temp <- data.table()
var_imp_temp$NB <- row.names((varImp(nb_imp)$importance))
var_imp_temp$Value <- ((varImp(nb_imp)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

#knn
var_imp_temp <- data.table()
var_imp_temp$KNN <- row.names((varImp(knn_imp)$importance))
var_imp_temp$Value <- ((varImp(knn_imp)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)


#ann
var_imp_temp <- data.table()
var_imp_temp$ANN <- row.names((varImp(ann_imp)$importance))
var_imp_temp$Value <- ((varImp(ann_imp)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)


#glmnet
var_imp_temp <- data.table()
var_imp_temp$GLMNET <- row.names((varImp(glmnet_imp)$importance))
var_imp_temp$Value <- ((varImp(glmnet_imp)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)


#xgbTree
var_imp_temp <- data.table()
var_imp_temp$XGB <- row.names((varImp(xgbTree_imp)$importance))
var_imp_temp$Value <- ((varImp(xgbTree_imp)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

# SAVE
saveRDS(var_imp, file = paste0(output_dir, "var_imp_imp.rds"))



