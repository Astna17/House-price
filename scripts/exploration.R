# install.packages(c("dplyr", "readr", "skimr"))
library(dplyr)
library(readr)
library(skimr)

data <- read_csv("data/raw/house_price.csv")

cat("Dimensions du dataset :\n")
print(dim(data))

cat("\nAperçu structure (glimpse) :\n")
glimpse(data)

cat("\nRésumé global avec skimr :\n")
print(skim(data))

cat("\nRésumé des variables numériques :\n")
data %>%
  select(where(is.numeric)) %>%
  skim() %>%
  print()

cat("\nVariables avec NA :\n")
na_count <- colSums(is.na(data))
print(na_count[na_count > 0])

if (!dir.exists("data/interim")) dir.create("data/interim", recursive = TRUE)

saveRDS(data, file = "data/interim/price_house_clean_base.Rds")
