
---

# 🌍 Global Temperature Analysis 

## 📌 Description du projet

Ces projets vise à analyser et visualiser l’évolution des anomalies de température moyenne globale (terres et océans) à partir des données de la NASA GISS (GISTEMP v4), mais aussi d'autre données qui traitement sur l'évolution spatio-temporel de la température ou autres indicateurs liées de près ou de loin au réchauffement climatique (À venir ) 

L’objectif est de transformer une série temporelle climatique brute en une **visualisation interprétable et narrative**, mettant en évidence les grandes dynamiques du système climatique.

---

## 🎯 Objectifs

* Étudier l’évolution des anomalies de température globale
* Identifier les tendances longues du système climatique
* Construire un **storytelling scientifique visuel**
* Développer des compétences en data visualisation avec R

---

## 📊 Données utilisées (Évolutifs)

* **Source :** NASA Goddard Institute for Space Studies (GISS)
* **Dataset :** GISTEMP v4
* **Période :** 1880 → aujourd’hui
* **Variable principale :** anomalies de température globale (°C)

---

## 🛠️ Stack technique (Évolutifs )

* R
* tidyverse (dplyr, readr)
* ggplot2
* ggtext
* showtext
* glue

---

## 🧠 Méthodologie

1. **Chargement des données**

   * Import CSV NASA GISS
   * Nettoyage des valeurs manquantes  

2. **Transformation**

   * Sélection des variables pertinentes
   * Calcul des moyennes historiques
   * Estimation du ΔT (différence inter-périodes)

3. **Analyse exploratoire**

   * Identification des années extrêmes
   * Mise en évidence des tendances longues

4. **Visualisation**

   * Série temporelle en barres colorées
   * Gradient thermique (bleu → rouge)
   * Annotations scientifiques
   * Mise en récit des grandes phases climatiques

---

## 📈 Résultats principaux

* Forte variabilité climatique avant 1970
* Transition progressive du système climatique au milieu du XXe siècle
* Accélération nette du réchauffement après ~1970–1980
* Augmentation significative des anomalies de température globale de la surface de le terre 

---

## 🧭 Interprétation scientifique (storytelling)

L’analyse met en évidence trois régimes principaux :

### 🧊 1880–~1940 : variabilité naturelle dominante

Le système climatique est principalement contrôlé par des facteurs naturels, sans tendance globale forte.

### ⚖️ ~1940–1970 : phase de transition

Les premiers effets anthropiques deviennent perceptibles mais restent masqués par la variabilité naturelle.

### 🔥 Post-1970–1980 : réchauffement global dominant

Une tendance ascendante robuste apparaît, indiquant la dominance du forçage anthropique (gaz à effet de serre).

---

## 📉 Indicateur clé

Variation moyenne de température globale :

ΔT (1880–1900 vs 2000+) ≈ **+1.0 °C** ou deta(T) = **T_{final} - T_{début}**  mais cette dernière n'est pas trop solide scientifiquement parlant 

---

## 🖼️ Visualisation

Le graphique combine :

* Série temporelle annuelle
* Gradient thermique (froid → chaud)
* Annotations des extrêmes climatiques
* Mise en évidence d’une rupture structurelle (~1977)

---

## 🚀 Perspectives

* Détection automatique de ruptures (changepoint analysis)
* Modélisation de tendance (régression segmentée)
* Comparaison multi-sources (NASA vs NOAA)
* Extension vers un dashboard interactif

---

## 👤 Auteur

**Ly Amadou**
Étudiant en  PCSTM (Physique chimie Science de la Terre et Mécanique ) 
Intérêts : IA, machine learning, climat, modélisation de données ,Energie,Finance

---

## 📌 Note

Ce projet est une exploration personnelle visant à améliorer mes compétences en :

* analyse de données climatiques
* visualisation scientifique
* storytelling basé sur des données réelles

---
