library(DBI)
library(readr)
library(RSQLite)
library(tidyverse)

data.frame(histology = , LN, size_l)
db <- dbConnect(SQLite(), dbname="report.sqlite", )
dbCreateTable(db, "Breast,Invasive", fields = c(histology = "TEXT",
                                                LN = "TEXT",
                                                size_l = "FLOAT"))
dbRemoveTable(db, "Breast,Invasive")

dbReadTable(db, "Breast,Invasive")
          
          
          
          