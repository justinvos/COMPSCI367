require("gRbase", lib="~/app/R/lib")
require("gRain", lib="~/app/R/lib")

getVarDomain <- function(var) {
	isDom = domain[,"Variable"] == var
	return(domain[isDom, "Domain"])
}

getVarDep <- function(var) {
	isParent <- dependencies[,"Node"] == var
	return(dependencies[isParent, "Parent"])
}

getVariables <- function() {
	vars <- c()
	for (var in domain[, "Variable"]) {
		if(!is.element(var, vars)) {
			vars <- c(vars, var)
		}
	}
	return(vars)
}

getCpt <- function(filepath, var, domain, dependencies) {
	d <- read.csv(paste(filepath, var, ".CSV", sep=""), stringsAsFactors=FALSE)
	varDom <- getVarDomain(var)
	varDep <- getVarDep(var)
	strDeps <- paste(varDep, collapse="+")
	strFormula <- paste("~", var, sep="")
	if(length(varDep) > 0) {
		strFormula <- paste(strFormula, "|", strDeps, sep="")
	}
	formula <- as.formula(strFormula)
	cpt <- cptable(formula, values=d[,"Prob"], levels=varDom)
	return(cpt)
}

genBSFromCSV <- function(filepath) {
	domain <<- read.csv(paste(filepath, "domain.CSV", sep=""), stringsAsFactors=FALSE)
	dependencies <<- read.csv(paste(filepath, "dependencies.CSV", sep=""), stringsAsFactors=FALSE)
	cptTables = list()
	vars <- getVariables()
	for(var in vars) {
		cpt <- getCpt(filepath, var, domain, dependencies)
		cptTables[[var]] <- cpt
	}
	net <<- grain(compileCPT(cptTables))
	return(net)
}

query <- function(list_h, list_e=list()) {
	tempNet = net
	if(length(list_e) > 0) {
		tempNet <-setEvidence(net, evidence=list_e)
	}
	return(querygrain(tempNet, nodes=unlist(list_h), type="joint"))
}

queryReason <- function(list_evidence) {
	vars <- getVariables()

	maxVar <- ""
	maxVal <- ""
	maxProb <- 0
	for(var in vars) {
		if(is.element(var, names(evidence))) { # skips variables that are in evidence
			next
		} else {
			varPosterior <- query(list(var), evidence)

			for(val in names(varPosterior)) {
				valPosterior <- varPosterior[val]
				if(valPosterior > maxProb) {
					maxVar <- var
					maxVal <- val
					maxProb <- valPosterior
				}
			}
		}
	}

	return(list("variable"=maxVar, "value"=maxVal, "prob"=as.numeric(maxProb)))
}
