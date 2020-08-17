############ Day 1 Exercises #############
### by Kumar Ramanathan, based on materials from Christina Maimone ###

#### REVIEW: BASICS AND DATA TYPES ####

#### Arithmetic ####

# Pick a number; save it as x


# Multiply x by 3


# Take the log of the above (Hint, you need the function log() here)


# Subtract 4 from the above


# Square the above


#### Comparisons and Logical Operators ####

# Check if 1 is bigger than 2


# Check if 1 + 1 is equal to 2


# Check if it is true that the strings "eat" and "drink" are not equal to each other


# Check if it is true that 1 is equal to 1 *AND* 1 is equal to 2 
# (Hint: remember what the operators & and | do)


# Check if it is true that 1 is equal to 1 *OR* 1 is equal to 2


#### Packages and Functions ####

# Load the package tidyverse


# Open the help file for the function recode 
# (Hint: remember what ? does)


#### REVIEW: DATA STRUCTURES ####

#### Vectors ####

# Run this code to generate variables x1 and x2
set.seed(1234)
x1 <- rnorm(5)
x2 <- rnorm(20, mean=0.5)

# Select the 3rd element in x1


# Select the elements of x1 that are less than 0


# Select the elements of x2 that are greater than 1


# Create x3 containing the first five elements of x2


# Select all but the third element of x1


#### Missing values ####

# Generate a vector
vec <- c(1, 8, NA, 7, 3)

# Calculate the mean of vec, excluding the NA value


# Count the number of missing values in vec


#### Factors ####

# See lecture notes and DataCamp for guidance and practice


#### Lists ####

# See lecture notes and DataCamp for guidance and practice


#### Matricies ####

# Generate a matrix
mat <- matrix(c(1:51, rep(NA,4)), ncol=5)

# Select row 4, column 5


# Select column 3


# Bonus: How many NA values are there in this matrix?


#### Data frames ####

# Load one of R's example data frames, mtcars
data(mtcars)

# Identify the number of observations (rows) and number of variables (columns)


# Identify the names of the variables


# Select the variable 'mpg'


# Select the 4th row


# Square the value of the 'cyl' variable and store this as a new variable 'cylsq'


#### READING FILES ####

# Check your working directory. It should be the root folder where you downloaded the boot camp materials. If that's not the case, set your working directory accordingly.


# Read gapminder data with read.csv()
gapminder <- read.csv("data/gapminder5.csv", stringsAsFactors=FALSE)

# Load the readr package


# Read gapminder data with read_csv()
