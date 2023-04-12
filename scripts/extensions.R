## ----setup, include=FALSE-------------------------------------------------------------------
library(tidyverse)


## ----echo = TRUE----------------------------------------------------------------------------
##  devtools::install_github("haleyjeppson/NCME23data")
library(NCME23data)
data(pisa_usa)
data(pisa_small)
data(pisa_wide)


## ----patchwork0, echo=TRUE, fig.show='hide'-------------------------------------------------
p1 <- ggplot(pisa_small) +
  geom_violin(
    aes(
      x = math,
      y = region,
      color = region,
      fill = region), 
    alpha = 0.8
  ) +
  theme_light() +
  ggokabeito::scale_fill_okabe_ito() +
  ggokabeito::scale_color_okabe_ito() +
  labs(
    x = "2015 PISA Math score",
    y = NULL
  )

p1 #<<


## ---- ref.label="patchwork0", echo=FALSE, out.width='100%'----------------------------------


## ----patchwork1, echo=TRUE, fig.show='hide'-------------------------------------------------
p2 <- ggplot(pisa_small) +
  geom_bar(
    aes(
      y = region,
      fill = region
    ),
    alpha = 0.8
  ) +
  theme_light() +
  ggokabeito::scale_fill_okabe_ito() +
  ggokabeito::scale_color_okabe_ito() +
  labs(
    x = "Number of students",
    y = NULL
  )

p2 #<<


## ---- ref.label="patchwork1", echo=FALSE, out.width='100%'----------------------------------


## ----patchwork2, echo=TRUE, fig.show='hide'-------------------------------------------------
p3 <- ggplot(pisa_wide,
       aes(x = Female, y = Male)) +
  geom_abline(
    alpha = 0.2, 
    linetype = "dashed"
  ) +
  geom_point(
    aes(color = region), 
    alpha = 0.9,
    size = 2.5
  ) +
  theme_light() +
  ggokabeito::scale_fill_okabe_ito() +
  ggokabeito::scale_color_okabe_ito() +
  labs(title = "Gender Gaps in PISA 2015 Math Scores",
       x = "girls math score",
       y = "boys math score")

p3 #<<


## ---- ref.label="patchwork2", echo=FALSE, out.width='100%'----------------------------------


## ----patchwork3, echo=TRUE, fig.show='hide'-------------------------------------------------
library(patchwork)
(p1 | p2) / p3  #<<


## ---- ref.label="patchwork3", echo=FALSE, out.width='100%'----------------------------------


## ----patchwork4, echo=TRUE, fig.show='hide'-------------------------------------------------
(p1 | p2) / p3 + 
  plot_layout(  
    heights = c(1,2),  #<<
    guides = 'collect'  #<<
  )  


## ---- ref.label="patchwork4", echo=FALSE, out.width='100%'----------------------------------


## ----patchwork6, echo=TRUE, fig.show='hide'-------------------------------------------------
(p1 | p2) / p3 + 
  plot_layout(
    heights = c(1,2)
  ) &  #<<
  theme(  
    legend.position = 'none'  
  )  


## ---- ref.label="patchwork6", echo=FALSE, out.width='100%'----------------------------------


## ----patchwork5, echo=TRUE, fig.show='hide'-------------------------------------------------
(p1 | p2) / p3 + 
  plot_layout(
    heights = c(1,2)
  ) +
  plot_annotation(
    title = 'Pisa Math Scores in 2015',  #<<
    subtitle = 'A subset of the data shown by region and sex',  #<<
    tag_levels = 'A'  #<<
  ) &
  theme(
    legend.position = 'none'
  ) 


## ---- ref.label="patchwork5", echo=FALSE, out.width='100%'----------------------------------


## ----ggrepel0, echo=TRUE, fig.show='hide'---------------------------------------------------
ggplot(pisa_wide,
       aes(x = Female, y = Male)) +
  geom_abline(
    alpha = 0.2, 
    linetype = "dashed"
  ) +
  geom_point(
    aes(color = region), 
    alpha = 0.9,
    size = 2.5
  ) +
  geom_text(  #<<
    aes(label = country)
  ) +
  theme_light() +
  ggokabeito::scale_fill_okabe_ito() +
  ggokabeito::scale_color_okabe_ito() +
  labs(
    title = "Gender Gaps in PISA 2015 Math Scores",
    x = "girls math score",
    y = "boys math score"
  )


## ---- ref.label="ggrepel0", echo=FALSE, out.width='100%'------------------------------------


## ----ggrepel, echo=TRUE, fig.show='hide'----------------------------------------------------
ggplot(pisa_wide,
       aes(x = Female, y = Male)) +
  geom_abline(
    alpha = 0.2, 
    linetype = "dashed"
  ) +
  geom_point(
    aes(color = region), 
    alpha = 0.9,
    size = 2.5
  ) +
  ggrepel::geom_text_repel( #<<
    aes(label = country)
  ) +
  theme_light() +
  ggokabeito::scale_fill_okabe_ito() +
  ggokabeito::scale_color_okabe_ito() +
  labs(
    title = "Gender Gaps in PISA 2015 Math Scores",
    x = "girls math score",
    y = "boys math score"
  )


## ---- ref.label="ggrepel", echo=FALSE, out.width='100%'-------------------------------------


## ----ggpubr, echo=TRUE, fig.show='hide'-----------------------------------------------------
library(ggpubr)

ggscatterhist(pisa_small, 
  x = "math", 
  y = "reading",
  color = "OECD", 
  size = 3,
  alpha = 0.6,
  palette = c("#3C5488", "#E64B35"),
  margin.params = list(
    fill = "OECD",
    color = "black", 
    size = 0.2)
  )


## ---- ref.label="ggpubr", echo=FALSE, out.width='100%'--------------------------------------


## ----ggpairs, echo=TRUE, fig.show='hide'----------------------------------------------------
library(GGally)
pisa_small_subset <- pisa_small %>%
  select(OECD, wealth,
         escs_index, test_anxiety,
         math:science)

GGally::ggpairs(
  pisa_small_subset,
  aes(color = OECD, 
      alpha = 0.5
    )
  ) + 
  theme_bw() +
  scale_color_manual(
    values = c("#3C5488", "#E64B35")
  ) +
  scale_fill_manual(
    values = c("#3C5488", "#E64B35")
  )


## ---- ref.label="ggpairs", echo=FALSE, out.width='100%'-------------------------------------


## ----ggcorrplot, echo=TRUE, fig.show='hide'-------------------------------------------------
# devtools::install_github("kassambara/ggcorrplot")
library(ggcorrplot)
pisa_small_subset <- pisa_small %>%
  select(
    wealth, escs_index,
    test_anxiety:parent_support_emotional,
    teacher_support_science:science)
         
cor_pisa <- cor(pisa_small_subset,
          use = "complete.obs")
ggcorrplot(cor_pisa, 
         type = "lower", 
         outline.col = "white", 
         ggtheme = ggplot2::theme_light,
         colors = c(
         "mediumpurple", "#EEEEEE", 
         "orange"), 
         lab = TRUE
         )


## ---- ref.label="ggcorrplot", echo=FALSE, out.width='100%'----------------------------------


## ----ggstatsplot, echo=TRUE, fig.show='hide'------------------------------------------------
# install.packages("ggstatsplot")
library(ggstatsplot)
set.seed(123)

ggbetweenstats(
  data  = pisa_small,
  x     = OECD,
  y     = math,
  title = "Distribution of math scores by OECD status"
)


## ---- ref.label="ggstatsplot", echo=FALSE, out.width='100%'---------------------------------


## ----ggplotly1, echo=TRUE, results='hide'---------------------------------------------------
library(plotly)
ggplotly(p3)  #<<


## ---- ref.label="ggplotly1", echo=FALSE, out.width='100%'-----------------------------------


## ----ggplotly2, echo=TRUE, results='hide'---------------------------------------------------
p3_updated <- ggplot(pisa_wide,
       aes(x = Female, y = Male,
           text = paste("country:", country)  #<<
       )) +
  geom_abline(alpha = 0.2, linetype = "dashed") +
  geom_point(
    aes(color = region), 
    alpha = 0.9,
    size = 2.5
  ) +
  theme_light() +
  ggokabeito::scale_fill_okabe_ito() +
  ggokabeito::scale_color_okabe_ito() +
  labs(title = "Gender Gaps in PISA 2015 Math Scores",
       x = "girls math score",
       y = "boys math score") 

ggplotly(p3_updated)


## ---- ref.label="ggplotly2", echo=FALSE, out.width='100%'-----------------------------------


## ----ggplotly3, echo=TRUE, results='hide'---------------------------------------------------
ggplotly(p3_updated, 
  tooltip = c("text", "x", "y") #<<
  )


## ---- ref.label="ggplotly3", echo=FALSE, out.width='100%'-----------------------------------


## ----ggiraph0, echo=TRUE, results='hide'----------------------------------------------------
library(ggiraph)
p3_int <- ggplot(pisa_wide,
       aes(x = Female, y = Male)) +
  geom_abline(alpha = 0.2, linetype = "dashed") +
  geom_point_interactive( #<<
    aes(color = region,
        tooltip = country,  #<<
        data_id = country),   #<<
    alpha = 0.9,
    size = 2.5
  ) +
  theme_light() +
  ggokabeito::scale_fill_okabe_ito() +
  ggokabeito::scale_color_okabe_ito() +
  labs(title = "Gender Gaps in PISA 2015 Math Scores",
       x = "girls math score",
       y = "boys math score") 

girafe(ggobj = p3_int)


## ---- ref.label="ggiraph0", echo=FALSE, out.width='100%'------------------------------------

