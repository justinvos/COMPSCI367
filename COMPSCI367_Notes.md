# COMPSCI 367 Notes

## Agents
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


## Propositional logic

**Modus Pones**: $\because a\Rightarrow b \text{ and } a=\text{True}\therefore b=\text{True}$.

**And-Elimination**: $\because a\wedge b\therefore a=\text{True}\text{ and }b=\text{True}$.


## Heuristic search
A **heuristic function** $h(n)$ is an estimated cost of the cheapest path from the state node to a goal state.

**Greedy search** or **best-first search** expands to the node with the lowest $h(x)$.

**A\* search** expands to the node with the lowest $h(x)+g(x)$ where $g(x)$ is the cost to the node.

An **admissible heuristic** is one that never overestimates the cost to reach the goal.

A **consistent heuristic** is where $h(x_i)\le h(x_i)+c(x_i,a,x_{i+1})$.
