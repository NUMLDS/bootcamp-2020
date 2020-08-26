############ MSiA Boot Camp: Day 6 Exercises - ANSWER KEY #############
######### by Ali Ehlen                                   ##########

# data.table exercises

# load the package
library(data.table)

# path to data
data_file <- here::here("data", "ca_energy_generation.csv")

# read in two versions of data, one as a data.frame and one as a data.table
generation_df <- read.csv(data_file, stringsAsFactors = F)

generation_dt <- fread(data_file)

# look at the class of each
class(generation_df) 
class(generation_dt) 

# what are the differences between these two objects?
View(generation_df)
View(generation_dt)
generation_df
generation_dt
str(generation_df)
str(generation_dt)

# `data.table` syntax

# `i`: "on which rows" (row filtering)
generation_dt[wind > 4400]
generation_dt[wind > 4400 & mday(datetime) == 7]

# try it!
# select rows for which natural gas generation is less than or equal to 
# 5,000 MW and large hydro generation is greater than 2,000 MW
generation_dt[natural_gas <= 5000 & large_hydro > 2000]

# select rows for which solar generation is greater than coal generation
generation_dt[solar > coal]

# bonus: select rows for which coal generation is greater than 10 MW and 
# solar generation is greater than the median value of solar generation
generation_dt[coal > 10 & solar > median(solar)]

# `j` "what to do" (column operations) 
generation[,wind]
generation[,wind + solar]
generation_dt[,3*wind + solar*biogas/2]
generation_dt[,mean(nuclear)]

# `j` "what to do" (column operations) - assignment
generation_dt[,morewind := 5*wind]
generation_dt[,all_RE := wind+solar+geothermal]
generation_dt[,morewind := 5*morewind + 10]

generation_dt[,.(wind)]
generation_dt[,.(RE_combo = 3*wind + solar*biogas/2)]
generation_dt[,.(RE_combo = 3*wind + solar*biogas/2,
                 high_wind = morewind)]

# `j` "what to do" (column operations)

#  add a column to generation_dt called "total_hydro" that is the sum of the 
# `small_hydro` and `large_hydro` 
generation_dt[,total_hydro := small_hydro + large_hydro]

# return a new `data.table` with two columns: the mean of `nuclear` and the 
# mean of `biogas`. What happens when you don't name those columns?
generation_dt[,.(mean_nuc = mean(nuclear), mean_biogas = mean(biogas))]
generation_dt[,.(mean(nuclear), mean(biogas))]

# combining `i` and `j`
# for the hours (rows) when wind generation is greater then 4,500 MW, add 500 
# to the values of small_hydro

generation_dt[wind > 4500, small_hydro := small_hydro + 500]

# when solar generation is zero, reurn a `data.table` with two columns: 
# `datetime` and `total_thermal` (sum of natural gas and coal generation)

generation_dt[solar == 0, .(datetime, total_thermal = natural_gas + coal)]

# use `:=` to create a new column called more_solar (which is 9 times the 
# values in the solar column) but only for hours where solar > 0. What happens 
# in the other rows?
  
generation_dt[solar > 0, more_solar := solar*9]

# This will fill in the rest of the rows (where solar > 0 is not true) with NA.

# deleting columns
generation_dt[,morewind := NULL]
generation_dt[,all_RE := NULL]

# `by`: "grouped by what"

# what does this line do?
generation_dt[,mean(nuclear), by = mday(datetime)]

# how can you add more useful names to these columns?
generation_dt[,.(mean_nuc = mean(nuclear)), by = .(day = mday(datetime))]

# melt generation_dt
generation_dt_long <- melt(generation_dt, 
                           id.vars = "datetime", 
                           variable.name = "gen_type", 
                           value.name = "MW")

# do you get a warning message? what is that warning message about? 
# (hint: check str(generation_dt)). How could this be avoided in the future?
  
# find the mean of MW by gen_type...
generation_dt_long[,.(mean_MW = mean(MW)), by = gen_type]

# or by day and by gen_type...
generation_dt_long[,.(mean_MW = mean(MW)), 
                   by = .(day = mday(datetime), gen_type)]

# note that by accepts: a single column name, a list, or a character vector 

# find the mean and sum of generation for each day, for all resources  
# EXCEPT natural gas
generation_dt_long[gen_type != "natural_gas",
                   .(mean_MW = mean(MW), sum_MW = sum(MW)), 
                   by = mday(datetime)]
  
## `by`: "grouped by what"

# find the median solar generation by hour.

# for hours when the solar generation is greater than zero, find the maximum 
# natural gas generation by day

## `by` exercises
  
# find the median solar generation by hour. 
generation_dt[,median(solar), by = mday(datetime)]

# this is also possible to do with the long form of the generation_dt 
generation_dt_long[gen_type == "solar", median(MW), by = mday(datetime)]

# find the median solar generation by hour. 
generation_dt[solar > 0, max(natural_gas), by = mday(datetime)]


## `dplyr` -> `data.table`

# Convert this `dplyr` syntax into `data.table` syntax (remember that this 
# melted the generation table, then found the mean of large_hydro and biomass 
# generation)
generation_dt %>% 
  select(datetime, large_hydro, biomass) %>% 
  melt(id.vars = "datetime",
       variable.name = "source",
       value.name = "usage") %>% 
  group_by(source) %>% 
  summarize(mean_usage = mean(usage, na.rm = T))

# data.table version here:
generation_dt_long <- melt(generation_dt, 
                           id.vars = "datetime", 
                           variable.name = "gen_type", 
                           value.name = "MW")

generation_dt_long[gen_type %in% c("large_hydro", "biomass"),
                   .(mean_usage = mean(MW)),
                   by = gen_type]

# Special variables

# Use `.N` to find the number of rows in generation_dt_long
generation_dt_long[,.N]

# Use `.N` to find the number of hours in which solar generation was greater than 500 MW
generation_dt[solar > 500, .N]
# or
generation_dt_long[gen_type == "solar" & MW > 500,.N]

# Join practice

# read in import data
imports_dt <- fread(here::here("data", "ca_energy_imports.csv"))

# join with generation_dt on datetime column
imports_dt[generation_dt, on = "datetime"]

# modify in-place
imports_dt[generation_dt, on = "datetime", imports_gas := imports + i.natural_gas]

# add complexity
imports_dt[generation_dt[hour(datetime) == 2], on = "datetime", 
           imports_gas_2 := imports + i.natural_gas]
