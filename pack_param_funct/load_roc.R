
# load roc
load(paste0(dir_list[1],"glm_result_roc.Rdata"))
load(paste0(dir_list[2],"rf_result_roc.Rdata"))
load(paste0(dir_list[3],"svm_result_roc_radial.Rdata"))
load(paste0(dir_list[3],"svm_result_roc_linear.Rdata"))
load(paste0(dir_list[4],"nb_result_roc.Rdata"))
load(paste0(dir_list[4],"nb_result_roc2.Rdata"))
load(paste0(dir_list[4],"nb_result_roc3.Rdata"))
load(paste0(dir_list[5],"knn_result_roc.Rdata"))
load(paste0(dir_list[6],"ann_result_roc.Rdata"))
load(paste0(dir_list[7],"glmnet_result_roc.Rdata"))