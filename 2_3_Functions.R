# create a named function with function
# takes two numbers, x and y, as arg
# returns x * y + 1

cool_function <- function(x, y) {
  return(x * y + 1)
}

# test data
cool_function(2, 4)

# test with vector result
cool_function(1:3, 2)

# exercise 2.10
bigger_100 <- function(x, y) {
  return(as.integer(x + y > 100))
}

bigger_100(20, 110)

# anonymous functions
# define a function that takes a vector and a function as an argument
new_applier_function <- function(input, function_to_apply) {
  # check if input vector has at least 2 elements
  if (length(input) <= 1) {
    # terminate and show informative error message
    stop("Error in 'new_applier_function': input vector has length <= 1.")
  } 
  # otherwise apply the function to the input vector
  return(function_to_apply(input))
}

# sum vector with built-in & named function
new_applier_function(
  input = 1:3,              # input vector 
  function_to_apply = sum   # built-in & named function to apply
)   # returns 6

# Sum vector with anonymous function
new_applier_function(
  input = 1:3,              # input vector 
  function_to_apply = function(in_vec) {
    return(in_vec[1] + in_vec[2])
  } 
)   # returns 3 (as it only sums the first two arguments)

# exercise 2.11 my version
x <- new_applier_function(
  # input vector
  input = 4:9,   
  function_to_apply = function(vec_ord) {
    return(vec_ord[2:1])
  }
)

# IDA version
y <- new_applier_function(
  input = 1:3,              # input vector 
  function_to_apply = function(in_vec) {
    # c returns values as vector or list. still don't fully understand this
    return(c(in_vec[c(2,1)]))
  } 
)
