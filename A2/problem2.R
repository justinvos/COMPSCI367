source("problem1.R")

filepath = "./DS1/"

domain <<- read.csv(paste(filepath, "domain.CSV", sep=""), stringsAsFactors=FALSE)
dependencies <<- read.csv(paste(filepath, "dependencies.CSV", sep=""), stringsAsFactors=FALSE)


net2 <- genBSFromCSV(filepath)

evidence = list("S1_detect"="true")
query(list("E1_thrusts"), evidence)

evidence = list("S1_detect"="true", "S2_detect"="true", "S3_detect"="true")
query(list("E1_thrusts"), evidence)

evidence = list("V5_open"="false", "V8_open"="false", "S2_detect"="true")
query(list("E1_thrusts"), evidence)
