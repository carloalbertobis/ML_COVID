#fwrite(File, file = paste0(Outputfolder, "/", i), sep = Delimiter, col.names = T, row.names = F, na = "", append = F)
sample <- fread(paste0("H:/Mi unidad/UOC Bio/#TFM/Scripts/TFM_UOC-main/data/datasetA.csv"), stringsAsFactors = F)
save(data_covid, file = paste0(data_sample_dir, "data_covid.RData"))
saveRDS(data_covid, file = paste0(data_sample_dir,"data_covid.rds"))

load(paste0(data_sample_dir, "data_covid.RData"))

data_covid <- na.omit(data_covid)

data_covid <- readRDS(paste0(data_sample_dir,"data_covid.rds"))





