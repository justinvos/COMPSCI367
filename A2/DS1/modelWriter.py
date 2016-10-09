class CSVFile:
	def __init__(self, file_name, has_col_heading=False, has_row_heading=False):
		self.file_name = file_name
		self.has_col_heading = has_col_heading
		self.has_row_heading = has_row_heading

	def read(self):
		read_file = open(self.file_name, "r")


		if self.has_row_heading:
			self.rows = {}
		else:
			self.rows = []

		row = 0
		for line in read_file:
			parts = line.split(",")



			row_heading = ""

			for col in range(len(parts)):
				value = parts[col].strip("\n")
				value = value.strip('"')

				if col == 0:
					if self.has_row_heading:
						row_heading = value
						if row_heading not in self.rows:
							self.rows[row_heading] = []
					else:
						self.rows[row] = []
				else:
					if self.has_row_heading:
						self.rows[row_heading] += [value]
					else:
						self.rows[row] += [value]

			row += 1

		read_file.close()
		return self.rows

	def write(self, rows):
		self.rows = rows

		write_file = open(self.file_name, "w")

		for parts in rows:
			values = []
			for part in parts:
				if isinstance(part, str):
					values += ['"' + part + '"']
				else:
					values += [str(part)]
			write_file.write(",".join(values) + "\n")
		write_file.close()

domain = {}

def getPossibilities(variables, domain):
	if len(variables) == 1:
		posibilities = []
		for value in domain[variables[0]]:
			posibilities += [[value]]
		return posibilities

	posibilities = []
	childPosibilities = getPossibilities(variables[1:], domain)
	for value in domain[variables[0]]:
		for childPosibility in childPosibilities:
			posibilities += [[value] + list(childPosibility)]

	return posibilities

def genDataProfile(name, probFunction):
	dependencies = CSVFile("dependencies.csv", has_row_heading=True).read()
	domain = CSVFile("domain.csv", has_row_heading=True).read()
	variables = [name]
	if name in dependencies:
		variables += dependencies[name]
	rows = [variables + ["Prob"]]
	posibilities = getPossibilities(variables, domain)

	for posibility in posibilities:
		prob = probFunction(variables, posibility)
		rows += [posibility + [prob]]

	csv_file = CSVFile(name + ".csv")
	csv_file.write(rows)

def openProb(variables, values):
	return 0.5

genDataProfile("V1_open", openProb)
genDataProfile("V2_open", openProb)
genDataProfile("V3_open", openProb)
genDataProfile("V4_open", openProb)
genDataProfile("V5_open", openProb)
genDataProfile("V6_open", openProb)
genDataProfile("V7_open", openProb)
genDataProfile("V8_open", openProb)
genDataProfile("V9_open", openProb)
genDataProfile("V10_open", openProb)
genDataProfile("V11_open", openProb)
genDataProfile("V12_open", openProb)
genDataProfile("V13_open", openProb)
genDataProfile("V14_open", openProb)
genDataProfile("V15_open", openProb)
genDataProfile("V16_open", openProb)

def stateProb(variables, values):
	selfState = values[0]

	prob = 0
	if selfState == "ok":
		prob = 0.7
	else:
		prob = 0.1

	return prob

genDataProfile("V1_st", stateProb)
genDataProfile("V2_st", stateProb)
genDataProfile("V3_st", stateProb)
genDataProfile("V4_st", stateProb)
genDataProfile("V5_st", stateProb)
genDataProfile("V6_st", stateProb)
genDataProfile("V7_st", stateProb)
genDataProfile("V8_st", stateProb)
genDataProfile("V9_st", stateProb)
genDataProfile("V10_st", stateProb)
genDataProfile("V11_st", stateProb)
genDataProfile("V12_st", stateProb)
genDataProfile("V13_st", stateProb)
genDataProfile("V14_st", stateProb)
genDataProfile("V15_st", stateProb)
genDataProfile("V16_st", stateProb)


def level1_flowProb(variables, values):
	selfFlow = values[0]
	selfOpen = values[1]
	selfState = values[2]

	prob = 0
	if selfOpen == "true" and selfState == "ok":
		prob = 1
	elif selfState == "stuck":
		prob = 1

	if selfFlow == "false":
		prob = 1 - prob
	return prob

	return prob

genDataProfile("V1_flow", level1_flowProb)
genDataProfile("V2_flow", level1_flowProb)
genDataProfile("V3_flow", level1_flowProb)
genDataProfile("V4_flow", level1_flowProb)

def level1_leakingProb(variables, values):
	selfLeaking = values[0]
	selfState = values[1]

	prob = 0
	if selfState == "leak":
		prob = 1

	if selfLeaking == "false":
		prob = 1 - prob
	return prob

genDataProfile("V1_leaking", level1_leakingProb)
genDataProfile("V2_leaking", level1_leakingProb)
genDataProfile("V3_leaking", level1_leakingProb)
genDataProfile("V4_leaking", level1_leakingProb)


def S1_detectProb(variables, values):
	selfDetect = values[0]

	prob = 0
	for col in range(1, len(values)):
		if values[col] == "true":
			prob = 1
			break

	if selfDetect == "false":
		prob = 1 - prob
	return prob

genDataProfile("S1_detect", S1_detectProb)

def level2_flowProb(variables, values):
	selfFlow = values[0]
	parentFlow = values[1]
	selfOpen = values[2]
	selfState = values[3]

	prob = 0
	if parentFlow == "true":
		if selfState == "ok":
			if selfOpen == "true":
				prob = 1
		elif selfState == "stuck":
			prob = 1

	if selfFlow == "false":
		prob = 1 - prob
	return prob

genDataProfile("V5_flow", level2_flowProb)
genDataProfile("V6_flow", level2_flowProb)
genDataProfile("V7_flow", level2_flowProb)
genDataProfile("V8_flow", level2_flowProb)
genDataProfile("V9_flow", level2_flowProb)
genDataProfile("V10_flow", level2_flowProb)
genDataProfile("V11_flow", level2_flowProb)
genDataProfile("V12_flow", level2_flowProb)

def level2_leakingProb(variables, values):
	selfLeaking = values[0]
	parentFlow = values[1]
	selfState = values[2]

	prob = 0
	if parentFlow == "true" and selfState == "leak":
		prob = 1


	if selfLeaking == "false":
		prob = 1 - prob
	return prob

genDataProfile("V5_leaking", level2_leakingProb)
genDataProfile("V6_leaking", level2_leakingProb)
genDataProfile("V7_leaking", level2_leakingProb)
genDataProfile("V8_leaking", level2_leakingProb)
genDataProfile("V9_leaking", level2_leakingProb)
genDataProfile("V10_leaking", level2_leakingProb)
genDataProfile("V11_leaking", level2_leakingProb)
genDataProfile("V12_leaking", level2_leakingProb)

def S2_detectProb(variables, values):
	selfDetect = values[0]

	prob = 0

	for col in range(1, len(values)):
		if values[col] == "true":
			prob = 1
			break

	if selfDetect == "false":
		prob = 1 - prob
	return prob

genDataProfile("S2_detect", S2_detectProb)

def level3_flowProb(variables, values):
	selfFlow = values[0]
	parent1Flow = values[1]
	parent2Flow = values[2]
	selfOpen = values[3]
	selfState = values[4]

	prob = 0
	if parent1Flow == "true" or parent2Flow == "true":
		if selfState == "ok":
			if selfOpen == "true":
				prob = 1
		elif selfState == "stuck":
			prob = 1

	if selfFlow == "false":
		prob = 1 - prob
	return prob

genDataProfile("V13_flow", level3_flowProb)
genDataProfile("V14_flow", level3_flowProb)
genDataProfile("V15_flow", level3_flowProb)
genDataProfile("V16_flow", level3_flowProb)

def level3_leakingProb(variables, values):
	selfLeaking = values[0]
	parent1Flow = values[1]
	parent2Flow = values[2]
	selfState = values[3]

	prob = 0
	if (parent1Flow == "true" or parent2Flow == "true") and selfState == "leak":
		prob = 1

	if selfLeaking == "false":
		prob = 1 - prob
	return prob

genDataProfile("V13_leaking", level3_leakingProb)
genDataProfile("V14_leaking", level3_leakingProb)
genDataProfile("V15_leaking", level3_leakingProb)
genDataProfile("V16_leaking", level3_leakingProb)


def S3_detectProb(variables, values):
	selfDetect = values[0]

	prob = 0

	for col in range(1, len(values)):
		if values[col] == "true":
			prob = 1
			break

	if selfDetect == "false":
		prob = 1 - prob
	return prob

genDataProfile("S3_detect", S3_detectProb)

def e_thrustProb(variables, values):
	selfThrusts = values[0]
	parent1Flow = values[1]
	parent2Flow = values[2]

	prob = 0
	if parent1Flow == "true" or parent2Flow == "true":
		prob = 1

	if selfThrusts == "false":
		prob = 1 - prob
	return prob

genDataProfile("E1_thrusts", e_thrustProb)
genDataProfile("E2_thrusts", e_thrustProb)
