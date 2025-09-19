library(leaflet)
library(sf)
library(dplyr)
library(rnaturalearth)
library(rgeoboundaries)
library(htmlwidgets)
# Chargement des régions françaises y compris DOM-TOM
regions_fr <- geoboundaries("FRA", adm_lvl = "adm1")

# Données simulées pour les régions
regions_data <- data.frame(
  region = c("Auvergne-Rhônes-Alpes","Bretagne","Grand Est","Hauts-de-France","Île-de-France","Normandie","Nouvelle-Aquitaine","Occitanie","Pays de la Loire","Provence-Alpes-Côte d'Azur"),
  valeur =  c(5,2,11,9,28,3,1,6,3,2))

regions_data$region <- c("Auvergne-Rhônes-Alpes","Bretagne","Grand Est","Hauts-de-France","Ile-de-France","Normandie","Nouvelle-Aquitaine","Occitanie","Pays de la Loire","Provence-Alpes-Côte d'Azur")

regions_data$valeur <- c(5,2,11,9,28,3,1,6,3,2)
regions_fr <- regions_fr %>% left_join(regions_data, by = c("shapeName" = "region"))

# Chargement des pays voisins
pays <- ne_countries(continent = "Europe", returnclass = "sf") %>%
  filter(name_long %in% c( "Belgium", "Germany", "Switzerland", "Netherlands"))

# Données simulées pour les pays
pays_data <- data.frame(
  name_long = c("Belgium", "Germany", "Switzerland", "Netherlands"),
  valeur = c(3,1, 0, 0)
)
pays <- pays %>% left_join(pays_data, by = "name_long")

# Création de palettes
pal_fr <- colorNumeric("Blues", domain = regions_fr$valeur)
pal_pays <- colorNumeric("Reds", domain = pays$valeur)

# Carte leaflet
carte <- leaflet() %>%
  addProviderTiles("CartoDB.Positron") %>%
  
  # Régions françaises
  addPolygons(
    data = regions_fr,
    fillColor = ~pal_fr(valeur),
    color = "grey", weight = 1,
    fillOpacity = 0.7,
    label = ~paste0(shapeName, ": ", valeur, " membres"),
    group = "Régions françaises"
  ) %>%
  
  # Pays voisins
  addPolygons(
    data = pays,
    fillColor = ~pal_pays(valeur),
    color = "black", weight = 1,
    fillOpacity = 0.4,
    label = ~paste0(name_long, ": ", valeur, " membres"),
    group = "Pays frontaliers"
  ) %>%
  
  # Légendes
  addLegend(pal = pal_fr, values = regions_fr$valeur, position = "bottomright", title = "Régions françaises") %>%
  addLegend(pal = pal_pays, values = pays$valeur, position = "bottomleft", title = "Pays frontaliers")

# Sauvegarde de la carte
saveWidget(carte, "carte_leaflet.html", selfcontained = TRUE)
library('Widget')
