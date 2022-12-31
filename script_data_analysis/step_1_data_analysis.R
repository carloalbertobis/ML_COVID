data_covid_ein <- readRDS(paste0(intermediate_file_dir,"data_covid_ein.rds"))
data_covid_ein_lite <- readRDS(paste0(intermediate_file_dir,"data_covid_ein_lite.rds"))
data_covid_ein_no_IMP <- readRDS(paste0(intermediate_file_dir,"data_covid_ein_no_IMP.rds"))


#### quality data
plot_intro_ein_lite <- plot_intro(data_covid_ein_lite)
saveRDS(plot_intro_ein_lite, file = paste0(data_EIN_dir,"plot_intro_ein_lite.rds"))
plot_intro_ein<- plot_intro(data_covid_ein)
saveRDS(plot_intro_ein, file = paste0(data_EIN_dir,"plot_intro_ein.rds"))
data_covid_ein_no_IMP<- plot_intro(data_covid_ein)
saveRDS(data_covid_ein_no_IMP, file = paste0(data_EIN_dir,"data_covid_ein_no_IMP.rds"))

#### my controls
my_controls <- tableby.control(
  test = TRUE,
  total = TRUE,
  numeric.test = "kwt", cat.test = "chisq",
  numeric.stats = c("meansd", "medianq1q3", "range", "Nmiss"),
  cat.stats = c("countpct", "Nmiss"),
  stats.labels = list(
    meansd = "Mean (SD)",
    medianq1q3 = "Median (Q1, Q3)",
    range = "Min - Max",
    Nmiss = "Missing"
  )
)


### table data
table_ein_lite <- summary(tableby(cov_result ~ ., control = my_controls, test = FALSE, data = data_covid_ein_lite[,c(-1,-2)]), text = TRUE)
saveRDS(table_ein_lite, file = paste0(data_EIN_dir,"table_ein_lite.rds"))
table_ein <- summary(tableby(cov_result ~ ., control = my_controls, test = FALSE, data = data_covid_ein[,c(-1,-2)]), text = TRUE)
saveRDS(table_ein, file = paste0(data_EIN_dir,"table_ein.rds"))


###### covid vs age
table_covid_vs_age_lite <- summary(tableby(cov_result ~ age_quantile, data = data_covid_ein_lite, test = FALSE, total = TRUE), text = TRUE)
table_covid_vs_age <- summary(tableby(cov_result ~ age_quantile, data = data_covid_ein, test = FALSE, total = TRUE), text = TRUE)
saveRDS(table_covid_vs_age_lite, file = paste0(data_EIN_dir,"table_covid_vs_age_lite.rds"))
saveRDS(table_covid_vs_age, file = paste0(data_EIN_dir,"table_covid_vs_age.rds"))


##### severidad vs age
table_ser_vs_age_lite <- summary(tableby(care ~ age_quantile, data = data_covid_ein_lite, test = FALSE, total = TRUE), text = TRUE)
table_sev_vs_age <- summary(tableby(care ~ age_quantile, data = data_covid_ein, test = FALSE, total = TRUE), text = TRUE)
saveRDS(table_ser_vs_age_lite, file = paste0(data_EIN_dir,"table_sev_vs_age_lite.rds"))
saveRDS(table_sev_vs_age, file = paste0(data_EIN_dir,"table_sev_vs_age.rds"))





