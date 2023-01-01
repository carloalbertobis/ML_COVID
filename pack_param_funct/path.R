
list <- c("log_reg", "random_forest", "svm", "naive_bayes", "knn", "ann", "glmnet")
list_alg <- c("glm", "rm", "svm", "nb", "knn", "ann", "glmnet")

if (!dir.exists("output")){  dir.create("output")}
if (!dir.exists("data_sample")){  dir.create("data_sample")}
if (!dir.exists("intermediate_file")){  dir.create("intermediate_file")}
if (!dir.exists("output_einstein")){  dir.create("output_einstein")}
if (!dir.exists("data_einstein")){  dir.create("data_einstein")}
if (!dir.exists("data")){  dir.create("data")}

for (i in list){
    print(i)
  if (!dir.exists(paste0("intermediate_file/",i))){ dir.create(paste0("intermediate_file/",i))    }
  if (!dir.exists(paste0("data_sample/",i))){  dir.create(paste0("data_sample/",i))}
  if (!dir.exists(paste0("data_einstein/",i))){  dir.create(paste0("data_einstein/",i))}
}

output_dir <- paste0(projectFolder, "/output/")
memoria_dir <- paste0(projectFolder, "/memoria/")
intermediate_file_dir <- paste0(projectFolder, "/intermediate_file/")
scriptml_dir <- paste0(projectFolder, "/script_machine_learning/")
scriptdata_dir <- paste0(projectFolder, "/script_data_analysis/")
ppf_dir <- paste0(projectFolder, "/pack_param_funct/")

# sample ein
if (sample == "sample"){
  data_sample_dir <- paste0(projectFolder, "/data_sample/")
  output_sample_dir <- paste0(projectFolder, "/output_sample/")
  intermediate_file_dir <- data_sample_dir
  output_dir <- output_sample_dir
  }

if (sample == "ein"){
  data_EIN_dir <- paste0(projectFolder, "/data_einstein/")
  data_EIN_fit <- paste0(projectFolder, "/data_einstein/fit/")
  output_EIN_dir <- paste0(projectFolder, "/output_einstein/")
  intermediate_file_dir <- data_EIN_dir
  output_dir <- output_EIN_dir
}

dir_list <- c()
for (i in list){
  print(paste0(intermediate_file_dir,i,"/"))
  dir_list <- append(dir_list, paste0(intermediate_file_dir,i,"/"))
  assign(paste0(i,"_dir"), paste0(intermediate_file_dir,i,"/"))
}

rm(i)
       
       
       