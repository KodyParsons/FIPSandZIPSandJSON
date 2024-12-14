# Load required libraries
library(jsonlite)
library(readxl)
library(tidyverse)# Read the Excel file
# Replace "your_file.xlsx" with your actual file path
# I got this dataset from https://www.kaggle.com/datasets/danofer/zipcodes-county-fips-crosswalk?resource=download
# it may have some out of date information, but it is a good starting point
data <- read_excel("ZIP-COUNTY-FIPS_2017-06.xlsx")
head(data)
# Group by county and create the structured data
json_data <- data %>%
  group_by(COUNTYNAME, STATE, STCOUNTYFP, CLASSFP) %>%
  summarise(
    zip_codes = list(as.character(ZIP)),
    .groups = 'drop'
  ) %>%
  rename(
    county_name = COUNTYNAME,
    state = STATE,
    stcountyfp = STCOUNTYFP,
    classfp = CLASSFP
  )

# Convert to JSON and write to file
write_json(json_data, "counties.json", pretty = TRUE)
