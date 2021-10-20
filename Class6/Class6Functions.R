#what: a function is defined with: 
  #a user selected name, 
  #a comma separated set of input arguments and
  #Regular R code for the function body
#how: Follow a step by step procedures to go ...
  #....from working code snippet to refined and tested functions 
  #1.start with simple problem, a snippet of code 
  #2.rewrite for clarity and to reduce duplication
  #3.then and ONLY then turn into an initial function
  #4.test on small well defined input


add <- function(x, y=1) {
  x+y
}


add(x=4)

add(x=4, y=10)

add(c(1,2,5,10), y=10)
add(c(1,2,5,10),y="string")




