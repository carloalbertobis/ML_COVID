library(readxl)
data_covid <- read_excel(paste0(data_EIN_dir, "dataset.xlsx"))

variabili <- colnames(data_covid)

variabili <- matrix(variabili, ncol = 3)
variabili <- as.data.frame(variabili)

saveRDS(variabili, file = paste0(data_EIN_dir,"variabili.rds"))


