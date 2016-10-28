# COMPSCI 367 Notes

## Knowledge engineering

### History of Artificial Intelligence

**Alan Turing** (1912-1954) was the inventor of the computer, a World War II codebreaker, the inventor of artificial intelligence, a pioneer of bioinformatics and a marathon runner.

The **Turing Machine** is a thought experiment involving an infinitely long tape of cells containing symbols and a read/write head. The tape can be advanced one cell to the right or left and symbols in the cell can be overwritten according to a set of rules.

The **Universal Machine** is a single Turing Machine that simulates all possible Turing Machines.

The **Turing test** is a test, developed by Alan Turing in 1950, of a machine's ability to exhibit intelligent behaviour equivalent to, or indistinguishable from, that of a human. Turing proposed that a human evaluator would judge natural language conversations between a human and a machine that is designed to generate human-like responses.

**John Searle** (1932-) is an American philosopher who concepted the Chinese Room thought experiment which argues against strong artificial intelligence.

The **Chinese Room** is a thought experiment in which a person in the Chinese room is passed questions from outside the room, and consults a library of books to formulate an answer.

### Symbolic Reasoning

**Symbols** are representations of elements.

**States** are a particular condition something is in at a secific time.

**Operators** are the action that transition from state to state.

**Good old fashioned artificial intelligence** (GOFAI) relies on the physical symbol system hypothesis that:
* Intelligent activity is achieved through the use of:
	* Symbol patterns to represent the problem
	* Operations on those patterns to generate potential solutions
	* Search to select a solution among the possibilities
* An artificial intelligence representation must:
	* Handle qualitative knowledge
	* Allow new knowledge to be inferred from facts and rules
	* Allow representation of general principles
	* Capture complex semantic meaning
	* Allow for meta-level reasoning e.g. predicate calculus

### Agents
An **agent** is an entity that perceives and acts, $f: P\rightarrow A$.

### Problem types
A **single-state problem** is deterministic, fully observable problem where the solution is a sequence from the known initial state.

A **sensorless problem** is a non-observable problem is where the solution is a sequence from any of the possible states.

A **contingency problem** is where the environment is non-deterministic or partially observable.

An **exploration problem** is where the state space is unknown.

A **problem** is defined by four items:

- **Initial state**.

- **Successor function**, $S(x)=\{s_x\rightarrow s_{x+1}, \ldots \}$.

- **Goal test**, $s_x=s_{\text{Goal}}$.

- **Path cost**, $\sum{cost(s_i,a,s_{i+1})}$.

A **solution** is a sequence of actions leading from the initial state to a goal state.

### Uninformed search
A **state** is a representation of a physical configuration.

A **node** is a data structure constituting part of a search tree which includes state, a pointer to the parent node, an action, the path cost $g(x)$

**Breadth-first search** expands the shallowest unexpanded node.

**Depth-first search** expands the deepest unexpanded node.

**Uniform-cost search** expands the cheapest unexpanded node.

**Depth-limited search** expands the deepest unexpanded node up to a specified depth limit.

**Iterative deepening search** expands the deepest unexpanded node up to an increasing depth limit.


### Propositional logic

**Modus Pones**: $\because a\Rightarrow b \text{ and } a=\text{True}\therefore b=\text{True}$.

**And-Elimination**: $\because a\wedge b=\text{True}\therefore a=\text{True}\text{ and }b=\text{True}$.


### Heuristic search
A **heuristic function** $h(n)$ is an estimated cost of the cheapest path from the state node to a goal state.

**Greedy search** or **best-first search** expands to the node with the lowest $h(x)$.

**A\* search** expands to the node with the lowest $h(x)+g(x)$ where $g(x)$ is the cost to the node.

An **admissible heuristic** is one that never overestimates the cost to reach the goal.

A **consistent heuristic** is where $h(x_i)\le h(x_i)+c(x_i,a,x_{i+1})$.

### Reasoning with Uncertainty

#### Probability

An **agent** is an entity capable of perceiving the world and performing some or all of the following functions: reasoning, learning, communication, planning and action.

The **belief view** on probability see probabilities as the belief or confidence that a certain event will occur.

A **possible world** is a possible way the world (environment) of the agent could be. It is described by several variables, each variable $X$ has a domain $dom(X)$, which is the set of all possible values.

The **set of all possible worlds** is denoted $\Omega$.

A **proposition** specifies possible valuations of variables.

We say that the possible world $\omega$ **satisfies** proposition $\alpha$, $\omega\models{a}$ if $\alpha$ holds in the world $\omega$.

A **tautology** is a proposition that holds in all possible worlds i.e. $\forall\omega\in\Omega:\omega\vDash\alpha_{Tautology}$.

A **contradiction** is a proposition that never holds in all the possible worlds i.e. $\forall\omega\in\Omega:\omega\nvDash\alpha_{Contradiction}$.

A **belief measure** is a function $\mu:S^{\Omega}\rightarrow[0,1]$ such that for any $S\subseteq\Omega$, $\mu(S)$ expresses the amount of belief in the fact that the actual world is one of the possible worlds in $S$.

Any belief measure must satisfy the following properties:
1. **Unit measure**: We have full belief in the fact that the actual world is one of the possible worlds i.e. $\mu(\Omega)=1$.
2. **Additivity**: Suppose $S_1$ and $S_2$ are disjoint subsets of $\Omega$. Then our belief that the actual world  is in $S_1\cup{S_2}$ is the sum of our belief that the actual world is in $S_1$ and our belief that the actual world is in $S_2$, i.e. $\mu(S_1\cup{S_2})=\mu{S_1}+\mu(S_2)$.

The **axioms of probability** ares:
1. The probability of an event is a non-negative real number, $P(E)\in\Bbb{R}$.
2. The probability of the entire sample space is equal to 1, $P(\Omega)=1$.
3. If $\alpha\wedge \beta$ is a contradiction, then $P(\alpha\vee\beta)=P(\alpha)+P(\beta)$

A variable $X$ is called a **random variable** if the agent does not know its value in the actual world.

A **probability distribution** a random variable $X$, $P(X)$, is a function from the $dom(X)$ into $[0,1]$ such that, given a value $x\in dom(X)$, $P(x)=P(X=x)$.

A **joint probability distribution** over two random variables $X$ and $Y$, $P(X,Y)$, is a function from $dom(X)\times dom(Y)$ into $[0,1]$ such that, given $x\in dom(X)$ and $y\in dom(Y)$, $P(x,y)=P(X=x\wedge Y=y)$.

Two random variables $X$ and $Y$ are **independent** if $P(X,Y)=P(X)\times P(Y)$.

The **joint probability** of two independent events is their product i.e. $P(a\wedge b)=P(a)\times P(b)$.

The **conditional probability** is the measure of belief in proposition $h$ assuming that proposition $e$ already holds is $h$ given $e$, written $P(h|e)=\large\frac{P(h\wedge e)}{P(e)}$.

The **hypothesis** $h$ is the event you are attempting to predict.

The **evidence** $e$ is the current information you hold for believing that a possible hypothesis may be true.

The **prior probability** is the initial degree of belief in the event.

The **posterior probability** is the probability for the event after taking into account for the evidence.

The **Laws of total probability** are:
1. $P(h)=P(h|e)P(e)+P(h|\neg e)P(\neg e)$
2. If $X$ is a variable $P(h)=\sum_{x\in dom(X)}{P(h|X=x)P(X=x)}$

**Bayes' theorem** tells us how to update the agent's belief in the hypothesis as new evidence arrives. $P(h|e)=\large\frac{P(e|h)P(h)}{P(e)}$.

**Bayes' theorem with existing evidence** is $P(h|e\wedge k)=\large\frac{P(e|h\wedge k)\times P(h|k)}{P(e|k)}$

A random variable $X$ is **conditionally independent** of another random variable $Y$, given a third random variable $Z$ if $P(X,Y|Z)=P(X|Z)P(Y|Z)$.
