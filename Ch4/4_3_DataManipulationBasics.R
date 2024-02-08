# basics of data manipulation
library(tidyverse)

## pivoting
# previous example data
exam_results_visual <- tribble(
  ~exam,       ~"Rozz",   ~"Andrew",   ~"Siouxsie",
  "midterm",   "1.3",     "2.0",       "1.7",
  "final"  ,   "2.3",     "1.7",       "1.0"
)
# this data is too wide 

# so can use pivot_longer
  pivot_longer(
    # pivot every column save first
    #neg. number means exclude col w/ that index
    cols = -1,
    # name of new column which contains "
    # the names of the columns to be "gathered"
    names_to = "student",
    # name of new column which contains the values
    # of the cells which now form a new column
    values_to = "grade"
  ) %>%
  # optional column reordering
  select(student, exam, grade)


# this example is too long, in combining two different measurement types
# they are different variables and should be in different columns
mixed_results_too_long <- 
  tibble(student = rep(c('Rozz', 'Andrew', 'Siouxsie'), times = 2),
         what    = rep(c('grade', 'participation'), each = 3),
         howmuch = c(2.7, 2.0, 1.0, 75, 93, 33))
mixed_results_too_long

mixed_results_too_long %>%
  pivot_wider(
    # col containing name of new cols
    names_from = what,
    # col containing values of new columns
    values_from = howmuch
  )

# can use filter function to remove irrelevant data
exam_results_tidy %>% 
  # keep only entries with grades better than 
  # or equal to 1.7
  filter(grade <= 1.7)

# can use select function to pick subset of columns
#(and reorder as order specified is order returned)
exam_results_tidy %>% 
  # select columns `grade` and `exam`
  select(grade, exam)

# tidyselect package has useful helper functions for selecting columns
# for these functions (starts_with, ends_with, contains, num_range)

# To add or edit a column, use mutate()
exam_results_tidy %>% 
  mutate(
    # add a new column called 'passed' depending on grade
    # [NB: severe passing conditions in this class!!]
    passed = grade <= 1.7, 
    # change an existing column; here: change
    # character column 'exam' to ordered factor
    exam = factor(exam, ordered = T)
  )

# to rename a column, use rename()
exam_results_tidy %>%
  rename(participant = student)

# separate() can disentangle info stored in a single column
# example of info stored in a single character vector
# separated by commas
homework_results_untidy <- 
  tribble(
    ~student,      ~results,
    "Rozz",        "1.0,2.3,3.0",
    "Andrew",      "2.3,2.7,1.3",
    "Siouxsie",    "1.7,4.0,1.0"
  )

homework_results_untidy %>%
  separate(
    # which col to splot
    col = results,
    # names of new column to store results
    into = str_c("HW", 1:3),
    # separate by which char / reg-exp
    sep = ",",
    # auto (smart-)  convert the type of new cols
    convert = T
  )

# sorting data for presentation (not for plotting)
# can use arrange() to sort alphanum ascending
# and desc() to specify descending
exam_results_tidy %>%
  arrange(desc(student), grade)


# tibbles can be combined horizontally (join columns) with cbind()
# or vertically (join rows) with rbind()

# rbind example
new_exam_results_tidy <- tribble(
  ~student,    ~exam,      ~grade,
  "Rozz",      "bonus",  1.7,
  "Andrew",    "bonus",  2.3,
  "Siouxsie",  "bonus",  1.0
)
rbind(
  exam_results_tidy, 
  new_exam_results_tidy
)

# if joining two datasets with info in common
# join func family helps

# full_join
# same as before
exam_results_tidy <- tribble(
  ~student,    ~exam,      ~grade,
  "Rozz",      "midterm",  1.3,
  "Andrew",    "midterm",  2.0,
  "Siouxsie",  "midterm",  1.7,
  "Rozz",      "final",    2.3,
  "Andrew",    "final",    1.7,
  "Siouxsie",  "final",    1.0
)
# additional table with student numbers
student_numbers <- tribble(
  ~student,    ~student_number,
  "Rozz",      "666",   
  "Andrew",    "1969",
  "Siouxsie",  "3.14"
)
full_join(exam_results_tidy, student_numbers, by = "student")
