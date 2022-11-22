rm(list=ls(all.names=TRUE))

#set path libraries functions
if (!require("rstudioapi")) install.packages("rstudioapi")
projectFolder <- setwd(dirname(rstudioapi::getSourceEditorContext()$path))

source(paste0(projectFolder, "/pack_param_funct/path.R"))
source(paste0(projectFolder, "/pack_param_funct/packages.R"))
#source(paste0(projectFolder, "/pack_param_funct/functions.R"))


dir.create(Outputfolder, showWarnings = FALSE)








# script_machine_learning

source("script_machine_learning/XXX.R") 






# execute_RMarkdown

if(check2) system.time(render("Report_2_1.Rmd", output_dir = output_dir))