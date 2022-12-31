rm(list=ls(all.names=TRUE))

#sample <- "SID"
sample <- "ein"
#sample <- "sample"

#set path libraries functions
if (!require("rstudioapi")) install.packages("rstudioapi")
projectFolder <- setwd(dirname(rstudioapi::getSourceEditorContext()$path))

source(paste0(projectFolder, "/pack_param_funct/path.R"))
source(paste0(projectFolder, "/pack_param_funct/packages.R"))
#source(paste0(projectFolder, "/pack_param_funct/functions.R"))



#set the directory where the file is saved as the working directory
source("script_data_analysis/pre_step_data_einstein.R") 

source("script_data_analysis/step_1_data_analysis.R") 
#render(paste0(memoria_dir, "04_Stat_An.Rmd"), output_dir = output_dir)

# data prep

source("script_machine_learning/ein_step_0_datasplit.R") 

source("script_machine_learning/step_ML_2_crossvalidation.R") 


# script_machine_learning

source("script_machine_learning/ein_step_1_polr.R") 





source("script_machine_learning/step_ML_3_logreg.R") 

source("script_machine_learning/step_ML_4_randomforest.R") 

source("script_machine_learning/step_ML_5_SVM.R") 

source("script_machine_learning/step_ML_6_naivebayes.R") 

source("script_machine_learning/step_ML_7_knn.R") 

source("script_machine_learning/step_ML_8_ann.R")

source("script_machine_learning/step_ML_9_glmnet.R") 

source("script_machine_learning/step_ML_10_xgboost.R") 

source("script_machine_learning/step_ML_12_var_imp.R") 



# execute_RMarkdown

render(paste0(memoria_dir, "index.Rmd"), c("html_document", "pdf_document"), output_dir = output_dir)



