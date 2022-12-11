#fwrite(File, file = paste0(Outputfolder, "/", i), sep = Delimiter, col.names = T, row.names = F, na = "", append = F)


data_covid$outcome
test_data$outcome
train_data$outcome

levels(train_data$outcome) <- c("Nosurvivor","Survivor")
levels(test_data$outcome) <- c("Nosurvivor","Survivor")



############################ SAMPLE
data_covid <- fread(paste0(data_sample_dir, "datasetC.csv"), stringsAsFactors = T)
data_covid <- na.omit(data_covid)

save(data_covid, file = paste0(data_sample_dir, "data_covid_nf.RData"))
saveRDS(data_covid, file = paste0(data_sample_dir,"data_covid_nf.rds"))
############################ SAMPLE NF
data_covid <- fread(paste0(data_sample_dir, "datasetC.csv"), stringsAsFactors = F)
data_covid <- na.omit(data_covid)

save(data_covid, file = paste0(data_sample_dir, "data_covid_nf.RData"))
saveRDS(data_covid, file = paste0(data_sample_dir,"data_covid_nf.rds"))
########################## EINSTEIN
library(readxl)
data_covid <- read_excel(paste0(data_EIN_dir, "dataset.xlsx"))
data_covid <- data_covid[,c(1:20)]
data_covid <- na.omit(data_covid)

save(data_covid, file = paste0(data_sample_dir, "data_covid.RData"))
saveRDS(data_covid, file = paste0(data_sample_dir,"data_covid.rds"))
###################################


source(paste0(projectFolder, "/pack_param_funct/load_fit.R"))
source(paste0(projectFolder, "/pack_param_funct/load_roc.R"))
source(paste0(projectFolder, "/pack_param_funct/load_conf_matrix.R"))
















save(data_covid, file = paste0(data_sample_dir, "data_covid.RData"))
saveRDS(data_covid, file = paste0(data_sample_dir,"data_covid.rds"))





data_covid <- readRDS(paste0(data_sample_dir,"data_covid.rds"))


load(paste0(data_sample_dir, "data_covid.RData"))

data_covid$outcome<-recode_factor(data_covid$outcome, "1"="Survivor", "0"="Non-survivor")
