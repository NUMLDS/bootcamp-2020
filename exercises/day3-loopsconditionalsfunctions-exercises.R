###Day 3 Exercises: Loops, Conditionals, and Functions###
##By: Sarah Moore## 

###################
## Preparation
# here will refer to files relative to the current working directory
install.packages("here")
here::here()

# Use the here command to load in the gapminder5.csv (create a path to data file)
here::here("data","gapminder5.csv")

# load & inspect dataset
gapminder <- read.csv(here::here("data/","gapminder5.csv"))
head(gapminder)
str(gapminder)

# change factors to characters
gapminder$country <- as.character(gapminder$country)
gapminder$continent <-as.character(gapminder$continent)
str(gapminder)


####################
##For Loops

#Create a vector for each i observation in the dataset. 
obs <- 1:nrow(gapminder)

#Using a `for` command, create a variable that measures the life expectancy of each country-year unit in months. 
#Call this variable "lifeExp_months"
for (i in obs){
  gapminder[i, "lifeExp_months"] <- gapminder[i, "lifeExp"]*12
}


#Using another`for` command, create a new variable that is the log value of "lifeExp_months". 
#Call this variable "log_lifeExp_months".
for (i in obs){
  gapminder[i, "log_lifeExp_months"] <- log(gapminder[i, "lifeExp_months"])
}


#Use the vectorized method to replicate both of these variables without a loop. 
#Call them lifeExp_months_2 and log_lifeExp_months_2, respectively. Compare these to the looped method. 
gapminder$lifeExp_months_2 <- gapminder$lifeExp *12
all(gapminder$lifeExp_months_2 == gapminder$lifeExp_months)

gapminder$log_lifeExp_months_2 <- log(gapminder$lifeExp_months)
all(gapminder$log_lifeExp_months == gapminder$ log_lifeExp_months_2)

#Using a method of your choosing, use the gdpPercap variable and pop variable to calculate the GDP per year per country. Call this variable "gdp". 
gapminder$gdp <- gapminder$gdpPercap * gapminder$pop
gapminder$loggdp <- log(gapminder$gdp)

#Now account for each of the unique country names that are in the dataset, and create a variable with them called "countries" 
countries <- unique(gapminder$country)

#Create a nested loop in which you create a readout of the country name and a calculation of the average log gdp for all years accounted for in the dataset. 
#Repeat this for the standard deviation of country log gdp's over time. 
for (i in countries){{
    ave_loggdp <- mean(gapminder$gdp[gapminder$country == i],
                       na.rm = T)
    sd_loggdp <- sd(gapminder$gdp[gapminder$country == i],
                    na.rm = T)
    print(paste0(i, ":", ave_loggdp, "   ", sd_loggdp))
  }
}

# apply, lapply, sapply
# make a dataframe that only include columns we want to inspect
var <- subset(gapminder, continent == "Asia")
var1 <- var[ , c("lifeExp", "pop", "gdpPercap")]
apply(var1, 2, mean)

for (i in var) {
  print(mean(i))
}

lapply(gapminder, mean)
sapply(gapminder, mean)


####################
##While Loops 

#Set an interator starting with 1954, use a while loop to calculate the standard deviation of log gdp for ever 3 years before 2002 (inclusive). 
#Make the read out so that it reads as "Year: standard deviation" (hint: see lecture notes for this particular format)
i <- 1954
while(i <= 2002) {
  sd_loggdp <- sd(gapminder$loggdp[gapminder$year == i], 
                  na.rm = T)
  print(paste0(i, ": ", sd_loggdp))
  i <- i + 3
}

####################
##Conditional Statements 

#Then create an if/else command that prints "Mean gdp per capita is less than 900" if the mean gdp per capita is less than 900 over all observed years. 
#Else, print the statement "Mean GDP per capita is greater than 900." 
if (mean(gapminder$gdpPercap) < 900){
  print("Mean gdp per capita is less than 900")
} else{
  print("Mean gdp per capita is greater than 900")
}


#Create a for loop with an if/else conditional: 
#Write a for loop that calculates the mean gdp per capita for each country over the observed years in the dataset. 
#If a given country's mean gdp per capita is greater than the median for all country-year observations, then print the country and its mean gdp per capita. 
#Else, print the country name and the statement "Sorry, this country does not meet the median threshold." 
for (i in countries){
  mean_gdpPercap <- mean(gapminder$gdpPercap[gapminder$country == i], na.rm = T)
  
  if (mean_gdpPercap>median(gapminder$gdpPercap, na.rm = T)){
    print(paste0(i, mean_gdpPercap))
  } else {
    print(paste0(i, "Sorry, this country does not meet the median threshold"))
  }
}


#####################
##Functions 

#Create a function called report_min_max to calculate the minimum and maximum log gdp (i.e. not per capita) for Europe. 
report_min_max <- 
  function(df, variable, continent){
    #subset
    var <- df[[variable]][df$continent == continent]
    min_log_gdp <- min(log(var))
    max_log_gdp <- max(log(var))
    cat("Continent:" , continent,
        "\nMin log gdp:", min_log_gdp,
        "\nMax log gdp:", max_log_gdp)
  }

report_min_max2 <- 
  function(df, variable, continent){
    var <- subset(df, df$continent == continent, select = c(variable))
    min_log_gdp <- min(log(var))
    max_log_gdp <- max(log(var))
    cat("Continent:" , continent,
        "\nMin log gdp:", min_log_gdp,
        "\nMax log gdp:", max_log_gdp)
  }


report_min_max(gapminder, "gdp", "Europe")

#####################
#Putting things all together. 

#Change the following function to conform to the following:
#1) Change the color to green (hint: the specification for color is `col`)
#2) Instead of a log x variable, use a squared x variable. 
#3) Run the function as we did in the exercise, but with the above new specifications for the year 1987. 

viz_lm <-
  function(df, dv, iv, year) {
    #same as gapminder[gapminder$year == 1977,]
    dat <- df[df[["year"]] == year, ]
    y <- log(dat[[dv]])
    x <- log(dat[[iv]])
    fit <- lm(y ~ x)
    plot(y ~ x, main = year,
         xlab = iv, ylab = dv)
    lines(x, predict(fit), col = 'blue')
  }

viz_lm(gapminder, "lifeExp", "gdpPercap", 1977)

