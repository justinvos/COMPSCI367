require("gRbase", lib="~/app/R/lib")
require("gRain", lib="~/app/R/lib")

# Gets all of the values in the domain of the given variable
getVarDomain <- function(var) {
	isDom = domain[,"Variable"] == var
	return(domain[isDom, "Domain"])
}

# Gets all of the parents in the dependencies of the given variable
getVarDep <- function(var) {
	isParent <- dependencies[,"Node"] == var
	return(dependencies[isParent, "Parent"])
}

# Gets a vector of all variables in the belief network
getVariables <- function() {
	vars <- c()
	for (var in domain[, "Variable"]) {
		if(!is.element(var, vars)) {
			vars <- c(vars, var)
		}
	}
	return(vars)
}

# Reads a csv file as a data frame
readDataFrame <- function(filepath, var) {
	return(read.csv(paste(filepath, var, ".CSV", sep=""), stringsAsFactors=FALSE))
}

# Builds a cptable from the given filepath, variable name, domain and dependencies data frames
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
		if(is.element(var, names(evidence))) { # skips variables that are in the evidence
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

# Gets all the column names of a data frame, except for the those given in the except vector
getVars <- function(df, except=c("Prob")) {
	cols <- colnames(df)
	for(var in except) {
		cols <- cols[cols != var]
	}
	return(cols)
}

multiply <- function(df1, df2, colname) {
	varDom <- getVarDomain(colname)
	for(val in varDom) {
		# Multiplies the probability of each value in the domain of the colname across the two tables
		df1[df1[colname] == val,"Prob"] <- df1[df1[colname] == val,"Prob"] * df2[df2[colname] == val,"Prob"]
	}
	return(df1)
}

sumOut <- function(df_input, colname) {
	df_output <- data.frame()
	vars <- getVars(df_input, except=c(colname, "Prob"))

	# Splitting by all variables except colname and prob, giving me multiple seperate parts
	splitList <- list()
	for(var in vars) {
		splitList[[length(splitList) + 1]] <- df_input[,var]
	}
	parts <- split(df_input, splitList)

	# Each part is individually summed using the aggregate and sum function, and then rbinded together into the data frame df_ouput
	for(part in parts) {
		part <- as.data.frame(part)
		names(part) <- c(getVars(df_input, except=c()))

		groupByList <- list()
		for(var in vars) {
			groupByList[[length(groupByList) + 1]] <- part[,var]
		}
		names(groupByList) <- vars

		df_output <- rbind(df_output, aggregate(part[,"Prob"], by=groupByList, FUN=sum))
	}

	names(df_output) <- getVars(df_input, except=c(colname))
	return(df_output)
}

variableElimination <- function(filepath) {
	# Reading in the domain data frame
	domain <<- read.csv(paste(filepath, "domain.CSV", sep=""), stringsAsFactors=FALSE)

	# Reading in all of the data frames
	L1_lit <- readDataFrame(filepath, "L1_lit")
	L1_st <- readDataFrame(filepath, "L1_st")
	W0 <- readDataFrame(filepath, "W0")
	W1 <- readDataFrame(filepath, "W1")
	W2 <- readDataFrame(filepath, "W2")
	W3 <- readDataFrame(filepath, "W3")
	S1_pos <- readDataFrame(filepath, "S1_pos")
	S1_st <- readDataFrame(filepath, "S1_st")
	S2_pos <- readDataFrame(filepath, "S2_pos")
	S2_st <- readDataFrame(filepath, "S2_st")
	Outside_power <- readDataFrame(filepath, "Outside_power")
	Cb1_st <- readDataFrame(filepath, "Cb1_st")

	# Setting evidence for S1_st="ok"
	S1_st[,"Prob"] <- 0
	S1_st[S1_st$S1_st == "ok","Prob"] <- 1

	# Setting evidence for S2_st="ok"
	S2_st[,"Prob"] <- 0
	S2_st[S2_st$S2_st == "ok","Prob"] <- 1

	# Setting evidence for L1_st="ok"
	L1_st[,"Prob"] <- 0
	L1_st[L1_st$L1_st == "ok","Prob"] <- 1

	# Setting evidence for W0="live"
	W0[,"Prob"] <- 0
	W0[W0$W0 == "live","Prob"] <- 1

	# Setting evidence for W1="live"
	W1[,"Prob"] <- 0
	W1[W1$W1 == "live","Prob"] <- 1

	# Setting evidence for W2="live"
	W2[,"Prob"] <- 0
	W2[W2$W2 == "live","Prob"] <- 1

	# Setting evidence for W3="live"
	W3[,"Prob"] <- 0
	W3[W3$W3 == "live","Prob"] <- 1


	# Eliminating variables in W3
	W3 <- multiply(W3, Outside_power, "Outside_power")
	W3 <- sumOut(W3, "Outside_power")

	W3 <- multiply(W3, Cb1_st, "Cb1_st")
	W3 <- sumOut(W3, "Cb1_st")

	# Eliminating variables in W2
	W2 <- multiply(W2, S1_st, "S1_st")
	W2 <- sumOut(W2, "S1_st")

	W2 <- multiply(W2, S1_pos, "S1_pos")
	W2 <- sumOut(W2, "S1_pos")

	W2 <- multiply(W2, W3, "W3")
	W2 <- sumOut(W2, "W3")

	# Eliminating variables in W1
	W1 <- multiply(W1, S1_st, "S1_st")
	W1 <- sumOut(W1, "S1_st")

	W1 <- multiply(W1, S1_pos, "S1_pos")
	W1 <- sumOut(W1, "S1_pos")

	W1 <- multiply(W1, W3, "W3")
	W1 <- sumOut(W1, "W3")


	# Eliminating variables in W0
	W0 <- multiply(W0, S2_st, "S2_st")
	W0 <- sumOut(W0, "S2_st")

	W0 <- multiply(W0, S2_pos, "S2_pos")
	W0 <- sumOut(W0, "S2_pos")

	W0 <- multiply(W0, W2, "W2")
	W0 <- sumOut(W0, "W2")

	W0 <- multiply(W0, W1, "W1")
	W0 <- sumOut(W0, "W1")

	# Eliminating variables in L1_lit
	L1_lit <- multiply(L1_lit, L1_st, "L1_st")
	L1_lit <- sumOut(L1_lit, "L1_st")

	L1_lit <- multiply(L1_lit, W0, "W0")
	L1_lit <- sumOut(L1_lit, "W0")

	probL1_litFalse = L1_lit[L1_lit["L1_lit"] == "false","Prob"]

	print(paste("P(L1_lit = false|evidence) =", probL1_litFalse))
}

variableElimination("./DATA/")
