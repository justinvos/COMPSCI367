# QUESTION 2(a)

source("problem1.R")

filepath = "./data/"

domain <<- read.csv(paste(filepath, "domain.CSV", sep=""), stringsAsFactors=FALSE)
dependencies <<- read.csv(paste(filepath, "dependencies.CSV", sep=""), stringsAsFactors=FALSE)

genBSFromCSV(filepath)


# QUESTION 2(c)

evidence = list("S1_detect"="true")
query(list("E1_thrusts"="true"), evidence)["true"]

evidence = list("S1_detect"="true", "S2_detect"="true", "S3_detect"="true")
query(list("E1_thrusts"="true"), evidence)["true"]

evidence = list("V5_open"="false", "V8_open"="false", "S2_detect"="true")
query(list("E1_thrusts"="true"), evidence)["true"]
