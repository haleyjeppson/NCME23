## ----setup, include=FALSE-------------------------------------------------------------------
## ----eval = FALSE, echo = TRUE--------------------------------------------------------------
## my_packages <- c("rmarkdown", "knitr", "tidyverse", 'patchwork',
##                  "cowplot",  'colorspace', 'ggtext', 'ggokabeito',
##                  'ggthemes', 'ggdist', 'GGally', 'ggrepel', 'ggpubr',
##                  'ggstatsplot', 'ggdag', 'plotly', 'ggiraph')
## install.packages(my_packages)
## install.packages("devtools")
## devtools::install_github("haleyjeppson/NCME23data")
## devtools::install_github("kassambara/ggcorrplot")


## ----echo = TRUE, echo = TRUE---------------------------------------------------------------
# General use packages:
library(tidyverse)
library(NCME23data)


## ----echo = TRUE----------------------------------------------------------------------------
# install.packages("ggplot2")
library(ggplot2)


## ----echo = TRUE----------------------------------------------------------------------------
# install.packages("tidyverse")
library(tidyverse)


## ----plots-3, echo = FALSE, fig.align='bottom', fig.height=5, fig.width=15------------------
library(ggplot2)
data(diamonds)
p1 <- ggplot(diamonds, aes(cut, fill=cut)) + 
  geom_bar() + 
  labs(title = "Bar Chart", subtitle = "Cartesian coordinates") +
  scale_fill_brewer(palette = "Set2", direction = -1) + 
  theme_minimal()

p2 <- ggplot(diamonds, aes(factor(1), fill=cut)) +
  geom_bar(width=1) + 
  labs(x="", title = "Fill-Bar", subtitle = "Cartesian coordinates") +
  scale_fill_brewer(palette = "Set2", direction = -1) + 
  theme_minimal()

p3 <- ggplot(diamonds, aes(factor(1), fill=cut)) + 
  geom_bar(width=1) + 
  coord_polar(theta= "y") + 
  labs(x="", title = "Fill-Bar", subtitle = "Polar coordinates") +
  scale_fill_brewer(palette = "Set2", direction = -1) + 
  theme_minimal()

library(patchwork)
p1 + p2 + p3


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
library(tidyverse)
library(NCME23data)
library(colorspace)
nces_pal <- c("#69cadf", "#f4602a", "#fbb03b", "#3273c2", "#c1cb52", "#bc53a7", "#5daa3a", "#c62f34", "#1bafac")
data(pisa_small)
ggplot(data = pisa_small)


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
ggplot(data = pisa_small, aes(x = math, y = region))


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
ggplot(data = pisa_small, aes(x = math, y = region)) +
    geom_boxplot()


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
ggplot(data = pisa_small, 
       aes(x = math, y = region, fill = region)) +
    geom_boxplot()


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
ggplot(data = pisa_small, 
       aes(x = math, y = region,  color = region, fill = region)) +
    geom_boxplot(alpha = 0.7) +
  theme_minimal(base_size = 15) +
  scale_color_manual(values = nces_pal)  +
  scale_fill_manual(values = nces_pal) +
  theme(legend.position = "none")


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
ggplot(data = pisa_small, 
       aes(x = math, y = region, color = region, fill =  region)) +
    geom_violin(alpha = 0.7) +
  theme_minimal(base_size = 15) +
  theme(legend.position = "none") +
  scale_color_manual(values = nces_pal)  +
  scale_fill_manual(values = nces_pal)


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
ggplot(data = pisa_small, 
       aes(x = math, y = region, color = region, fill =  region)) +
    geom_point(
    aes(fill = region),
    color = "transparent",
    shape = 21,
    stroke = .4,
    size = 2,
    alpha = .3,
    position = position_jitter(seed = 1, width = .12)
  ) +
  theme_minimal(base_size = 15) +
  theme(legend.position = "none") +
  scale_color_manual(values = nces_pal)  +
  scale_fill_manual(values = nces_pal)


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
ggplot(data = pisa_small, 
       aes(x = math, y = region, color = region, fill =  region)) +
  geom_point(
    aes(color = region,
        color = after_scale(darken(color, .1, space = "HLS"))),
    fill = "white",
    shape = 21,
    stroke = .4,
    size = 2,
    position = position_jitter(seed = 1, width = .12)
  )  + 
    geom_point(
    aes(fill = region),
    color = "transparent",
    shape = 21,
    stroke = .4,
    size = 2,
    alpha = .3,
    position = position_jitter(seed = 1, width = .12)
  )  +
  theme_minimal(base_size = 15) +
  theme(legend.position = "none") +
  scale_color_manual(values = nces_pal) +
  scale_fill_manual(values = nces_pal) 


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
ggplot(data = pisa_small, 
       aes(x = math, y = region, color = region, fill = region)) +
  geom_point(
    aes(color = region,
        color = after_scale(darken(color, .1, space = "HLS"))),
    fill = "white",
    shape = 21,
    stroke = .4,
    size = 2,
    position = position_jitter(seed = 1, width = .12)
  )  + 
    geom_point(
    aes(fill = region),
    color = "transparent",
    shape = 21,
    stroke = .4,
    size = 2,
    alpha = .3,
    position = position_jitter(seed = 1, width = .12)
  )  +
  scale_color_manual(values = nces_pal) +
  scale_fill_manual(values = nces_pal) +
  labs(x = "Math score", 
       y = NULL, 
       title = "2015 PISA Math scores by region") +
  theme_minimal(base_size = 15) +
  theme(legend.position = "none",
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank(),
        axis.ticks = element_blank(),
        axis.text.y = element_text(size = 16),
        axis.title.x = element_text(margin = margin(t = 10),
                                    size = 16),
        plot.title = element_text(size = 21),
        plot.title.position = "plot",
        plot.margin = margin(15, 15, 10, 15))


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
ggplot(data = pisa_small, 
       aes(x = math, y = region,  color = region, 
           fill = after_scale(lighten(color, .5)))) +
  geom_boxplot(
    aes(color = region,
        color = after_scale(darken(color, .1, space = "HLS")),
        fill = after_scale(desaturate(lighten(color, .8), .4))),
    width = .42, 
    outlier.shape = NA
  ) +
  geom_point(
    aes(color = region,
        color = after_scale(darken(color, .1, space = "HLS"))),
    fill = "white",
    shape = 21,
    stroke = .4,
    size = 2,
    position = position_jitter(seed = 1, width = .12)
  )  + 
    geom_point(
    aes(fill = region),
    color = "transparent",
    shape = 21,
    stroke = .4,
    size = 2,
    alpha = .3,
    position = position_jitter(seed = 1, width = .12)
  )  +
  scale_color_manual(values = nces_pal) +
  scale_fill_manual(values = nces_pal) +
  labs(x = "Math score", 
       y = NULL, 
       title = "2015 PISA Math scores by region") +
  theme_minimal(base_size = 15)  +
  theme(legend.position = "none",
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank(),
        axis.ticks = element_blank(),
        axis.text.y = element_text(size = 16),
        axis.title.x = element_text(margin = margin(t = 10),
                                    size = 16),
        plot.title = element_text(size = 21),
        plot.title.position = "plot",
        plot.margin = margin(15, 15, 10, 15))


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
ggplot(data = pisa_small, 
       aes(x = math, y = region,  color = region, 
           fill =  after_scale(lighten(color, .5)))) +
  geom_boxplot(
    aes(color = region,
        color = after_scale(darken(color, .1, space = "HLS")),
        fill = after_scale(desaturate(lighten(color, .8), .4))),
    width = .42, 
    outlier.shape = NA
  ) +
  geom_point(
    aes(color = region,
        color = after_scale(darken(color, .1, space = "HLS"))),
    fill = "white",
    shape = 21,
    stroke = .4,
    size = 2,
    position = position_jitter(seed = 1, height = .12)
  )  + 
    geom_point(
    aes(fill = region),
    color = "transparent",
    shape = 21,
    stroke = .4,
    size = 2,
    alpha = .3,
    position = position_jitter(seed = 1, height = .12)
  )  +
  scale_color_manual(values = nces_pal) +
  scale_fill_manual(values = nces_pal) +
  labs(x = "Math score", 
       y = NULL, 
       title = "2015 PISA Math scores by region") +
  theme_minimal(base_size = 15)  +
  theme(legend.position = "none",
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank(),
        axis.ticks = element_blank(),
        axis.text.y = element_text(size = 16),
        axis.title.x = element_text(margin = margin(t = 10),
                                    size = 16),
        plot.title = element_text(size = 21),
        plot.title.position = "plot",
        plot.margin = margin(15, 15, 10, 15))


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
ggplot(data = pisa_small, 
       aes(x = math, y = region,  color = region, 
           fill =  after_scale(lighten(color, .5)))) +
  ggdist::stat_halfeye(
    adjust = .5, 
    height = .6, 
    .width = 0, 
    point_colour = NA, 
    justification = -.3) + 
  geom_boxplot(
    aes(color = region,
        color = after_scale(darken(color, .1, space = "HLS")),
        fill = after_scale(desaturate(lighten(color, .8), .4))),
    width = .42, 
    outlier.shape = NA
  ) +
  geom_point(
    aes(color = region,
        color = after_scale(darken(color, .1, space = "HLS"))),
    fill = "white",
    shape = 21,
    stroke = .4,
    size = 2,
    position = position_jitter(seed = 1, height = .12)
  )  + 
    geom_point(
    aes(fill = region),
    color = "transparent",
    shape = 21,
    stroke = .4,
    size = 2,
    alpha = .3,
    position = position_jitter(seed = 1, height = .12)
  )  +
  scale_color_manual(values = nces_pal) +
  scale_fill_manual(values = nces_pal) +
  labs(x = "Math score", 
       y = NULL,
       title = "2015 PISA Math scores by region") +
  theme_minimal(base_size = 15)  +
  theme(legend.position = "none",
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank(),
        axis.ticks = element_blank(),
        axis.text.y = element_text(size = 16),
        axis.title.x = element_text(margin = margin(t = 10),
                                    size = 16),
        plot.title = element_text(size = 21),
        plot.title.position = "plot",
        plot.margin = margin(15, 15, 10, 15))


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
plot_ex <- ggplot(data = pisa_small, 
                  aes(x = math, y = region,  color = region, 
                      fill =  after_scale(lighten(color, .5)))) +
  ggdist::stat_halfeye(
    adjust = .5, 
    height = .6, 
    .width = 0, 
    point_colour = NA, 
    justification = -.3) + 
  geom_boxplot(
    aes(color = region,
        color = after_scale(darken(color, .1, space = "HLS")),
        fill = after_scale(desaturate(lighten(color, .8), .4))),
    width = .25, 
    outlier.shape = NA
  ) +
  geom_point(
    aes(fill = region),
    color = "transparent",
    shape = 21,
    stroke = .4,
    size = 2,
    alpha = .3,
    position = position_jitter(seed = 1, height = .12)
  )  +
  geom_point(
    aes(fill = region),
    color = "transparent",
    shape = 21,
    stroke = .4,
    size = 2,
    alpha = .3,
    position = position_jitter(seed = 1, height = .12)
  )  +
  scale_color_manual(values = nces_pal) +
  scale_fill_manual(values = nces_pal) +
  labs(x = "Math score", 
       y = NULL, 
       title = "2015 PISA Math scores by region") +
  theme_minimal(base_size = 15)  +
  theme(legend.position = "none",
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank(),
        axis.ticks = element_blank(),
        axis.text.y = element_text(size = 16),
        axis.title.x = element_text(margin = margin(t = 10),
                                    size = 16),
        plot.title = element_text(size = 21),
        plot.title.position = "plot",
        plot.margin = margin(15, 15, 10, 15))
plot_ex


## ----fig.height=9.5, fig.width=12-----------------------------------------------------------
plot_ex  +
  stat_summary(
    geom = "text",
    fun = "median",
    aes(label = round(..x.., 2),
        color = region,
        weight = weight,
        color = after_scale(darken(color, .1, space = "HLS"))),
    fontface = "bold",
    size = 4.5,
    vjust = -2.5,
    hjust = 0.5
  ) 



## ----fig.height=5.7, fig.width=7.2, fig.align="center"--------------------------------------
plot_ex  +
  stat_summary(
    geom = "text",
    fun = "median",
    aes(label = round(..x.., 2),
        color = region,
        weight = weight,
        color = after_scale(darken(color, .1, space = "HLS"))),
    fontface = "bold",
    size = 4.5,
    vjust = -1,
    hjust = 0.5
  ) 

