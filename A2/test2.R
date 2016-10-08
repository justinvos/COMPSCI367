source("A2.R")

genBSFromCSV("./DATA/")

evidence <- list("L1_lit"="false", "L2_lit"="false")
queryReason(evidence)
