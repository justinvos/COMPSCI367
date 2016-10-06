require("gRbase", lib="~/app/R/lib")
require("gRain", lib="~/app/R/lib")


getDomain <- function(needleVar) {
	dom <- c()
	d <- read.csv("./DATA/domain.CSV", stringsAsFactors=FALSE)

	row <- 1
	for (var in d[, "Variable"]) {
		#print(var)
		if(var == needleVar) {
			dom <- c(dom, d[row, "Domain"])
		}
		row <- row + 1
	}
	return(dom)
}


cptOutsidePower <- cptable(~OutsidePower, values=c(50,50), levels=getDomain("Outside_power"))
cptW5 <- cptable(~W5|OutsidePower, values=c(1,0,0,1), levels=c("live", "dead"))
#pL1_lit <- cptable(~L1_lit|W0+L1_st, values=c(1,0,0,1,0.5,0.5,0,1,0,1,0,1), levels=getDomain("L1_lit"))

cptlist <- compileCPT(list(cptOutsidePower, cptW5))

net <- grain(cptlist)
