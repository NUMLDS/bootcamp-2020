library(tidyverse)

generation <- read_csv("../data/ca_energy_generation.csv")
imports <- read_csv("../data/ca_energy_imports.csv")

# using dplyer
# gather -> make data long
# spread -> make data wide
# gather(df, 
  # key = new column name, 
  # value = new numbers in that column)

long_gen <- gather(generation, key = source, value = usage, -datetime)
head(long_gen)
head(long_gen[order(long_gen$datetime), ])

spread(long_gen, key = source, value = usage) %>% slice(1:5)

# reshape2
# melt
# cast

merged_energy <- merge(generation, imports, by = "datetime")
long_merged_energy <- gather(merged_energy, key = source, value = usage, -datetime)
dim(long_merged_energy)



