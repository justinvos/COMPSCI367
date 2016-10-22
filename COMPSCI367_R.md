# COMPSCI367 R

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

## Packages

A **package** is a bundle of R code available to install.

Packages can be **installed** using `install.packages(<string packageName>)`.

Packages can be **loaded** into a script file with `require(<string packageName>)`.
