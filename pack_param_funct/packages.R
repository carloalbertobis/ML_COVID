if (!require(data.table)) {install.packages("data.table")}
suppressPackageStartupMessages(library(data.table, quietly = TRUE))

if (!require(survival)) {install.packages("survival")}
suppressPackageStartupMessages(library(survival, quietly = TRUE))

if (!require(dplyr)) {install.packages("dplyr")}
suppressPackageStartupMessages(library(dplyr, quietly = TRUE))

if (!require(rmarkdown)) {install.packages("rmarkdown")}
suppressPackageStartupMessages(library(rmarkdown, quietly = TRUE))

if (!require(caret)) {install.packages("caret")}
suppressPackageStartupMessages(library(caret, quietly = TRUE))

if (!require(ggplot2)) {install.packages("ggplot2")}
suppressPackageStartupMessages(library(ggplot2, quietly = TRUE))

if (!require(tidyverse)) {install.packages("tidyverse")}
suppressPackageStartupMessages(library(tidyverse, quietly = TRUE))

if (!require(gmodels)) {install.packages("gmodels")}
suppressPackageStartupMessages(library(gmodels, quietly = TRUE))

if (!require(MASS)) {install.packages("MASS")}
suppressPackageStartupMessages(library(MASS, quietly = TRUE))

if (!require(MASS)) {install.packages("MASS")}
suppressPackageStartupMessages(library(MASS, quietly = TRUE))

if (!require(gmodels)) {install.packages("gmodels")}
suppressPackageStartupMessages(library(gmodels, quietly = TRUE))

if (!require(kernlab)) {install.packages("kernlab")}
suppressPackageStartupMessages(library(kernlab, quietly = TRUE))

if (!require(knitr)) {install.packages("knitr")}
suppressPackageStartupMessages(library(knitr, quietly = TRUE))

if (!require(DataExplorer)) {install.packages("DataExplorer")}
suppressPackageStartupMessages(library(DataExplorer, quietly = TRUE))

if (!require(pROC)) {install.packages("pROC")}
suppressPackageStartupMessages(library(pROC, quietly = TRUE))

if (!require(arsenal)) {install.packages("arsenal")}
suppressPackageStartupMessages(library(arsenal, quietly = TRUE))

if (!require(randomForest)) {install.packages("randomForest")}
suppressPackageStartupMessages(library(randomForest, quietly = TRUE))

if (!require(glmnet)) {install.packages("glmnet")}
suppressPackageStartupMessages(library(glmnet, quietly = TRUE))

if (!require(e1071)) {install.packages("e1071")}
suppressPackageStartupMessages(library(e1071, quietly = TRUE))

if (!require(klaR)) {install.packages("klaR")}
suppressPackageStartupMessages(library(klaR, quietly = TRUE))

if (!require(readxl)) {install.packages("readxl")}
suppressPackageStartupMessages(library(readxl, quietly = TRUE))

if (!require(xgboost)) {install.packages("xgboost")}
suppressPackageStartupMessages(library(xgboost, quietly = TRUE))

if (!require(parallel)) {install.packages("parallel")}
suppressPackageStartupMessages(library(parallel, quietly = TRUE))

if (!require(parallelMap)) {install.packages("parallelMap")}
suppressPackageStartupMessages(library(parallelMap, quietly = TRUE))
parallelStartSocket(cpus = detectCores())
