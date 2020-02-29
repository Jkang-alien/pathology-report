library(DBI)
library(readr)
library(RSQLite)
library(tidyverse)

db <- dbConnect(SQLite(), dbname="report.sqlite", )
dbCreateTable(db, "Breast,Invasive", fields = c(histology = "TEXT",
                                                LN = "TEXT",
                                                size_l = "FLOAT"))
dbCreateTable(db, "Breast,DCIS", fields = c(histology = "TEXT",
                                                size_l = "FLOAT"))
dbRemoveTable(db, "Breast,Invasive")

dbReadTable(db, "Breast,DCIS")
          
          
          
          