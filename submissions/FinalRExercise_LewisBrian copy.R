# Header ------------------------------------------------------------------
rm(list = ls())
data   <- file.path('~/git/bootcamp-2020/data')
export <- file.path('~/git/bootcamp-2020/export/') 

# Libraries
library(dplyr)
library(tidyr)
library(stringr)
library(readr)
library(ggplot2)
library(glue)
library(purrr)
library(broom)
library(knitr)

# Function to calculate mode of categorical variable
cat_mode <- function(x) {
  uniqx <- unique(na.omit(x))
  uniqx[which.max(tabulate(match(x, uniqx)))]
}

# Task 1: Import ----------------------------------------------------------

sch_raw <- read_csv(file.path(data, 'nys_schools.csv'))
acs_raw <- read_csv(file.path(data, 'nys_acs.csv'))

# Task 2: EDA -------------------------------------------------------------

head(sch_raw)
summary(sch_raw)
head(acs_raw)
summary(acs_raw)

# Task 3: Clean/Process ---------------------------------------------------

# Resolve '-99' values and standardize scores
sch <- sch_raw %>% 
  na_if(-99) %>% 
  group_by(year) %>% 
  mutate(ela_z_score  = scale(mean_ela_score),
         math_z_score = scale(mean_math_score)) %>% 
  # Filter out school observations with no data on enrollment. Simplifies things later down the road
  filter(!is.na(total_enroll))

# Categorize poverty groups based on distribution. 
# Poverty Quartiles (25th, 50th, 75th): .10903, .12884, .14929. "Medium" falls approx between 25th and 75th.
# Categories are only representative of relative differences within the dataset (e.g. "Medium" in this dataset could be "Low" in a different region).
acs <- acs_raw %>% 
  mutate(poverty_level = case_when(county_per_poverty <= .1 ~ "Low",
                                   county_per_poverty > .1 & county_per_poverty <= .15 ~ "Medium",
                                   county_per_poverty > .15 ~ "High"))
# Task 4: Merge Datasets --------------------------------------------------

merged <- full_join(acs, sch, by = c("county_name", "year"))

# Task 5: Summary Tables --------------------------------------------------

county_sum <- merged %>% 
  # Chose to summarize by county and year since enrollment is rolling -- many of the same students year-to-year.
  group_by(county_name, year) %>% 
  summarise(total_enrollment       = sum(total_enroll, na.rm = T),
            perc_free_lunch        = weighted.mean(per_free_lunch, total_enroll, na.rm = T),
            perc_red_lunch         = weighted.mean(per_reduced_lunch, total_enroll, na.rm = T),
            # Because it's "OR" and these are mutually exclusive, sum them for full set.
            perc_free_or_red_lunch = sum(perc_free_lunch, perc_red_lunch),
            perc_poverty           = mean(county_per_poverty),
            # Some counties will show NA for these because the 'total_enroll' weighted value has missing values.
            mean_ela_z_score       = weighted.mean(ela_z_score, total_enroll, na.rm = T),
            mean_math_z_score      = weighted.mean(math_z_score, total_enroll, na.rm = T)) %>% 
  ungroup()

county_metrics <- county_sum %>% 
  select(-perc_free_lunch, -perc_red_lunch, -mean_ela_z_score, -mean_math_z_score)

county_outliers <- county_sum %>% 
  select(county_name, year, perc_poverty, perc_free_or_red_lunch, mean_ela_z_score, mean_math_z_score) %>% 
  group_by(year) %>% 
  mutate(outlier = case_when(quantile(perc_poverty, 0.95, na.rm = TRUE) <= perc_poverty ~ "Highest 5th Percentile in Poverty",
                             quantile(perc_poverty, 0.05, na.rm = TRUE) >= perc_poverty ~ "Lowest 5th Percentile in Poverty",
                             TRUE ~ NA_character_)) %>% 
  filter(!is.na(outlier)) %>% 
  arrange(year, desc(perc_poverty)) %>% 
  ungroup()

# Task 6: Data Visualization ----------------------------------------------

# School-level charts:
# Relationship between free/reduced lunch and test performance, at the school level
school_level <- merged %>% 
  group_by(school_name) %>% 
  summarise(perc_free_lunch        = weighted.mean(per_free_lunch, total_enroll, na.rm = T),
            perc_red_lunch         = weighted.mean(per_reduced_lunch, total_enroll, na.rm = T),
            # Because it's "OR" and these are mutually exclusive, sum them for full set.
            perc_free_or_red_lunch = sum(perc_free_lunch, perc_red_lunch),
            mean_ela_z_score       = weighted.mean(ela_z_score, total_enroll, na.rm = T),
            mean_math_z_score      = weighted.mean(math_z_score, total_enroll, na.rm = T)) %>% 
  select(-perc_free_lunch, -perc_red_lunch) %>% 
  ungroup()

# School Data Viz
school_charting <- function(score_var, score_text, save_name) {

  score_var  <- ensym(score_var)
    
  plot <- ggplot(school_level,
         aes(x = perc_free_or_red_lunch,
             y = !!score_var)) +
    scale_y_continuous(breaks = seq(-2.5, 2.5, 0.5),
                       limits = c(-2.5, 2.5)) +
    geom_point(shape = 20) +
    geom_smooth(method = lm) +
    scale_x_continuous(labels = function(x) paste0(x*100, "%"),
                       limits = c(0,1)) +
    labs(title    = glue("Mean Scaled {score_text} Scores v. \n % of Students Receiving Free/Reduced Lunch"),
         subtitle = "By School",
         y        = glue("Mean Scaled {score_text} Scores (Z-Score)"),
         x        = "Students Receiving Free/Reduced Lunch (%)") +
    theme(plot.title    = element_text(color = "black", size = 12, face = "bold", hjust = 0.5),
          plot.subtitle = element_text(color = "black", size = 11, hjust = 0.5))
    
    ggsave(paste0(export, save_name, '.pdf'))
    rstudioapi::viewer(paste0(export, save_name, '.pdf'))
  
}

args <- list(c("mean_ela_z_score", "mean_math_z_score"),
             c("ELA", "Math"),
             c("ela_score", "math_score"))

pmap(args, school_charting)

# County-level charts:
county_level <- merged %>% 
  group_by(county_name) %>% 
  summarise(poverty_level     = cat_mode(poverty_level),
            poverty_perc      = mean(county_per_poverty, na.rm = TRUE),
            mean_ela_z_score  = weighted.mean(ela_z_score, total_enroll, na.rm = T),
            mean_math_z_score = weighted.mean(math_z_score, total_enroll, na.rm = T)) %>% 
  ungroup() %>% 
  filter(!is.na(poverty_level))

# County Data Viz
county_charting <- function(score_var, score_text, save_name) {
  
  score_var  <- ensym(score_var)
  
  plot <- ggplot(county_level,
                 aes(x    = !!score_var,
                     fill = poverty_level)) +
    xlim(-1, 1) +
    geom_density(alpha = 0.5) +
    # geom_smooth(method = lm, se = FALSE) +
    labs(title    = glue("Mean Scaled {score_text} Scores by Poverty Level"),
         subtitle = "By County",
         x        = glue("Mean Scaled {score_text} Scores (Z-Score)"),
         y        = "Score Density",
         fill     = "Poverty Level"
         # ,
         # caption  = "Note:  'Poverty Level' categories represent the mode of county-year poverty level observations. \n 
         #             These categories represent the approximate poverty distribution of each county in New York State \n 
         #            (e.g. 'Low' ~ 1-25th percentile, 'Medium' ~ 26-75th percentile, High' ~ 76-99th percentile."
         ) +
    theme(plot.title    = element_text(color = "black", size = 12, face = "bold", hjust = 0.5),
          plot.subtitle = element_text(color = "black", size = 11, hjust = 0.5),
          plot.caption  = element_text(color = "black", size = 10))
  
  ggsave(paste0(export, save_name, '.pdf'))
  rstudioapi::viewer(paste0(export, save_name, '.pdf'))
  
}

args <- list(c("mean_ela_z_score", "mean_math_z_score"),
             c("ELA", "Math"),
             c("county_ela_score", "county_math_score"))

pmap(args, county_charting)

# Task 7: Answering Questions ---------------------------------------------

# Q1: What can the data tell us about the relationship between poverty and test performance in the New York public schools?
# A1: It's clear that there's a strong relationship between poverty and poor test performance. 
#     The R-squared is near 0.4 and p-value is highly significant at the most precise levels for both ELA and math tests.

# ela_model  <- 
  lm(mean_ela_z_score  ~ poverty_perc, data = county_level) %>% summary()

# math_model <- 
  lm(mean_math_z_score ~ poverty_perc, data = county_level) %>% summary()

# Q2: Has this relationship changed over time?
# A2: Yes. It does seem to be getting better. 
#     It appears that poverty level seems to matter less in test score correlations through time.
  
ela_by_year <- merged %>%
  filter(year > 2008,
         year < 2017) %>% 
  group_by(year) %>% 
  do(thing = tidy(lm(ela_z_score ~ county_per_poverty, data = .))) %>% 
  unnest(thing) %>% 
  filter(term == "county_per_poverty")

math_by_year <- merged %>%
  filter(year > 2008,
         year < 2017) %>% 
  group_by(year) %>% 
  do(thing = tidy(lm(math_z_score ~ county_per_poverty, data = .))) %>% 
  unnest(thing) %>% 
  filter(term == "county_per_poverty")

# Q3: Is this relationship at all moderated by access to free/reduced price lunch?
# A3: It appears so, yes. It appears that the coefficients for poverty and free lunch are both significant, 
#     and moving in opposite directions.

ela_by_year_lunch <- merged %>%
  filter(year > 2008,
         year < 2017) %>% 
  group_by(year) %>% 
  do(thing = tidy(lm(ela_z_score ~ county_per_poverty + per_free_lunch + per_reduced_lunch, data = .))) %>% 
  unnest(thing) %>% 
  filter(!str_detect(term, "Intercept"))

math_by_year_lunch <- merged %>%
  filter(year > 2008,
         year < 2017) %>% 
  group_by(year) %>% 
  do(thing = tidy(lm(math_z_score ~ county_per_poverty + per_free_lunch + per_reduced_lunch, data = .))) %>% 
  unnest(thing) %>% 
  filter(!str_detect(term, "Intercept"))
  