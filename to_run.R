rm(list=ls(all.names=TRUE))


#set path libraries functions
if (!require("rstudioapi")) install.packages("rstudioapi")
projectFolder <- setwd(dirname(rstudioapi::getSourceEditorContext()$path))

source(paste0(projectFolder, "/pack_param_funct/path.R"))
source(paste0(projectFolder, "/pack_param_funct/packages.R"))
#source(paste0(projectFolder, "/pack_param_funct/functions.R"))


#set the directory where the file is saved as the working directory









# script_machine_learning


source("script_machine_learning/step_ML_1_datasplit.R") 
source("script_machine_learning/step_ML_2_crossvalidation.R") 
source("script_machine_learning/step_ML_3_logreg.R") 






# execute_RMarkdown

render(paste0(memoria_dir, "ML_COVID_Memoria.Rmd"), c("html_document", "pdf_document"), output_dir = output_dir)



