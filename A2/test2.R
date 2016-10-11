source("problem1.R")

genBSFromCSV("./DATA/")


evidence <- list("L1_lit"="false", "L2_lit"="false")
queryReason(evidence)


#query(list("W0"="dead", "W1"="dead"), evidence)
