library(DBI)
library(readr)
library(RSQLite)
library(tidyverse)

db <- dbConnect(SQLite(), dbname="report.sqlite", )
dbCreateTable(db, "Breast,Invasive", fields = c(ID = "TEXT",
                                                side = "TEXT",
                                                surgery = "TEXT",
                                                histology = "TEXT",
                                                LN = "TEXT",
                                                size_l = "FLOAT"))
dbCreateTable(db, "Breast,DCIS", fields = c(ID = "ID",
                                            side = "TEXT",
                                            surgery = "TEXT",
                                            histology = "TEXT",
                                            size_l = "FLOAT"))
dbRemoveTable(db, "Breast,Invasive")
dbRemoveTable(db, "Breast,DCIS")

dbReadTable(db, "Breast,Invasive")
dbReadTable(db, "Breast,DCIS")
          
          
          
          