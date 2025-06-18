library(dplyr)
library(readr)

data <- readRDS("data/interim/price_house_clean_base.Rds")

cat("\n Donnée depuis price_house_clean_base dans interim, \n")

na_count <- colSums(is.na(data))
na_summary <- sort(na_count[na_count > 0], decreasing = TRUE)

cat("\n Colonnes avec valeurs manquantes :\n")
print(na_summary)

threshold <- 0.3
na_ratio <- colMeans(is.na(data))
vars_to_drop <- names(na_ratio[na_ratio > threshold])
if (length(vars_to_drop) > 0) {
  cat("\n Colonnes à supprimer (plus de", threshold * 100, "% de NA) :\n")
  print(vars_to_drop)
  
  data <- data %>%
    select(-all_of(vars_to_drop))
} else {
  cat("\n Aucune colonne à supprimer.\n")
}

cat("\n Suppression des colonnes avec plus de 30% de NA :\n")
print(vars_to_drop)

data_clean <- data %>% select(-all_of(vars_to_drop))

data_clean <- data_clean %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), median(., na.rm = TRUE), .)))

most_common <- function(x) {
  ux <- na.omit(x)
  ux[which.max(tabulate(match(x, ux)))]
}

data_clean <- data_clean %>%
  mutate(across(where(is.character), ~ ifelse(is.na(.), most_common(.), .)))

data_clean <- data_clean %>%
  mutate(across(where(is.character), as.factor))

before <- nrow(data_clean)
data_clean <- distinct(data_clean)
after <- nrow(data_clean)

cat("\n Suppression des doublons :", before - after, "lignes enlevées\n")

if (!dir.exists("data/clean")) dir.create("data/clean", recursive = TRUE)

saveRDS(data_clean, "data/clean/price_house_clean_ready.Rds")
write.csv(data_clean, "data/clean/price_house_clean_ready.csv", row.names = FALSE)

cat("\n Données nettoyées sauvegardées dans data/clean/\n")