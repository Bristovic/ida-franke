# reading and writing data
library(readr)


# reading and writing from CSV
ex_data <- read_csv("PATH/FILENAME_RAW_DATA.csv")
write_csv(processed_data, "PATH/FILENAME_PROCESSED_DATA.csv")

# reading or altering delimiters between cells
data_from_strange_file <- read_delim("WEIRD_DATA_FILE.txt", delim = "|")
write_delim(data_string, "PATH/FILENAME_DATA_STRING.txt", delim = "|")


