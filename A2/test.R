source("A2.R")

net1 <- setEvidence(net, evidence=list(OutsidePower="dead"))

querygrain(net1, nodes=c("W5"))
