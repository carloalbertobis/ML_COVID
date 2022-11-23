
if (!dir.exists("output")){  dir.create("output")}
if (!dir.exists("data_sample")){  dir.create("data_sample")}
if (!dir.exists("intermediate_file")){  dir.create("intermediate_file")}

output_dir <- paste0(projectFolder, "/output/")
memoria_dir <- paste0(projectFolder, "/memoria/")
intermediate_file_dir <- paste0(projectFolder, "/intermediate_file/")
scriptml_dir <- paste0(projectFolder, "/script_machine_learning/")
scriptdata_dir <- paste0(projectFolder, "/script_data_analysis/")
ppf_dir <- paste0(projectFolder, "/pack_param_funct/")
data_sample_dir <- paste0(projectFolder, "/sample_file/")

if (sample == TRUE){intermediate_file_dir <- data_sample_dir}

