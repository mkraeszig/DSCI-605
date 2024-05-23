---
  title: "The basic R Markdown"
author: "Mitchell Kraeszig"
date: "`r Sys.Date()`"
output: html_document
---
  
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

* # Data description
  * Variable 1: rank: This is a categorical variable representing if the subject is an assistant professor, associate professor, or a professor * Variable 2: discipline: This is a categorical variable representing the department the subject works in, either applied or theoretical * Variable 3: yrs.since.phd: This is a continuous variable representing the number of years since the subject has obtained their PhD * Variable 4: yrs.service: This is a continuous variable representing the number of years the subject has served in the department and/or at the University  * Variable 5: sex: This is a categorical variable representing if the subject is male or female * Variable 6: salary: This is a continuous variable representing the subject's nine-month salary in USD



* # Data wrangling
  * Step 1: Install and loads tidyverse * Step 2: Load and read the CSV data file * Step 3: Select the columns rank, discipline, sex, and salary * Step 4: filter data to remove all records with a missing salary * Step 5: Group the data based on rank, discipline, and sex  * Step 6: Summarise by the tally count of each row * Step 7: Split out the column sex by tall count "n"* Step 8: condense the new columns created in previous step into one column named "sex" and the values named as "n"

- Code chunk for data wrangling.


```{r, message=FALSE, warning=FALSE}

#install.packages("tidyverse") #intall package

library(tidyverse) #load packages
library(dplyr)#load packages


```

```{r,message=FALSE}

# 2. Set the working directory
setwd("C:/Users/mitch/OneDrive/DSCI 605/R/Labs/Module2")
#getwd()

# 3. Read csv file into R using the function read_csv().

Salaries <- read_csv("salaries.csv")
#view(Salaries)

# 4. Use select(), filter(), group_by(), count() in this part and combine them with pipe operator

Salaries_new <- Salaries %>% #starting with data table and using pipe so all steps point to the Salaries table
  select(rank, discipline, sex, salary) %>% #from Salaries selecting the columns rank, discipline, sex, and salary
  filter(!is.na(salary)) %>% #from those selected columns pull all records where sex is not missing
  group_by(rank, discipline, sex) %>% #group by rank, discipline, an sex
  summarize(n = n()) #and get a tally count by those groups 

#view(Salaries_new)

# 5. using spread() to transfer the "sex" column to many more columns based on the values in sex.

wide<- Salaries_new %>% #starting with data table Salaries_new
  spread(sex, n, fill = FALSE, convert = FALSE )#using sex as the key and n as the value to separate out each of the sex values and displaying counts by sex

#view(wide)


# 6. Reshape the table from wide to long: using gather() to combine multiple "sex" related columns to one column sex

long <- wide %>% #starting with table wid
  gather(sex, n,(ncol(wide)-1):ncol(wide),na.rm=TRUE)#from wide we are setting new column of sex to a new value of n, which comes from the last two rows in table wide
#setting sex to variable name, count to new value, and combining columns 3 to 4 

#ncol(wide)
#view(long)


```
