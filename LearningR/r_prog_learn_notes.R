 #notes from second flight of learning R prog

############################################################################
### subsetting rules....

[] - single square brackets give the class of original object (eg. [] on vector = vector).
It can also be used to select more than one element of an object

[[]] - extracts a single element only of list of dataframe, Result may be an object that is not the same class
eg. [[]] of a list could return a vector or numeric

$ can be used to exract objects by name. The symantics are the same/similar as for [[]]

using []

object[numerical reference, or logical reference]
eg.

x[1:4]
x[x > 3]

index a matric using [row,col]
eg. for all of col 1 , use [,1]

note: subsetting out a single element of a matrix results in a vector (length 1), not a matrix. 
to reverse this, use the [, drop = FALSE] option

Subsetting lists:
  can use the [] if you like
[1] on a list will return the first element. if the first element is another list, you get back a list.
remember, [] always returns the same class of object
so, if I use [[1]] on a list, I get back just the elements of the first object in the list, but the class of
what i get back is not neccesarily a list.
eg. x is a list with two vectors
x[1] give me a list with 1 vector
x[[1]] gives me a vector whos elements are the same as the first elment of the list x

the [[]] has other advantages. the script inside the [[]] can be 'computed'
eg. x[[x < a]]
or
u <- "foo"
x[[u]]

you can also extract from subsets of lists using the [[]]
eg. x[[1][2]] or x[c(1,2)] gets the second element of the first element of the list x

you can partial match using the option , exact = FALSE
eg. x[["a" , exact = FALSE]]


using the $ sign:
  works the same as the [[]] but allows specification by name of object more easily

so x[["foo"]] is the same as x$foo
but x["foo"] is not the same  

you can partial match
eg. x$a finds x$aardvark

HOWEVER: to extract multiple elements of a list you must use []. cannot use [[]] or $ to extract multiple
elements of a list

you can add additional [] to create additional layers of a subset. so...
x["foo"][1:6] give the first 6 elements of foo



############################################################################
### REMOVING NAs

you want to create a logical vector that flags up all the NAs
then use this to drop what you dont want by taking a subset of the original object

bads <- is.na(x)
z<x[!bads]

to find rows in a dataframe where there are no NAs, you can use the complete.cases() function

goods <- complete.cases(x)
z <- x[goods]













  




