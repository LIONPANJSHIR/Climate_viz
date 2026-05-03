library(readr)
library(dplyr)
library(ggplot2)
library(showtext)
# font_add_google("Spectral", "Spectral")
# showtext_auto()
read_csv(
 "C:/Full_stack/R_studio/Climate_viz/data/GLB.Ts+dSST.csv",
 skip = 1,
 na = "***",
 show_col_types = FALSE
) |>
 select(Year, t_diff = `J-D`) |>
 ggplot(aes(x = Year, y = t_diff)) +
 
 geom_line(aes(color = "Annual mean"), linewidth = 0.7 ,show.legend = FALSE) +
 
 geom_point(aes(color = "Annual mean"), fill = "white", shape = 21, size = 1.5 , show.legend = TRUE) +
 
 geom_smooth(se = FALSE, aes(color = "Lowess smoothing"), linewidth = 0.5, span = 0.15 , show.legend = FALSE) +
 
 scale_x_continuous(
  breaks = seq(1880, 2025, 20),
  expand = c(0, 0)
 ) +
 
 scale_y_continuous(
  limits = c(-0.5, 1.5),
  expand = c(0, 0)
 ) +
 
 labs(
  x = "YEARS",
  y = "Temperature Anomaly (°C)",
  title = "GLOBAL LAND OCEAN TEMPERATURE INDEX",
  subtitle = "Data source: NASA GISS\nCredit: NASA/GISS"
 ) +
 scale_color_manual(labels  = c("Annual mean","Lowess smoothing") ,
                    values=c("gray","black") ,
                    name ="",
                    guide = guide_legend(override.aes = list(shape=15,size= 4)))+
 
 theme_light() +
 
 theme(
  legend.position = c(0.15,0.9),
  legend.margin = margin(b=10,r=0.5),
  legend.key.size = unit(0.4 ,'cm'),
  legend.key.spacing = unit(0.9,"mm"),
  legend.key.height  = unit(0.25,"cm"),
  # legend.text = element_text(family = "Spectral"),
  legend.background = element_blank(),
  axis.ticks = element_blank(),
  plot.title = element_text(
   color = "red4",
   face = "bold",
   margin = margin(b = 10)
  ),
  plot.title.position = "plot",
  plot.subtitle = element_text(size = 8)
 )


ggsave("C:/Full_stack/R_studio/Climate_viz/figures/Figure1.png",width = 6 , height = 4)
