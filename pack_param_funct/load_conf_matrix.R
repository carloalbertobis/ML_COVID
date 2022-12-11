
# load conf_matrix
load(paste0(dir_list[1],"glm_conf_matrix.Rdata"))
load(paste0(dir_list[2],"rf_conf_matrix.Rdata"))
load(paste0(dir_list[3],"svm_conf_matrix_radial.Rdata"))
load(paste0(dir_list[3],"svm_conf_matrix_linear.Rdata"))
load(paste0(dir_list[4],"nb_conf_matrix.Rdata"))
load(paste0(dir_list[4],"nb_conf_matrix2.Rdata"))
load(paste0(dir_list[4],"nb_conf_matrix3.Rdata"))
load(paste0(dir_list[5],"knn_conf_matrix.Rdata"))
load(paste0(dir_list[6],"ann_conf_matrix.Rdata"))
load(paste0(dir_list[7],"glmnet_conf_matrix.Rdata"))