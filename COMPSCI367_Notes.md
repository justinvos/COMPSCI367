# COMPSCI 367 Notes

## Agents
An **agent** is an entity that perceives and acts, $f: P\rightarrow A$.

### Problem types
A **single-state problem** is deterministic, fully observable problem where the solution is a sequence from the known initial state.  
A **sensorless problem** is a non-observable problem is where the solution is a sequence from any of the possible states.  
A **contingency problem** is where the environment is non-deterministic or partially observable.  
An **exploration problem** is where the state space is unknown.

A **problem** is defined by four items:
* **Initial state**.
* **Successor function**, $S(x)=\{s_x\rightarrow s_{x+1}, \ldots \}$.
* **Goal test**, $s_x=s_{\text{Goal}}$.
* **Path cost**, $\sum{cost(s_i,a,s_{i+1})}$.

A **solution** is a sequence of actions leading from the initial state to a goal state.

### Uninformed search
**Breadth-first search** expands the shallowest unexpanded node.

**Depth-first search** expands the deepest unexpanded node.

**Uniform-cost search**

**Depth-limited search**

**Iterative deepening search**


## Propositional logic

**Modus Pones**: $\because a\Rightarrow b \text{ and } a=\text{True}\therefore b=\text{True}$.

**And-Elimination**: $\because a\wedge b\therefore a=\text{True}\text{ and }b=\text{True}$.
