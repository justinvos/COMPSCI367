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

A second readon to prefer simple hypothesis spaces is that computing $h(x)$ will be faster and more efficient with simpler representations.
