library(readxl)
data_covid <- read_excel(paste0(data_EIN_dir, "dataset.xlsx"))

treat_names <- c('patient_id' , 'age_quantile' , 'cov_result' , 'regular_ward', 
                 'semi_intensive' , 'intensive_care_unit' , 'hematocrit' , 'hemoglobin' , 
                 'platelets' , 'mean_platelet_volume' , 'red_blood_cells' , 'Lymphocytes' , 
                 'mean_corp_hemo_conc' , 
                 'leukocytes' , 'basophils' , 'mean_corp_hemoglobin' , 'eosinophils' , 
                 'mean_corp_volume' , 'monocytes' , 'RDW' , 'serum_glucose' , 
                 'respiratory_syncytial_virus' , 'influenza_A' , 'influenza_B' , 'parainfluenza_1' ,
                 'coronavirusNL63' , 'rhinovirus_enterovirus' , 'mycoplasma_pneumoniae' , 
                 'coronavirus_HKU1' , 'parainfluenza_3' , 'chlamydophila_pneumoniae' , 
                 'adenovirus' , 'parainfluenza_4' , 'coronavirus229E' , 'coronavirusOC43' , 'inf_A_H1N1_2009' , 'bordetella_pertussis' , 'metapneumovirus' , 'parainfluenza_2' , 'neutrophils' , 
                 'urea' , 'C_reative_protein' , 'creatinine' , 'potassium' , 'sodium' , 'Influenza_B_rapid_test' , 'Influenza_A_rapid_test' , 'alanine_transaminase' , 'aspartate_transaminase' , 'gamma_glutamyltransferase ' , 'total_bilirubin' , 'direct_bilirubin' , 'indirect_bilirubin' , 'alkaline_phosphatase' , 'Ionize_calcium ' , 'Strepto_A' , 'magnesium' , 'pCO2 (venous blood gas analysis)' , 'Hb saturation (venous blood gas analysis)' , 'Base excess (venous blood gas analysis)' , 'pO2 (venous blood gas analysis)' , 'Fio2 (venous blood gas analysis)' , 'Total CO2 (venous blood gas analysis)' , 'pH (venous blood gas analysis)' , 'HCO3 (venous blood gas analysis)' , 'Rods #' , 'Segmented' , 'Promyelocytes' , 'Metamyelocytes' , 'Myelocytes' , 'Myeloblasts' , 'Urine - Esterase' , 'Urine - Aspect' , 'Urine - pH' , 'Urine - Hemoglobin' , 'Urine - Bile pigments' , 'Urine - Ketone Bodies' , 'Urine - Nitrite' , 'Urine - Density' , 'Urine - Urobilinogen' , 'Urine - Protein' , 'Urine - Sugar' , 'Urine - Leukocytes' , 'Urine - Crystals' , 'Urine - Red blood cells' , 'Urine - Hyaline cylinders' , 'Urine - Granular cylinders' , 'Urine - Yeasts' , 'Urine - Color' , 'Partial thromboplastin time (PTT) ' , 'Relationship (Patient/Normal)' , 'International normalized ratio (INR)' , 'Lactic Dehydrogenase' , 'Prothrombin time (PT), Activity' , 'Vitamin B12' , 'Creatine phosphokinase (CPK) ' , 'Ferritin' , 'Arterial Lactic Acid' , 'Lipase dosage' , 'D-Dimer' , 'Albumin' , 'Hb saturation (arterial blood gases)' , 'pCO2 (arterial blood gas analysis)' , 'Base excess (arterial blood gas analysis)' , 'pH (arterial blood gas analysis)' , 'Total CO2 (arterial blood gas analysis)' , 'HCO3 (arterial blood gas analysis)' , 'pO2 (arterial blood gas analysis)' , 'Arteiral Fio2' , 'Phosphor' , 'ctO2 (arterial blood gas analysis)')

names(data_covid) <- treat_names

data_covid <- data_covid %>% 
  mutate(
    care = ifelse(regular_ward == 1, 'regular_ward',
                  ifelse(semi_intensive == 1, 'semi_intensive',
                         ifelse(intensive_care_unit == 1, 'intensive_care_unit','discharged'))),
    care = factor(care, levels = c('discharged','regular_ward','semi_intensive','intensive_care_unit'))
  )

data_covid <- setDT(data_covid)
data_covid[, age_quantile:=as.factor(age_quantile)]
data_covid[, cov_result:=as.factor(cov_result)]
data_covid <- data_covid[,-c(4:6)]

# variabili
variabili <- colnames(data_covid[,-1])
variabili <-matrix(variabili, ncol=3, byrow = FALSE)
saveRDS(variabili, file = paste0(data_EIN_dir,"variabili.rds"))

### lite
data_covid_2_20 <- data_covid[,c(2:17,109)]
data_covid_2_20 <- na.omit(data_covid_2_20)
saveRDS(data_covid_2_20, file = paste0(data_EIN_dir,"data_covid_ein_lite.rds"))

########
delete.na <- function(DF, n=0, is.row=TRUE) {
  if(is.row){
    DF[rowSums(!is.na(DF)) >= n,]
  }else{
    DF[,colSums(!is.na(DF)) >= n]
  }}
######
data <- data_covid
data.size<-nrow(data)
not.na.pct <- 0.05
data <- as.data.frame(data)
data[data=='Não Realizado'] <- NA
data[data=='not_done'] <- NA

data <- delete.na(data, n = data.size * not.na.pct, is.row = FALSE)

#data[, Patient.ID := NULL]
data[data=='<1000'] <- 500

#data[, Urine...Leukocytes:=as.numeric(Urine...Leukocytes)]
#data[, Lipase.dosage:=as.factor(Lipase.dosage)]
data <- setDT(data)
changeCols <- colnames(data)[which(as.vector(data[,lapply(.SD, class)]) == "character")]
data[, (changeCols[-1]) := lapply(.SD, as.factor), .SDcols = changeCols[-1]] 

data[, 'parainfluenza_2' := NULL]

saveRDS(data, file = paste0(data_EIN_dir,"data_covid_ein_no_IMP.rds"))

set.seed(123)
data <- rfImpute(care ~ ., data, iter=100, ntree=500)

saveRDS(data, file = paste0(data_EIN_dir,"data_covid_ein.rds"))



