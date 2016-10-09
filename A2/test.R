source("problem1.R")

genBSFromCSV("./DATA/")


vars <- getVariables()

evidence <- list("L1_lit"="false", "L2_lit"="false")
evidenceProb <- pEvidence(setEvidence(net, evidence=evidence))

query(list("W0"), evidence)

maxVar <- ""
maxVal <- ""
maxProb <- 0
for(var in vars) {
	if(is.element(var, names(evidence)) || startsWith(var, "W") || startsWith(var, "P")) { # skips variables that are in evidence or are wires or power outlets
		next
	} else {
		varPosterior <- query(list(var), evidence)
		varPrior <- query(list(var), list())

		for(val in names(varPosterior)) {
			valPosterior <- varPosterior[val]
			valPrior <- varPrior[val]

			valLikelihood <- (valPosterior * evidenceProb) / valPrior[val]

			valPriorLikelihood <- valPrior * valLikelihood

			print(var)
			print(val)
			print(valPriorLikelihood)

			#if(valLikelihood > 0.9) { # this checks if it is a cause of L1_lit="false" and L2_lit="false"
			#print("#######################################################3")
			if(valPriorLikelihood > maxProb) {
				maxVar <- var
				maxVal <- val
				maxProb <- valPriorLikelihood


			}
			#}
		}
	}
}

print(maxVar)
print(maxVal)
print(maxProb)
