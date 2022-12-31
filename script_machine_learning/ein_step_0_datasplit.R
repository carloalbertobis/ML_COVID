data_covid_ein <- readRDS(paste0(intermediate_file_dir,"data_covid_ein.rds"))
data_covid_ein_lite <- readRDS(paste0(intermediate_file_dir,"data_covid_ein_lite.rds"))

# data spit percent
percent <- 0.7

# split
set.seed(123)
train_list<- createDataPartition(data_covid_ein$cov_result, p = percent, list = FALSE)
train_data<- data_covid_ein[train_list,]
test_data<- data_covid_ein[-train_list,]
saveRDS(train_data, file = paste0(intermediate_file_dir,"train_data_ein.rds"))
saveRDS(test_data, file = paste0(intermediate_file_dir,"test_data_ein.rds"))

rm(train_list, data_covid_ein, train_data, test_data)

# split
set.seed(123)
train_list<- createDataPartition(data_covid_ein_lite$cov_result, p = percent, list = FALSE)
train_data<- data_covid_ein_lite[train_list,]
test_data<- data_covid_ein_lite[-train_list,]
saveRDS(train_data, file = paste0(intermediate_file_dir,"train_data_ein_lite.rds"))
saveRDS(test_data, file = paste0(intermediate_file_dir,"test_data_ein_lite.rds"))

rm(train_list, data_covid_ein_lite, train_data, test_data, percent)