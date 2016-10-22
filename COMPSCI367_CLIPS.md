# COMPSCI367 CLIPS

## Facts

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
