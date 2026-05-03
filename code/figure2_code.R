
# =========================
#  POLICE et package 
# =========================
library(readr)
# library(showtext)
library(ggtext)
library(ggplot2)
library(dplyr)
font_add_google("Merriweather", "merri")
showtext_auto()

# =========================
# 📦 IMPORT DES DONNÉES
# =========================
df <- read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***")



# =========================
# 🧹 NETTOYAGE DES DONNÉES
# =========================
df <- df |> na.omit()

# =========================
# 📊 DONNÉES POUR ANNOTATION DES EXTRÊMES (première et dernière année)
# =========================
annot <- df |> 
 select(year = Year, t_moy = `J-D`) |>
 arrange(year) |>
 slice(1, n()) |> 
 mutate(
  t_moy = 0,              # positionnement sur axe Y neutre
  x = year + c(-5, 5)     # décalage horizontal pour lisibilité
 )

# =========================
# 📉 FORMATAGE PRINCIPAL DU DATASET
# =========================
df <- df |> 
 select(year = Year, t_moy = `J-D`)

# =========================
# 🌡️ CALCUL DE L'ÉCART THERMIQUE (ΔT)
# =========================
past <- df |> 
 filter(year >= 1880, year <= 1900) |> 
 summarise(mean = mean(t_moy, na.rm = TRUE))

recent <- df |> 
 filter(year >= 2000) |> 
 summarise(mean = mean(t_moy, na.rm = TRUE))

deltaT <- format(round(recent$mean - past$mean, 1), nsmall = 1)

# =========================
# 🧾 TEXTE D'ANALYSE SCIENTIFIQUE (STORYTELLING)
# =========================
text <- glue::glue(
 "Entre le début de la série (fin XIXe siècle) et le milieu du XXe siècle (~1977),
les anomalies de température moyenne globale présentent une forte variabilité interannuelle,
sans tendance directionnelle clairement dominante. Cette phase est caractérisée par un équilibre
relatif entre forçages naturels (variabilité océan-atmosphère, activité solaire, volcanisme)
et débuts des perturbations anthropiques.

À partir de la fin des années 1970, une tendance ascendante robuste et persistante apparaît.
Celle-ci traduit un déséquilibre progressif du système climatique,
cohérent avec l’augmentation des concentrations atmosphériques en gaz à effet de serre d’origine anthropique.

ΔT moyen (1880–1900 vs 2000+) = {deltaT} °C"
)

# =========================
# 📌 IDENTIFICATION DES EXTRÊMES
# =========================
YT_min <- df |> 
 slice_min(t_moy, with_ties = TRUE)

YT_max <- df |> 
 slice_max(t_moy, with_ties = TRUE)

# =========================
# VISUALISATION PRINCIPALE
# =========================
df |> 
 ggplot(aes(x = year, y = t_moy, fill = t_moy)) +
 
 # barres temporelles
 geom_col(show.legend = FALSE) +
 
 # échelle de couleur (bleu → neutre → rouge)
 scale_fill_stepsn(
  colors = c("#0A295F", "gray", "darkred"),
  values = scales::rescale(c(min(df$t_moy), 0, max(df$t_moy))),
  limits = c(min(df$t_moy), max(df$t_moy)),
  n.breaks = 20
 ) +
 
 #  TITRE ET SOURCE
 labs(
  title = "Analyse de la température de surface GISS (v4)",
  caption = "Source : NASA GISS (GISTEMP v4)\nTraitement : R / tidyverse / ggplot2\nAuteur : Ly Amadou"
 ) +
 
 # annotations des années extrêmes (début/fin)
 geom_text(data = annot, aes(label = year, x = x), color = "gray", size = 4) +
 
 # 🌡️ message global ΔT
 geom_text(
  x = 1880, y = 1.1, hjust = 0,
  label = glue::glue(
   "La température moyenne globale entre {min(df$year)} et {max(df$year)} a augmenté de {deltaT}°C"
  ),
  color = "white",
  family = "merri",
  size = 4
 ) +
 
 # (storytelling principal)
 geom_text(
  x = 1880, y = 0.8,
  label = text,
  color = "white",
  family = "merri",
  hjust = 0,
  size = 4,
  lineheight = 0.45
  
 ) +
 
 # annotation minimum global
 geom_text(
  data = YT_min,
  aes(
   label = glue::glue("{year} Température minimale globale ({round(t_moy, 2)} °C)"),
   x = year + 10,
   y = t_moy - 0.11,
   hjust = 0
  ),
  color = "gray",
  lineheight = 0.5
 ) +
 
 # flèche vers maximum global
 geom_curve(
  data = YT_max,
  aes(
   x = year - 10, xend = year,
   y = t_moy, yend = t_moy - 0.01
  ),
  color = "gray",
  arrow = arrow(length = unit(0.16, "cm"), angle = 30, ends = "last", type = "closed"),
  linewidth = 0.1
 ) +
 
 # annotation maximum global
 geom_text(
  data = YT_max,
  aes(
   label = glue::glue("{year} Température maximale globale ({round(t_moy, 2)} °C)"),
   x = year - 10,
   y = t_moy + 0.11,
   hjust = 1
  ),
  color = "gray",
  lineheight = 0.5
 ) +
 
 #  flèche minimum global
 geom_curve(
  data = YT_min,
  aes(
   x = year + 10, xend = year,
   y = t_moy - 0.05, yend = t_moy - 0.01
  ),
  color = "gray",
  arrow = arrow(length = unit(0.16, "cm"), angle = 20, ends = "last", type = "closed"),
  angle = 80,
  curvature = -1,
  linewidth = 0.1
 ) +
 
 #  rupture visuelle 1976
 geom_vline(
  xintercept = 1976,
  color = "darkred",
  linetype = "dashed",
  linewidth = 0.1
 ) +
 
 # ➖segment 1977–2025
 geom_curve(
  aes(
   x = 1977, xend = max(df$year),
   y = -0.1, yend = -0.1
  ),
  arrow = arrow(length = unit(0.2, "cm"), ends = "both"),
  colour = "gray",
  angle = 180,
  linetype = "dashed",
  linewidth = 0.07
 ) +
 
 # ️ label période
 geom_text(x = 2001, y = -0.05, aes(label = "1977-2025"), color = "gray" ) +
 
 #  thème minimal + fond noir
 theme_void(base_family = "merri") +
 
 theme(
  plot.background = element_rect(fill = "black"),
  plot.title = element_text(colour = "white", family = "merri", face = "bold"),
  plot.caption = element_text(colour = "white", hjust = 1, lineheight = 0.8),
  plot.caption.position = "plot"
 )

# =========================
# 💾 EXPORT DU GRAPHIQUE
# =========================
ggsave("figures/figures2.png", width = 6, height = 4)

