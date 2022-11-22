if (!require(survival)) {
  install.packages("survival")
}
suppressPackageStartupMessages(library(survival))

if (!require(dplyr)) {
  install.packages("dplyr")
}
suppressPackageStartupMessages(library(dplyr))

if (!require(rmarkdown)) {
  install.packages("rmarkdown")
}
suppressPackageStartupMessages(library(rmarkdown))