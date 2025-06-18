## US01 – Collecte des données

**Source :** [House Prices – Advanced Regression Techniques (Kaggle)](https://www.kaggle.com/competitions/house-prices-advanced-regression-techniques)

**Fichiers récupérés :**
- `house_price` – Données avec `SalePrice` (1460 lignes)

**Étapes :**
- Téléchargement manuel des données depuis Kaggle
- Fichiers placés dans `data/raw/`


##  US02 – Exploration initiale

###  Objectif
Explorer les données brutes pour comprendre la structure du dataset (`house_price.csv`), identifier les types de variables, les valeurs manquantes, et produire un résumé statistique de base.

###  Fichier analysé
- `data/raw/house_price.csv`

###  Étapes réalisées
- Chargement des données avec `readr::read_csv()`
- Aperçu rapide avec `dim()` et `dplyr::glimpse()`
- Résumé statistique global avec `skimr::skim()`
- Résumé ciblé des variables numériques
- Comptage des valeurs manquantes avec `colSums(is.na())`
- Sauvegarde d’une copie de travail propre au format `.Rds`

###  Données sauvegardées
- `data/interim/price_house_clean_base.Rds` – pour une utilisation propre dans les étapes suivantes

###  Packages utilisés
- `readr`, `dplyr`, `skimr`

###  Ce qui a été retiré
- `summarytools` a été supprimé pour éviter des erreurs liées aux dépendances système lors de l’installation sous Linux.


##  US03 – Nettoyage des données

###  Objectif
Nettoyer les données du fichier `price_house_clean_base.Rds` pour préparer l’analyse statistique et les modèles.

###  Source
- `data/interim/price_house_clean_base.Rds`

###  Étapes réalisées
- Analyse des valeurs manquantes avec `colSums(is.na())`
- Suppression automatique des colonnes contenant plus de 30% de valeurs manquantes (aucune trouvée)
- Imputation des valeurs manquantes (aucune détectée)
- Conversion des colonnes `character` en `factor`
- Détection et suppression des doublons (aucun trouvé)
- Sauvegarde du jeu de données nettoyé en `.Rds` et `.csv`

###  Fichiers générés
- `data/clean/price_house_clean_ready.Rds`
- `data/clean/price_house_clean_ready.csv`

###  Packages utilisés
- `dplyr`, `readr`