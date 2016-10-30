# COMPSCI367 Textbook Notes

## Knowledge, reasoning and planning

### 7.1 Knowledge-based agents

A **knowledge base** is a set of known sentences.

A **sentence** represents some assertion about the world and is expressed in a language called a knowledge representation language.

An **axiom** is a sentence to be taken as given without being derived from the other sentences.

**Inference** is the deriving of new sentences from the old.

**Background knowledge** or **initial knowledge** is the knowledge that is already known at the start.

The **knowledge level** is the level where we only need to specify what the agent knows and what its goals are.

The **implementation level** is the level where the actiosn are actually carried out by the agent.

The **declarative approach** is to tell sentences until the agent knows how to operate in its environment.

The **procedural approach** encodes desired behaviours directly as program code.

### 7.3 Logic

A **possible world** is a potentially real environment that the agent might be in.

A **model** is a mathematical abstraction which simply fixes the truth or falsehood of every relevant statement.

If a sentence $\alpha$ is true is a model $m$, we say $m$ **satisfies** $\alpha$ or sometimes $m$ is a model of $\alpha$.

The set of all models of $\alpha$ is denoted $M(\alpha)$.

**Entailment** is the idea that a sentence follows logically from another sentence. Denoted $\alpha\vDash\beta$, the sentence $\alpha$ entails the sentence $\beta$, meaning in every model in which $\alpha$ is true, $\beta$ is also true.

**Model checking** is an inference algorithm that enumerates over all possible models to check that some sentence is true in all models in which the knowledge base is true.

An inference algorithm is **sound** if it derives only entailed sentences.

An inference algorithm is **complete** if it can derive any sentence that is entailed.

**Grounding** refers to the connection between the logical reasoning processes and the real environment in which the agent exists.

### 7.4 Propositional Logic

A **propositional symbol** represents a proposition that can be true or false.

Propositional symbols can be combined using logical connectives:
* $\neg$. A sentence such as $\neg\alpha$ is called the **negation** of $\alpha$, and is true when the operand is false.
* $\wedge$. A sentence such as $\alpha\wedge\beta$ is called the **conjunction** of $\alpha$ and $\beta$, and is true when both parts are true.
* $\vee$. A sentence such as $\alpha\vee\beta$ is called the **disjunction** of $\alpha$ and $\beta$, and is true when either part is true.
* $\Rightarrow$. A sentence such as $\alpha\Rightarrow\beta$ is called an **implication**. Its **premise** or **antecedent** is $\alpha$ and its **conclusion** or **consequent** is $\beta$, and is only false when the premise is true and the conclusion is false.
* $\Leftrightarrow$. A sentence such as $\alpha\Leftrightarrow\beta$ is called a **biconditional** and is true when both parts are the same.

The **operator precedence** is in the order of $\neg,\wedge,\vee,\Rightarrow,\Leftrightarrow$.

### 7.5 Proposition Theorem Proving

Two sentences $\alpha$ and $\beta$ are **logically equivalent** if they are true in the same set of models, we write this as $\alpha\equiv\beta$.

A sentence is **valid** if it is true in all models, these sentences are also known as **tautologies**.

The **deduction theorem** is that for any sentences $\alpha$ and $\beta$, $\alpha\vDash\beta$ if and only if the sentence $a\Rightarrow\beta$ is valid.

A sentence is **satisfiable** if it is true in, or satisfied by some model.

These **inference rules** can be applied to derive a proof:
* **Modus Ponens** states that whenever sentences of the form $\alpha\Rightarrow\beta$ and $\alpha$ are given, then the sentence $\beta$ can be inferred.
* **And Elimination** states that from a conjunction $\alpha\wedge\beta$, any of the parts, $\alpha$ or $\beta$, can be individually inferred.
* The **resolution rule** states that if a disjunction $\alpha_1\vee\cdots\vee\alpha_k$ and a part of being false $\neg\alpha_i$ is given, the disjunction without that part $\alpha_1\vee\cdots\vee\alpha_{i-1}\vee\alpha_{i+1}\vee\cdots\vee\alpha_k$ can be inferred.

**Monotonicity** refers to the idea that the set of entailed sentences can only increase as information is added to the knowledge base.

A sentence is in **conjunction normal form** (CNF) if it is expressed as a conjunction of disjunctions.

Each disjunction in CNF is known as a **clause**.

The **PL-Resolution algorithm** takes a knowledge base $KB$ and a query sentence $q$, and finds whether $KB\wedge\neg q$ is unsatisfiable. It does this by converting $KB\wedge\neg q$ into CNF and resolving each pair of clauses to obtain a new clause. It stops when either there are no new clauses to be added, in which case $KB\nvDash q$, or when a pair of clauses resolve to the empty clause i.e. a contradiction, in which case $KB\vDash q$.

The **resolution closure** $RC(S)$ of a set of clauses $S$, is the set of all clauses derivable by repeated application of the resolution rule to clauses in $S$ or their derivatives.

A **definite clause** is a disjunction of literals of which exactly one is positive. A definite clause such as $\neg\alpha_1\vee\cdots\vee\neg\alpha_k\vee\beta$ can be written as an implication $(\alpha_1\wedge\cdots\wedge\alpha_k)\Rightarrow\beta$.

A **goal clause** is a disjunction of only negative literals.

A **Horn clause** is a disjunction of literals where at most one is positive.

The **PL-FC-Entails algorithm** determines if a single proposition symbol $q$ is entailed by the knowledge base of definite clauses $KB$. If all the premises of an implication are known, then its conclusion is added to the set of known facts. The process continues until the query $q$ is added or until no further inferences can be made.

A **forward-chaining algorithm** such as PL-FC-Entails is an example of the general concept of **data-driven reasoning**, which is reasoning where the focus of attention starts with the known data.

The **PL-BC-Entails algorithm** works backward from the query and finds the implications to make the query as the conclusion true. If any of the premises are unknown, the process is applied to find that premise as a conclusion. It stops when either all the premises are known to make the query true or when a required premise cannot be known.

A **backward-chaining algorithm** such as PL-BC-Entails is an example of the general concept of **goal-driven reasoning**, which starts the focus of attention with the query and works backwards, eventually using the known facts.

## Machine learning

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

## Supervised learning

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

## Learning Decision Trees
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
