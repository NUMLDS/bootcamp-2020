library(tidyverse)
library(janitor)


# I. data import ----------------------------------------------------------


acs = read_csv("data/nys_acs.csv") %>%
  clean_names()

school = read_csv("data/nys_schools.csv") %>%
  clean_names()


# II. EDA -----------------------------------------------------------------

str(acs)
str(school)

sum(is.na(acs))
sum(is.na(school))

# there are -99 values when they really should not be, and there are
# also NAs with -99


# III. data cleaning ------------------------------------------------------

school$district_name[school$district_name == -99] <- NA
school$per_free_lunch[school$per_free_lunch > 1 | school$per_free_lunch < 0] <- NA
school$per_lep[school$per_lep > 1 | school$per_lep < 0] <- NA
school$per_reduced_lunch[school$per_reduced_lunch > 1 | school$per_reduced_lunch < 0] <- NA
school$mean_ela_score[school$mean_ela_score < 100 | school$mean_ela_score > 800] <- NA
school$mean_math_score[school$mean_math_score < 100 | school$mean_math_score > 800] <- NA

school2 <- na.omit(school)


school2 <- school2 %>%
  mutate(total = per_free_lunch + per_reduced_lunch) 

quantile(school2$total, c(0.33,0.66))

school2 <- school2 %>%
  mutate(poverty = ifelse(total < 0.34, "Low", ifelse(total > 0.7, "High", "Medium"))) 

school2 <- school2 %>%
  group_by(year) %>%
  mutate(scaled_math = scale(mean_math_score),
         scaled_eng = scale(mean_ela_score)) 


# IV. data merging --------------------------------------------------------

school3 <- school2 %>%
  left_join(acs, by = c("county_name", "year"))

school3 <- school3[complete.cases(school3), ]

county1 <- school3 %>%
  group_by(county_name, year) %>%
  summarise(total_attendence = sum(total_enroll),
            total_freelunch = sum(total_enroll * per_free_lunch),
           total_reducelunch = sum(total_enroll * per_reduced_lunch),
             total_lep = sum(total_enroll * per_lep),
            math = mean(scaled_math),
            english = mean(scaled_eng),
           income = mean(na.omit(median_household_income)),
            bach = mean(na.omit(county_per_bach)),
           county_poverty = mean(county_per_poverty))

county1 <- county1 %>%
  mutate(school_poverty = (total_freelunch + total_reducelunch)/total_attendence,
                            education = math + english)

county1 %>%
  group_by(county_name) %>%
  summarise(poverty = mean(county_poverty),
            school_qualification = mean(school_poverty),
            math = mean(math),
            english = mean(english)) %>%
  arrange(desc(poverty)) %>%
  head(5)


county1 %>%
  group_by(county_name) %>%
  summarise(poverty = mean(county_poverty),
            school_qualification = mean(school_poverty),
            math = mean(math),
            english = mean(english)) %>%
  arrange(poverty) %>%
  head(5)


# VI. data visualization --------------------------------------------------

plot1 <- school3 %>%
  group_by(school_cd) %>%
  summarise(per_lunch = mean(per_free_lunch) + mean(per_reduced_lunch),
            english = mean(scaled_eng),
            math = mean(scaled_math))

plot1 <- pivot_longer(plot1, cols = c("english", "math"), names_to = "subject", values_to = "test_score")

ggplot(plot1, aes(per_lunch, test_score, color = subject)) + geom_point(alpha = 0.35) + geom_smooth(se = FALSE)

plot2 <- county1 %>%
  group_by(county_name) %>%
  summarise(county_poverty2 = mean(county_poverty),
            english = mean(english),
            math = mean(math))
quantile(plot2$county_poverty2, c(0.33, 0.66))
plot2$county_poverty2 <- ifelse(plot2$county_poverty2 < 0.11664, "Rich", ifelse(plot2$county_poverty2 > 0.1405, "Poor", "Medium"))
plot2 <- pivot_longer(plot2, cols = c("english", "math"), names_to = "subject", values_to = "test_score")

plot2$county_poverty2 <- as.factor(plot2$county_poverty2)
levels(plot2$county_poverty2) <- c("Poor", "Medium", "Rich")

ggplot(plot2, aes(county_poverty2, test_score, fill = subject)) + geom_boxplot()
