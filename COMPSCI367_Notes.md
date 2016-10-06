# COMPSCI 367 Notes

## Knowledge engineering

### History of Artificial Intelligence

**Alan Turing** was the inventor of the field of artificial intelligence.

The **Turing Machine** is a hypothetical computing machine which can use a predefined set of rules to determine a result from a set of input variables.

The **Universal Machine** is a Turing Machine that simulates all possible Turing Machines.

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

### CLIPS

#### Facts

A **fact** is a statement that is declared to be true.

`(facts)` lists the current facts

`(assert <facts>)` creates a new fact.

`(retract <fact>)` removes a fact from memory.

`(clear)` clears the memory completely.

`(deffacts <facts>)` defines initial facts that are only asserted when the engine is reset.

`(reset)` clears just the current facts and reloads all the initial facts.

`(run)` runs the current execution.

`(run n)` runs only $n$ number of rules.

`(agenda)` displays the list of rules n memory.

`(deftemplate <template name> "comment"[list of slots])`



Variables are defined `?name`.

Operations are pre-fix e.g. `(* 2 3)`


`
(deffunction <function name> (<parameter list>)
    (<function body>)
)
`


`
(defrule
  (<input fact> value)
  =>
  (<output fact> value)
)
`

**Salience** determines the priority of the rule to be fired.

`(printout t "message" crlf)` prints out to standard output with a carriage return (line end).


## Machine learning


### Overview

An agent is learning if it improves its performance on future tasks after making observations about the world.

Why wouldn't the designers just program in the improvement to begin with?
* The designers cannot anticipate all possible solutions that the agent might find itself in.
* The designers cannot anticipate all changes over time.
* Sometimes human programmers have no idea how to program a solution themselves.

Improvements and the techniques used to make them, depend on four major factors:
* Which component is to be improved.
* What prior knowledge the agent already has.
* What representation is used for the data and the components.
* What feedback is available to learn from.

The **components** of agents include:
* A direct mapping from conditons on the current state to actions.
* A means to infer relevant properties of the world from the percept sequence.
* Information about the way the world evolves and about how the results of possible actions the agent can take.
* Utility information indicating the desirability of world states.
* Action-value information indicating the desirability of actions.
* Goals that describe classes of states whose achievement maximises the agent's utility.

**Inductive learning** is learning a (possibly incorrect) general function or rule from specific input-output pairs.

**Deductive learning** or **analytical learning** uses a known general rule to logically entail a new rule.

There are three types of feedback:
* In **unsupervised learning**, the agent learns patterns in the input even though no explicit lfeedback is supplied. The most common unsupervised learning  task is **clustering**: detecting potentially useful clusters of input examples.
* In **reinforcement learning**, the agent learns from a series of reinforcements, rewards or punishments. It is up to the agent to decide which of the actions prior to the reinforcement were most responsible.
* In **supervised learning**, the agent observes some example input-output pairs and learns a function that maps from input to output.

### Supervised learning

A **training set** is a set of example input-output pairs to learn from.

A **hypothesis** is a function that possibly maps the inputs $x$ to the outputs $y$.

A **test set** is a set of examples used to measure the accuracy of the hypothesis.

A hypothesis **generalises** well if it correctly predicts the output for novel examples.

There are two types of learning problems:
* **Classification** is when the output value is one of a finite set of values.
* **Regression** is when the ouput is a number. This is usually only a conditional expectation or an average value.

The **hypothesis space** $\mathcal{H}$ is the set of all possible hypotheses for a given learning problem.

A hypothesis is **consistent** if it agrees with all the data.

The **principle of Ockham's razor** is to prefer the simplest hypothesis consistent with the data.

There is a tradeoff between complex hypotheses that fit the training data well and simpler hypotheses that may generalise better.

A learning problem is **realisable** if the hypothesis space contains the true function.

$h^\ast$ is the most probable hypothesis given the data.

$h^\ast=\text{arg max}_{h\in \mathcal{H}}P(h|\text{data})$

$\because$ Bayes' rule:  
$h^\ast=\text{arg max}_{h\in \mathcal{H}}P(\text{data}|h)P(h)$

There is a tradeoff between the expressiveness of a hypothesis space and the complexity of finding a good hypothesis within that space.

A second reason to prefer simple hypothesis spaces is that computing $h(x)$ will be faster and more efficient with simpler representations.

### Learning Decision Trees
A **decision tree** represents a function that takes a vector of attribute values as input and returns a decision - a single output value.

A **Boolean classification** is a type of decision trees where the output is either true (a positive example) or false (a negative exmaple).

A decision tree reaches its decision by performing a sequence of tests. Each internal node in the tree corresponds to a test of the value of one of the input attributes $A_i$ and the branches from the node are labeled with the possible values of the attribute $A_i=v_{ik}$. Each leaf node in the tree specifies a value to be returned by the function.

A **Boolean decision tree** is logically equivalent to the assertation that the goal attribute is true if and only if the inout attributes satisfy one of the paths leading to a leaf with value true i.e. $\text{Goal}\Leftrightarrow(Path_1\lor Path_2\lor \cdots)$, where each Path is a conjunction of attribute-value tests required to follow that path.

General search on decision trees can be extremely slow in a broad and/or deep tree. Therefore finding the best tree (consistent and smallest) becomes an intractable problem.

The greedy divide-and-conquer approach always test the most important attribute first. This test divides the problem up into smaller subproblems that can then be solved recursively. By "most important attribute", we mean the one that makes the most difference to the classification of an example.

There are four cases to consider for these recursive problems:
1. If the remaining examples are all positive or all negative, then we are done.
2. If there are some positive and some negative examples, then choose the best attribute to split them.
3. If there are no examples left, it means that no example has been observed for this combination of attribute values and we return a default value calculated from the plurality classification of all the examples that were used in constructing the node's parent.
4. If there are no attributes left, but both positive and negative examples are left, it means that these examples have exactly the same description, but different classifications. This can happen because there is an error or noise in the data; because the domain is non-deterministic; or because we cannot observe an attribute that would distinguish the examples. The best we can do is return the plurality classification of the remaining examples.

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

### R

A variable can be **assigned** a value using `<variable> <- <value>`, e.g. `x <- 2`.

The **primitive data types** are:
* **logical**: TRUE, FALSE
* **double**: 1,1.15
* **integer**: 2L, 100L
* **character**: "string", 'string'

A **comment** can be created by prefixing a string message with `#`, e.g. `# a comment`.

The **data structures** are:
* An **array** is a ordered collection of elements where all of the elements must be the same type.
* A **vector** is a one-dimensional array.
  * A vector can be made from individual elements being combined with `c(<value1>, <value2>, ...)`.
  * A value can be tested to be a vector using `is.atomic(<value>)`.
  * A list can be converted into a vector using `unlist(<list>)`.
* A **matrix** is a two-dimensional array.
  * A matrix can be created `matrix(<vector elements>), nrow=<double numberOfRows>, ncol=<double numberOfCols>, byrow=<logical fillByRowOrder>)`.
  * A value can be converted into a matrix using `as.matrix(<value>)`.
* A **data frame** is a collection of vectors of vectors that are all the same length and each vector can be of different type.
  * A value can be converted into a data frame using `as.data.frame(<value>)`.
* A **list** is an ordered collection of elements of any type.
  * A list can be made from individual elements using `list(<value1>, <value2>, ...)`
  * A value can be tested to be a list using `is.list(<value>)`.

The **print** method, `print(<string message>)`, prints a message to the standard output.

#### Packages

A **package** is a bundle of R code available to install.

Packages can be **installed** using `install.packages(<string packageName>)`.

Packages can be **loaded** into a script file with `require(<string packageName>)`.
