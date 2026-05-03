# =========================
# 📦 Import des librairies
# =========================
library(readr)   # Lecture de fichiers CSV optimisée (rapide + propre)
library(dplyr)   # Manipulation de données (select, filter, mutate, etc.)
library(ggplot2) # Système de visualisation graphique basé sur la grammaire des graphiques
library(showtext) # Gestion des polices externes (Google Fonts notamment)

# =========================
# 🔤 Gestion des polices (commentée ici)
# =========================
# font_add_google("Spectral", "Spectral")
# showtext_auto()
# → Permettrait d’utiliser une police Google dans le rendu ggplot
# → showtext_auto() active le rendu texte via showtext (important pour ggsave)

# =========================
# 📥 Chargement des données climatiques NASA GISS
# =========================
read_csv(
 "C:/Full_stack/R_studio/Climate_viz/data/GLB.Ts+dSST.csv",
 skip = 1,        # On ignore la première ligne (metadata du fichier)
 na = "***",      # Valeur manquante codée par "***" dans ce dataset
 show_col_types = FALSE # Supprime l'affichage des types de colonnes
) |>
 
 # =========================
# 🧹 Transformation des données
# =========================
select(
 Year,            # Année d’observation (variable temporelle)
 t_diff = `J-D`   # Anomalie température annuelle (Jan-Dec)
 # Renommage pour simplifier l’usage dans ggplot
) |>
 
 # =========================
# 📊 Construction du graphique ggplot
# =========================
ggplot(aes(x = Year, y = t_diff)) +
 
 # 🔵 Courbe principale : évolution annuelle brute
 geom_line(
  aes(color = "Annual mean"),
  linewidth = 0.7,
  show.legend = FALSE
 ) +
 
 # 🔴 Points annuels (valeurs observées)
 geom_point(
  aes(color = "Annual mean"),
  fill = "white",
  shape = 21,      # shape 21 = point avec bord + remplissage
  size = 1.5,
  show.legend = TRUE
 ) +
 
 # ⚫ Courbe lissée (tendance globale type LOWESS)
 geom_smooth(
  se = FALSE,      # pas d’intervalle de confiance affiché
  aes(color = "Lowess smoothing"),
  linewidth = 0.5,
  span = 0.15      # contrôle la sensibilité du lissage
 ) +
 
 # =========================
# 📏 Axe X (temps)
# =========================
scale_x_continuous(
 breaks = seq(1880, 2025, 20), # graduation tous les 20 ans
 expand = c(0, 0)              # supprime marges aux extrémités
) +
 
 # =========================
# 📏 Axe Y (anomalie température)
# =========================
scale_y_continuous(
 limits = c(-0.5, 1.5), # plage fixée pour homogénéiser la lecture
 expand = c(0, 0)
) +
 
 # =========================
# 🏷️ Labels (titre + axes)
# =========================
labs(
 x = "YEARS", # variable temporelle
 y = "Temperature Anomaly (°C)", # variable climatique (écart température)
 title = "GLOBAL LAND OCEAN TEMPERATURE INDEX",
 subtitle = "Data source: NASA GISS\nCredit: NASA/GISS"
) +
 
 # =========================
# 🎨 Gestion des couleurs (légende manuelle)
# =========================
scale_color_manual(
 labels = c("Annual mean", "Lowess smoothing"),
 values = c("gray", "black"),
 name = "", # pas de titre de légende
 guide = guide_legend(
  override.aes = list(
   shape = 15, # forme des symboles dans la légende
   size = 2
  )
 )
) +
 
 # =========================
# 🎨 Thème global
# =========================
theme_light() +
 
 theme(
  # 📍 Position de la légende (coordonnées relatives au plot)
  legend.position = c(0.1, 0.9),
  
  # 📐 Espacement autour de la légende
  legend.margin = margin(b = 10, r = 0.5),
  
  # 📦 Taille des cases de légende
  legend.key.size = unit(0.4, 'cm'),
  legend.key.spacing = unit(0.9, "mm"),
  legend.key.height = unit(0.25, "cm"),
  
  # 🧼 Fond de la légende supprimé pour design épuré
  legend.background = element_blank(),
  
  # ❌ Suppression des ticks (design minimaliste)
  axis.ticks = element_blank(),
  
  # 🧠 Titre du graphique (mise en forme typographique)
  plot.title = element_text(
   color = "red4",
   face = "bold",
   margin = margin(b = 10)
  ),
  
  # 📌 Position du titre alignée sur le plot complet
  plot.title.position = "plot",
  
  # 📝 Sous-titre plus discret (info secondaire)
  plot.subtitle = element_text(size = 8)
 )

# =========================
# 💾 Export du graphique
# =========================
ggsave(
 "C:/Full_stack/R_studio/Climate_viz/figures/Figure1.png",
 width = 6,
 height = 4
)