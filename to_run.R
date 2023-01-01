rm(list=ls(all.names=TRUE))

#sample <- "SID"
sample <- "ein"
#sample <- "sample"

#set path libraries functions
if (!require("rstudioapi")) install.packages("rstudioapi")
projectFolder <- setwd(dirname(rstudioapi::getSourceEditorContext()$path))

source(paste0(projectFolder, "/pack_param_funct/path.R"))
source(paste0(projectFolder, "/pack_param_funct/packages.R"))
source("script_machine_learning/step_ML_2_crossvalidation.R") 
#source(paste0(projectFolder, "/pack_param_funct/functions.R"))


#set the directory where the file is saved as the working directory
source("script_data_analysis/pre_step_data_einstein.R") 
source("script_data_analysis/step_1_data_analysis.R") 
#render(paste0(memoria_dir, "04_Stat_An.Rmd"), output_dir = output_dir)



# data prep
system.time(source("script_machine_learning/ein_step_0_datasplit.R"))

# script_machine_learning
system.time(source("script_machine_learning/ein_step_1_polr.R"))    # 278
system.time(source("script_machine_learning/ein_step_2_rf.R"))      #
system.time(source("script_machine_learning/ein_step_3_svm.R"))
system.time(source("script_machine_learning/ein_step_4_nb.R"))
system.time(source("script_machine_learning/ein_step_5_knn.R"))
system.time(source("script_machine_learning/ein_step_6_ann.R"))     # 450
system.time(source("script_machine_learning/ein_step_7_glmnet.R"))  # 751
system.time(source("script_machine_learning/ein_step_8_xgbTree.R")) # 5221
#system.time(source("script_machine_learning/ein_step_9_varimp.R"))
system.time(source("script_machine_learning/ein_step_9_varimp2.R"))

###### estimar negativos riesgo


###### positividad covid traves analisis



# olr  rf xgbtree + svm


#source("script_machine_learning/step_ML_3_logreg.R") 
#source("script_machine_learning/step_ML_4_randomforest.R") 
#source("script_machine_learning/step_ML_5_SVM.R") 
#source("script_machine_learning/step_ML_6_naivebayes.R") 
#source("script_machine_learning/step_ML_7_knn.R") 
#source("script_machine_learning/step_ML_8_ann.R")
#source("script_machine_learning/step_ML_9_glmnet.R") 
#source("script_machine_learning/step_ML_10_xgboost.R") 
#source("script_machine_learning/step_ML_12_var_imp.R") 



# execute_RMarkdown

render(paste0(memoria_dir, "index.Rmd"), c("html_document", "pdf_document"), output_dir = output_dir)



