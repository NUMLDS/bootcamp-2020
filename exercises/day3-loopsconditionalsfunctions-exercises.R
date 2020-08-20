###Day 3 Exercises: Loops, Conditionals, and Functions###
##By: Sarah Moore## 

#Use the here command to load in the gapminder5.csv


#Inspect the dataset and the variable classes to make sure that they have the proper attributes (e.g. change factors to characters). 


#Create a vector for each i observation in the dataset. 


####################
##For Loops

#Using a `for` command, create a variable that measures the life expectancy of each country-year unit in months. 
#Call this variable "lifeExp_months"


#Using another`for` command, create a new variable that is the log value of "lifeExp_months". 
#Call this variable "log_lifeExp_months".


#Use the vectorized method to replicate both of these variables without a loop. 
#Call them lifeExp_months_2 and log_lifeExp_months_2, respectively. Compare these to the looped method. 

#Using a method of your choosing, use the gdpPercap variable and pop variable to calculate the GDP per year per country. Call this variable "gdp". 


#Now account for each of the unique country names that are in the dataset, and create a variable with them called "countries" 


#Create a nested loop in which you create a readout of the country name and a calculation of the average log gdp for all years accounted for in the dataset. 
#Repeat this for the standard deviation of country log gdp's over time. 



####################
##While Loops 

#Set an interator starting with 1954, use a while loop to calculate the standard deviation of log gdp for ever 3 years before 2002 (inclusive). 
#Make the read out so that it reads as "Year: standard deviation" (hint: see lecture notes for this particular format)



####################
##Conditional Statements 

#Then create an if/else command that prints "Mean gdp per capita is less than 900" if the mean gdp per capita is less than 900 over all observed years. 
#Else, print the statement "Mean GDP per capita is greater than 900." 



#Create a for loop with an if/else conditional: 
#Write a for loop that calculates the mean gdp per capita for each country over the observed years in the dataset. 
#If a given country's mean gdp per capita is greater than the median for all country-year observations, then print the country and its mean gdp per capita. 
#Else, print the country name and the statement "Sorry, this country does not meet the median threshold." 



#####################
##Functions 

#Create a function called report_min_max to calculate the minimum and maximum log gdp (i.e. not per capita) for Europe. 

#####################
#Putting things all together. 

#Change the following function to conform to the following:
#1) Change the color to green (hint: the specification for color is `col`)
#2) Instead of a log x variable, use a squared x variable. 
#3) Run the function as we did in the exercise, but with the above new specifications for the year 1987. 

viz_lm <-
  function(df, dv, iv, year) {
    dat <- df[df[["year"]] == year, ]
    y <- log(dat[[dv]])
    x <- log(dat[[iv]])
    fit <- lm(y ~ x)
    plot(y ~ x, main = year,
         xlab = iv, ylab = dv)
    lines(x, predict(fit), col = 'blue')
  }


