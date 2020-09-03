library(tidyverse)
library(janitor)
gapminder <- read_csv("C:/Users/Allen/Desktop/MSiA/boot camp 082620/data/gapminder5.csv") %>%
    clean_names()

y <- '2002'
x <- sum(str_detect(gapminder$year, y))

if(x > 0){
    print(paste("Yes", "there is a total of", x, "entries of", y))
} else {
    print("no entries")
}

head(generation)
gathered <- gather(generation, key = source, value = usage, -datetime)
