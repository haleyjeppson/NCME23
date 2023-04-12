## ----setup, include=FALSE-------------------------------------------------------------------
library(tidyverse)
library(ggthemes)
library(ggokabeito)


## ----fig.height=5---------------------------------------------------------------------------
ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) +
  labs(title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception because of their light weight",
    caption = "Data from fueleconomy.gov",
    x = "Engine displacement (L)", y = "Highway fuel economy (mpg)",
    colour = "Car type")


## ----echo = FALSE---------------------------------------------------------------------------
library(tidyverse)


## ----addtext0, echo=TRUE, results='hide'----------------------------------------------------
best_in_class <- mpg %>% 
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1)

best_in_class


## ---- ref.label="addtext0", echo=FALSE, out.width='100%'------------------------------------


## ----addtext, echo=TRUE, fig.show='hide'----------------------------------------------------
best_in_class <- mpg %>% 
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1)

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = class)) +
  geom_text(data = best_in_class, #<<
            aes(label = model)) #<<


## ---- ref.label="addtext", echo=FALSE, out.width='100%'-------------------------------------


## ----addtext-label, echo=TRUE, fig.show='hide'----------------------------------------------
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_point(data = best_in_class,
             size = 3, shape = 1) +
  ggrepel::geom_label_repel( #<<
    data = best_in_class, #<<
    aes(label = model)) #<<


## ---- ref.label="addtext-label", echo=FALSE, out.width='100%'-------------------------------


## ----addtext-stat, echo=TRUE, fig.show='hide'-----------------------------------------------
ggplot(mpg, aes(class)) +
  geom_bar() +
  geom_text( #<<
    aes( #<<
      y = after_stat(count + 2), #<<
      label = after_stat(count) #<<
    ), #<<
    stat = "count" #<<
  ) #<<


## ---- ref.label="addtext-stat", echo=FALSE, out.width='100%'--------------------------------


## ----fig.height = 5-------------------------------------------------------------------------
p <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(data = dplyr::filter(mpg, manufacturer == "subaru"), 
             colour = "orange", size = 3) +
  geom_point() 
p


## ----fig.height = 5-------------------------------------------------------------------------
p + 
  annotate(geom = "curve", x = 4, y = 35, xend = 2.65, yend = 27, 
           curvature = .3, arrow = arrow(length = unit(2, "mm"))) +
  annotate(geom = "text", x = 4.1, y = 35, label = "subaru", hjust = "left")


## ----eval = FALSE---------------------------------------------------------------------------
## YOUR TURN
library(NCME23data)
data(pisa_usa)
## OR alternate route:
pisa_usa <- read_csv("scripts/data/pisa_usa.csv")

ggplot(pisa_usa, aes(x = math, y = reading)) +
  geom_point(color = "#3C5488", alpha = .7)


## ----echo = TRUE, out.width="100%", fig.height=4--------------------------------------------



## ----axesscales0, echo=TRUE, fig.show='hide'------------------------------------------------
p 


## ---- ref.label="axesscales0", echo=FALSE, out.width='100%'---------------------------------


## ----axesscales1, echo=TRUE, fig.show='hide'------------------------------------------------
p +
  scale_x_continuous() #<<


## ---- ref.label="axesscales1", echo=FALSE, out.width='100%'---------------------------------


## ----axesscales2, echo=TRUE, fig.show='hide'------------------------------------------------
p +
  scale_x_continuous( 
    "Engine displacement, in litres", #<<
    breaks = c(2,4,6) #<<
  ) 


## ---- ref.label="axesscales2", echo=FALSE, out.width='100%'---------------------------------


## ----cont-color0, echo=TRUE, fig.show='hide'------------------------------------------------
ggplot(mpg, 
       aes(x = displ, y = hwy)) +
  geom_point(aes(color = cyl))


## ---- ref.label="cont-color0", echo=FALSE, out.width='100%'---------------------------------


## ----cont-color, echo=TRUE, fig.show='hide'-------------------------------------------------
ggplot(mpg, 
       aes(x = displ, y = hwy)) +
  geom_point(aes(color = cyl)) + 
  scale_colour_continuous() #<<


## ---- ref.label="cont-color", echo=FALSE, out.width='100%'----------------------------------


## ----disc-color0, echo=TRUE, fig.show='hide'------------------------------------------------
ggplot(mpg, 
       aes(x = displ, y = hwy)) + 
  geom_point(
    aes(color = factor(cyl))
  )


## ---- ref.label="disc-color0", echo=FALSE, out.width='100%'---------------------------------


## ----disc-color, echo=TRUE, fig.show='hide'-------------------------------------------------
ggplot(mpg, 
       aes(x = displ, y = hwy)) + 
  geom_point(
    aes(color = factor(cyl))
  ) + 
  scale_colour_discrete() #<<


## ---- ref.label="disc-color", echo=FALSE, out.width='100%'----------------------------------


## ----man-color, echo=TRUE, fig.show='hide'--------------------------------------------------
ggplot(mpg, 
       aes(x = displ, 
           y = hwy, 
           color = factor(cyl)
       )) +
  geom_point() + 
  scale_color_manual( #<<
    "cylinders", #<<
    values = c( #<<
      "turquoise3", "magenta", #<<
      "mediumpurple4", "orange"  #<<
    ) #<<
  ) #<<


## ---- ref.label="man-color", echo=FALSE, out.width='100%'-----------------------------------


## ----brewer-color, echo=TRUE, fig.show='hide'-----------------------------------------------
ggplot(mpg, 
       aes(x = displ,
           y = hwy, 
           color = factor(cyl)
       )) +
  geom_point() + 
  scale_colour_brewer( #<<
    palette = 'Dark2' #<<
  ) #<<


## ---- ref.label="brewer-color", echo=FALSE, out.width='100%'--------------------------------


## ----guide, echo=TRUE, fig.show='hide'------------------------------------------------------
ggplot(mpg, 
       aes(x = displ, 
           y = hwy, 
           color = cyl
       )) +
  geom_point() + 
  scale_color_gradientn( #<<
    "cylinders", #<<
    colours = c( #<<
      "#6C5B7B", "#C06C84", #<<
      "#F67280", "#F8B195"  #<<
    ) #<<
  ) #<<


## ---- ref.label="guide", echo=FALSE, out.width='100%'---------------------------------------


## ----guide1, echo=TRUE, fig.show='hide'-----------------------------------------------------
ggplot(mpg, 
       aes(x = displ, 
           y = hwy, 
           color = cyl
       )) +
  geom_point() + 
  scale_color_gradientn( 
    "cylinders", 
    colours = c( 
      "#6C5B7B", "#C06C84", 
      "#F67280", "#F8B195"  
    ), 
    guide = guide_colorsteps(  #<<
      barwidth = 0.5,   #<<
      barheight = 8  #<<
    )  #<<
  ) 


## ---- ref.label="guide1", echo=FALSE, out.width='100%'--------------------------------------


## ----guide-reverse0, echo=TRUE, fig.show='hide'---------------------------------------------
ggplot(mpg, 
       aes(y = class, 
           fill = class
       )) +
  geom_bar() + 
  ggokabeito::scale_fill_okabe_ito() 


## ---- ref.label="guide-reverse0", echo=FALSE, out.width='100%'------------------------------


## ----guide-reverse, echo=TRUE, fig.show='hide'----------------------------------------------
ggplot(mpg, 
       aes(y = class, 
           fill = class
       )) +
  geom_bar() + 
  ggokabeito::scale_fill_okabe_ito(
    guide = guide_legend( #<<
      reverse = TRUE #<<
    )  #<<
  ) 


## ---- ref.label="guide-reverse", echo=FALSE, out.width='100%'-------------------------------


## -------------------------------------------------------------------------------------------
p <- ggplot(mpg, aes(x = displ, y =  cty, colour= factor(class))) +
  geom_point()


## ----fig.height = 6-------------------------------------------------------------------------
p + theme_grey()


## ----fig.height = 6-------------------------------------------------------------------------
p + theme_minimal()


## -------------------------------------------------------------------------------------------
p <- ggplot(mpg, aes(x = displ, y =  cty, colour= factor(class))) +
  geom_point()


## ----fig.height = 6-------------------------------------------------------------------------
p + theme_light()


## ---- fig.height = 6------------------------------------------------------------------------
p + theme_dark()


## -------------------------------------------------------------------------------------------
library(ggthemes)


## ---- fig.height = 6------------------------------------------------------------------------
p + theme_excel() 


## ---- fig.height = 6------------------------------------------------------------------------
p + theme_fivethirtyeight()


## ----theme-elements0, echo=TRUE, fig.show='hide'--------------------------------------------
ggplot(mpg, aes(x = manufacturer)) + 
  geom_bar()


## ---- ref.label="theme-elements0", echo=FALSE, out.width='100%'-----------------------------


## ----theme-elements, echo=TRUE, fig.show='hide'---------------------------------------------
ggplot(mpg, aes(x = manufacturer)) + 
  geom_bar() +
  theme(
    axis.text.x = element_text( #<<
      angle=90, #<<
      vjust=0.5,  #<<
      hjust=1) #<<
    ) 


## ---- ref.label="theme-elements", echo=FALSE, out.width='100%'------------------------------


## ----theme-elements2, echo=TRUE, fig.show='hide'--------------------------------------------
ggplot(mpg, aes(x = manufacturer)) + 
  geom_bar() +
  theme_light() + #<<
  theme(
    axis.text.x = element_text(
      angle=90, 
      vjust=0.5,
      hjust=1) 
    ) 


## ---- ref.label="theme-elements2", echo=FALSE, out.width='100%'-----------------------------


## ----save, echo=TRUE, fig.show='hide'-------------------------------------------------------
iris_plot <- 
  ggplot(
    data = iris,
    aes(x = Sepal.Width,
        y = Sepal.Length, 
        color = Species)
    ) + 
  geom_point() +
  scale_color_manual(
    values = c("turquoise3", "green3", "darkorchid2")
    ) + 
  theme(
    legend.position = "bottom", 
    legend.background = element_blank())
iris_plot 


## ----eval=FALSE, echo = TRUE----------------------------------------------------------------
## ggsave("iris-scatter.png", 
##        plot = iris_plot)


## ---- ref.label="save", echo=FALSE, out.width='100%'----------------------------------------

