
# load data
load(paste0(intermediate_file_dir, "data_covid.RData"))
#data_covid <- readRDS(paste0(intermediate_file_dir,"data_covid.rds"))

# data spit percent
percent <- 0.7

#train
set.seed(123)
train_list<- createDataPartition(data_covid$outcome, p = percent, list = FALSE)
train_data<- data_covid[train_list,]

#test
test_data<- data_covid[-train_list,]

# Clean and save
save(train_data, file = paste0(intermediate_file_dir, "train_data.RData"))
save(test_data, file = paste0(intermediate_file_dir, "test_data.RData"))

saveRDS(train_data, file = paste0(intermediate_file_dir,"train_data.rds"))
saveRDS(test_data, file = paste0(intermediate_file_dir,"test_data.rds"))

rm(train_list, data_covid, train_data, test_data, percent)
