library(stats)

# settings
set.seed(4653284)
n <- 120

# generate data
treatment_group <- rnorm(n, mean = 5, sd = 1)
control_group <- rnorm(n, mean = 4, sd = 1)
#
baseline_stress <- rnorm(n, mean = 5, sd = 1)
one_year_stress <- baseline_stress + rnorm(n, mean = 0.3, sd = 1)
# NA
baseline_stress_NA <- c(NA, NA, NA, 5, 5, 5, baseline_stress)
one_year_stress_NA <- c(NA, NA, NA, NA, NA, NA, one_year_stress)


# build data.frame
df_cancer <- data.frame(
  treatment_group = treatment_group,
  control_group = control_group
)
df_stress <- data.frame(
  baseline_stress = baseline_stress,
  one_year_stress = one_year_stress
)
df_stress_NA <- data.frame(
  baseline_stress_NA = baseline_stress_NA,
  one_year_stress_NA = one_year_stress_NA
)

# save data frame --------------------------------------------------------------
## csv
write.csv(df_stress, "data/df_stress.csv")
write.csv(df_stress_NA, "data/df_stress_NA.csv")
write.csv(df_cancer, "data/df_cancer.csv")

## txt
write.table(df_stress, "data/df_stress_tab.txt", sep = "\t", col.names = TRUE)
write.table(df_stress, "data/df_stress_space.txt", sep = " ", col.names = TRUE)
write.table(df_stress, "data/df_stress.txt", sep = ";", col.names = TRUE)

