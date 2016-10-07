require("gRbase", lib="~/app/R/lib")
require("gRain", lib="~/app/R/lib")

getVariables <- function(domain) {
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
	isDom = domain[,"Variable"] == var
	varDom = domain[isDom, "Domain"]
	isParent <- dependencies[,"Node"] == var
	varDep <- dependencies[isParent, "Parent"]
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
	domain <- read.csv(paste(filepath, "domain.CSV", sep=""), stringsAsFactors=FALSE)
	dependencies <- read.csv(paste(filepath, "dependencies.CSV", sep=""), stringsAsFactors=FALSE)
	cptTables = list()
	vars <- getVariables(domain)
	for(var in vars) {
		cpt <- getCpt(filepath, var, domain, dependencies)
		cptTables[[var]] <- cpt
	}
	net <<- grain(compileCPT(cptTables))
	return(net)
}

query <- function(list_h, list_e) {
	prior <- querygrain(net, nodes=unlist(list_h), type="joint")
	netWithEvidence <-setEvidence(net, evidence=list_e)
	likelihood <- querygrain(netWithEvidence, nodes=unlist(list_h), type="joint")
	probEvidence <- pEvidence(netWithEvidence)
	post <- (prior * likelihood) / probEvidence
	return(post)
}
