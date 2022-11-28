#fwrite(File, file = paste0(Outputfolder, "/", i), sep = Delimiter, col.names = T, row.names = F, na = "", append = F)
data_covid <- fread(paste0("C:/Users/carlo/Google Drive (charlieabees@gmail.com)/UOC Bio/#TFM/Scripts/TFM_UOC-main/data/datasetC.csv"), stringsAsFactors = T)
data_covid <- na.omit(data_covid)



save(data_covid, file = paste0(data_sample_dir, "data_covid.RData"))
saveRDS(data_covid, file = paste0(data_sample_dir,"data_covid.rds"))





data_covid <- readRDS(paste0(data_sample_dir,"data_covid.rds"))


load(paste0(data_sample_dir, "data_covid.RData"))

data_covid$outcome<-recode_factor(data_covid$outcome, "1"="Survivor", "0"="Non-survivor")
