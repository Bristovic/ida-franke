# on tidying data
library(tidyverse)

# consider student exam results example
exam_res_vis <- tribble(
  ~exam,  ~"Mohammed",  ~"Ezekiel",  ~"Rebecca",
  "start_term", "4.0", "3.6", "4.0",
  "end_term", "4.6", "4.2", "4.7"
)

# this can be visualised
exam_res_vis

# Rmarkdown can make it look pretty, but not tidy in technical sense
knitr::kable(
  exam_res_vis,
  caption = "Fictional exam results for fictional students",
  booktabs = TRUE
)

# This is tidy, in technical sense:
exam_res_vis <- tribble(
  ~student, ~exam, ~grades,
  "Mohammed", "start_term", "4.0",
  "Ezekiel", "start_term", "3.6",
  "Rebecca", "start_term", "4.0",
  "Mohammed", "end_term", "4.6",
  "Ezekiel", "end_term", "4.2",
  "Rebecca", "end_term", "4.7"
)

exam_res_vis


# this is not tidy because each form of obs unit doesn't form a table
exam_results_overloaded <- tribble(
  ~student,    ~stu_number,    ~exam,      ~grade,
  "Rozz",      "666",          "midterm",  1.3,
  "Andrew",    "1969",         "midterm",  2.0,
  "Siouxsie",  "3.14",         "midterm",  1.7,
  "Rozz",      "666",          "final",    2.3,
  "Andrew",    "1969",         "final",    1.7,
  "Siouxsie",  "3.14",         "final",    1.0
)
exam_results_overloaded

# to properly tidy, need to be two separate tables
exam_results_tidy <- tribble(
  ~student,    ~exam,      ~grade,
  "Rozz",      "midterm",  1.3,
  "Andrew",    "midterm",  2.0,
  "Siouxsie",  "midterm",  1.7,
  "Rozz",      "final",    2.3,
  "Andrew",    "final",    1.7,
  "Siouxsie",  "final",    1.0
)

student_numbers <- tribble(
  ~student,    ~student_number,
  "Rozz",      "666",   
  "Andrew",    "1969",
  "Siouxsie",  "3.14"
)

# separate tibbles, but share name "student".
# tidyverse has simple method to combine this info

full_join(exam_results_tidy, student_numbers, by = "student")
