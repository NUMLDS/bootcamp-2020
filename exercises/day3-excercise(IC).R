gapminder <- read.csv("data/gapminder5.csv")
head(gapminder)
str(gapminder)
mean(gapminder$lifeExp[gapminder$country == "Afghanistan"])
mean(gapminder$lifeExp[gapminder$country == "Albania"])
obs <- 1:nrow(gapminder)
for (i in obs) {
  gapminder[i, "gdp"] <-
    gapminder[i, "pop"] * gapminder[i, "gdpPercap"]
}
head(gapminder)
str(gapminder)
for (i in obs) {
  gapminder[i, "log_pop"] <- log(gapminder[i, "pop"])
  gapminder[i, "log_gdpPercap"] <- log(gapminder[i, "gdpPercap"])
}
head(gapminder)


years <- unique(gapminder$year)
for (i in years) {
  mean_le <- mean(gapminder$lifeExp[gapminder$year == i],
                  na.rm = T)
  print(paste0(i, " - ", mean_le))
}

continents <- unique(gapminder$continent)
for (i in continents) {
  mean_le <- mean(gapminder$lifeExp[gapminder$continent == i],
                  na.rm = T)
  print(paste0(i, " - ", round(mean_le, 2)))
}

for (i in continents) {
  print(paste0(i))
  for (j in years) {
    mean_le <- mean(gapminder$lifeExp[gapminder$continent == i
                                      &
                                        gapminder$year == j],
                    na.rm = T)
    print(paste0(j, " : ", round(mean_le, 2)))
  }
}

for (i in continents) {
  print(paste0(i))
  for (j in years) {
    sd_le <- sd(gapminder$lifeExp[gapminder$continent == i
                                  &
                                    gapminder$year == j],
                na.rm = T)
    print(paste0(j, " : ", round(sd_le, 2)))
  }
}

vars <- gapminder[, c("lifeExp", "year")]
apply(vars, 2, sd)

lapply(gapminder, mean)
sapply(gapminder, mean)

i <- 1952
while (i < 1987) {
  sd_le <- sd(gapminder$lifeExp[gapminder$year == i])
  print(paste0(i, " : ", round(sd_le, 2)))
  i <- i + 5
}

i <- 1987
while (i <= 2002) {
  sd_le <- sd(gapminder$lifeExp[gapminder$year == i])
  print(paste0(i, " : ", round(sd_le, 2)))
  i <- i + 1
}

random_year <- sample(years, 1)
print(random_year)

if (random_year > 1977) {
  print("yar!")
}

set.seed(1)
random_year <- sample(years, 1)
if (random_year > 1977) {
  print(random_year)
} else{
  print("sorry, random year is less than 1977")
}

get_values <-
  function(df, variable = "continent") {
    vals <- unique(df[[variable]])
    print(paste0(variable, " : ", vals))
  }

get_values(gapminder)

report_mean_sd<-
  function(df,variable,country){
    var<-df[[variable]][df$country==country]
    m_le<-mean(var)
    sd_le<-sd(var)
    cat("Country:",country,
        "\nMean Life Expectancy:", round(m_le,2),
        "\nSD Life Expectancy:", round(sd_le,2))
  }
report_mean_sd(gapminder,"lifeExp","Bulgaria")


report_4m<-
  function(df,variable,continent){
    vec<-df[[variable]][df$continent==continent]
    mean=mean(vec)
    median=median(vec)
    min=min(vec)
    max=max(vec)
  cat("Continent: ",continent,
      "\nMinimum: ",min,
      "\nMax: ",max)
  }
report_4m(gapminder,"lifeExp","Europe")

