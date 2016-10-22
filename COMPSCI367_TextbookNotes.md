# COMPSCI367 Textbook Notes

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
