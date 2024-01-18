# Basic calculations
6*7

# Ordering.
5*(659-34)

# ORDER OF OPERATIONS
659-34*5

# Functions.
round(0.6)

# Round can take two arguments: "x" and "digits".
# "x" is to round, "digits" specifies decimal places.
# Default for "digits" is 0.
round (0.13452, 2)
round(x = 0.231323, digits = 3)
round(digits = 4, x = 0.203113002)

# NOTE: If digit to be rounded is 0, will omit.

# Some functions take arbitrary number of arguments. ex sum()
sum(1, 2, 3)

# Can mix floats and integers.
sum(1, 2.1, 3)

#infix vs. prefix notation.
# both of these calls are the same.
1 + 2 + 3  # infix notation
sum(1, 2, 3)  # prefix notation

# Variable assignment. Alt + "-" is a good shortcut.
x <- 6
7 -> y
z = 3

(x * y / z)

# Consistency in variable naming is good practice
snake_case <- 1
long_and_overly_informative_names <- 2

snake_case * long_and_overly_informative_names

# Local variables and indices can be shorter
i <- 1

# Practice
a <- 103
14 -> b

round(x = a/b, digits = 3)

# Multi-line commenting in line-broken function
round(         # call function "round"
  x = 0.138,   # number to round
  digits = 2   # number of digits to round to
)

# Foldable sections
# SECTION IS FOLDABLE ----
x <- 123
y <- 321
x * y 

# Everything before next fold will come under heading ----
# Practice commenting

a <- 103  # Assign variable 'a' as 103
14 -> b   # Assign variable 'b' as 14 with reverse assignment.

round(        # Call function round
  x = a/b,    # Specify value to be rounded, var a over var b
  digits = 3  # Specify rounding decimals,
)             # Close function

# Help function
?round
help("round")

# General help
help.search("topic")
??topic
