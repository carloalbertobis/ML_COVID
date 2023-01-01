

polr_lite <- readRDS(paste0(data_EIN_fit, "polr_lite.rds"))
polr_imp <- readRDS(paste0(data_EIN_fit, "polr_imp.rds"))

rf_lite <- readRDS(paste0(data_EIN_fit, "rf_lite.rds"))
rf_imp <- readRDS(paste0(data_EIN_fit, "rf_imp.rds"))

svm_lite <- readRDS(paste0(data_EIN_fit, "svm_lite.rds"))
svm_imp <- readRDS(paste0(data_EIN_fit, "svm_imp.rds"))

xgbTree_lite <- readRDS(paste0(data_EIN_fit, "xgbTree_lite.rds"))
xgbTree_imp <- readRDS(paste0(data_EIN_fit, "xgbTree_imp.rds"))

nb_lite <- readRDS(paste0(data_EIN_fit, "nb_lite.rds"))
nb_imp <- readRDS(paste0(data_EIN_fit, "nb_imp.rds"))

knn_lite <- readRDS(paste0(data_EIN_fit, "knn_lite.rds"))
knn_imp <- readRDS(paste0(data_EIN_fit, "knn_imp.rds"))

ann_lite <- readRDS(paste0(data_EIN_fit, "ann_lite.rds"))
ann_imp <- readRDS(paste0(data_EIN_fit, "ann_imp.rds"))

glmnet_lite <- readRDS(paste0(data_EIN_fit, "glmnet_lite.rds"))
glmnet_imp <- readRDS(paste0(data_EIN_fit, "glmnet_imp.rds"))

###########################################################

#varimp()
var_imp <- data.table()

#olr
var_imp_temp <- data.table()
var_imp_temp$OLR <- row.names((varImp(polr_lite)$importance))
var_imp_temp$Value <- ((varImp(polr_lite)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:7,]

var_imp <- cbind(var_imp, var_imp_temp)

#rf
var_imp_temp <- data.table()
var_imp_temp$RF <- row.names((varImp(rf_lite)$importance))
var_imp_temp$Value <- ((varImp(rf_lite)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:7,]

var_imp <- cbind(var_imp, var_imp_temp)

#xgbTree
var_imp_temp <- data.table()
var_imp_temp$XGB <- row.names((varImp(xgbTree_lite)$importance))
var_imp_temp$Value <- ((varImp(xgbTree_lite)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:7,]

var_imp <- cbind(var_imp, var_imp_temp)

# SAVE
saveRDS(var_imp, file = paste0(output_dir, "var_imp_lite.rds"))

####

#svm
var_imp_temp <- data.table()
var_imp_temp$SVM <- rownames(varImp(svm_lite)$importance)
var_imp_temp <- cbind(var_imp_temp, ((varImp(svm_lite)$importance)))
var_imp_temp$sum <- c((var_imp_temp[,2]+var_imp_temp[,3]+var_imp_temp[,5]+var_imp_temp[,4])/4)
#var_imp_temp <- as.data.table(var_imp_temp)
var_imp_temp <- var_imp_temp[order(var_imp_temp$sum, decreasing = TRUE),]
var_imp_temp <- var_imp_temp[1:10,1:4]

# SAVE
saveRDS(var_imp_temp, file = paste0(output_dir, "var_imp_svm_lite.rds"))

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

#xgbTree
var_imp_temp <- data.table()
var_imp_temp$XGB <- row.names((varImp(xgbTree_imp)$importance))
var_imp_temp$Value <- ((varImp(xgbTree_imp)$importance))
var_imp_temp <- setorder(var_imp_temp, -Value)
var_imp_temp <- var_imp_temp[1:10,]

var_imp <- cbind(var_imp, var_imp_temp)

# SAVE
saveRDS(var_imp, file = paste0(output_dir, "var_imp_imp.rds"))

#svm
var_imp_temp <- data.table()
var_imp_temp$SVM <- rownames(varImp(svm_imp)$importance)
var_imp_temp <- cbind(var_imp_temp, ((varImp(svm_imp)$importance)))
var_imp_temp$sum <- c((var_imp_temp[,2]+var_imp_temp[,3]+var_imp_temp[,5]+var_imp_temp[,4])/4)
#var_imp_temp <- as.data.table(var_imp_temp)
var_imp_temp <- var_imp_temp[order(var_imp_temp$sum, decreasing = TRUE),]
var_imp_temp <- var_imp_temp[1:10,1:4]

# SAVE
saveRDS(var_imp_temp, file = paste0(output_dir, "var_imp_svm_imp.rds"))



