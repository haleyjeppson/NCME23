## ----setup, include=FALSE-------------------------------------------------------------------
library(tidyverse)


## ----echo = TRUE----------------------------------------------------------------------------
## devtools::install_github("haleyjeppson/NCME23data")
library(NCME23data)
## weighted US sample of size 99
data(pisa_usa)
## weighted sample of 1000
data(pisa_small)

## OR alternate route:
pisa_usa <- read_csv("scripts/data/pisa_usa.csv")
pisa_small <- read_csv("scripts/data/pisa_small.csv")


## -------------------------------------------------------------------------------------------
library(tidyverse)
pisa_usa %>% names()


## ----data-plot, echo=TRUE, fig.show='hide'--------------------------------------------------
ggplot(data = pisa_usa) #<<


## ---- ref.label="data-plot", echo=FALSE, out.width='100%'-----------------------------------


## ----aes-plot, echo=TRUE, fig.show='hide'---------------------------------------------------
ggplot(data = pisa_usa,
  mapping = aes(x = math, y = reading)) #<<


## ---- ref.label="aes-plot", echo=FALSE, out.width='100%'------------------------------------


## ----aes-plot2, echo=TRUE, fig.show='hide'--------------------------------------------------
ggplot(pisa_usa,
       aes(x = math, y = reading))  #<<


## ---- ref.label="aes-plot2", echo=FALSE, out.width='100%'-----------------------------------


## ----fig.asp = .6---------------------------------------------------------------------------
library(patchwork)
df <- data.frame(
  x = c(3, 1, 5), 
  y = c(2, 4, 6), 
  label = c("a","b","c")
)
p <- ggplot(df, aes(x, y, label = label)) + 
  labs(x = NULL, y = NULL) + # Hide axis label
  theme_minimal() +
  theme(plot.title = element_text(size = 12)) + # Shrink plot title
  xlim(0,7) + ylim(0,7)

p + geom_point() + ggtitle("point") +
p + geom_text() + ggtitle("text") + 
p + geom_bar(stat = "identity") + ggtitle("bar") + 
p + geom_tile() + ggtitle("raster") + 
p + geom_line() + ggtitle("line") + 
p + geom_area() + ggtitle("area") + 
p + geom_path() + ggtitle("path") + 
p + geom_polygon() + ggtitle("polygon") + 
  plot_layout(nrow = 2)


## ----geom-plot, echo=TRUE, fig.show='hide'--------------------------------------------------
ggplot(
  pisa_usa, 
  aes(x = math, y = reading)
  ) +  #<<
  geom_point()  #<<


## ---- ref.label="geom-plot", echo=FALSE, out.width='100%'-----------------------------------


## ----geom-plot2, echo=TRUE, fig.show='hide'-------------------------------------------------
ggplot(pisa_usa) +
  geom_point(aes(x = math, y = reading))  #<<


## ---- ref.label="geom-plot2", echo=FALSE, out.width='100%'----------------------------------


## ----geom-plot3, echo=TRUE, fig.show='hide'-------------------------------------------------
ggplot() +  #<<
  geom_point(data = pisa_usa,  #<<
             aes(x = math, y = reading))


## ---- ref.label="geom-plot3", echo=FALSE, out.width='100%'----------------------------------


## ----geom-plot-visual, echo=TRUE, fig.show='hide'-------------------------------------------
ggplot(
    pisa_usa, 
    aes(x = math, y = reading)
  ) +
  geom_point(
    color = "#3C5488", #<<
    alpha = .7, #<<
    shape = 17, #<<
    stroke = 1, #<<
    size = 5 #<<
  )


## ---- ref.label="geom-plot-visual", echo=FALSE, out.width='100%'----------------------------


## ----echo=TRUE------------------------------------------------------------------------------
ggplot(
    pisa_usa, 
    aes(x = math, y = reading)
  ) +
  geom_point(
    color = "#3C5488", #<<
    alpha = .7
  )


## ----echo=TRUE------------------------------------------------------------------------------
ggplot(
    pisa_usa, 
    aes(x = math, y = reading)
  ) +
  geom_point(
    aes(color = sex), #<<
    alpha = .7
  )


## ----echo=TRUE------------------------------------------------------------------------------
ggplot(
    pisa_usa, 
    aes(x = math, y = reading)  #<<
  ) +
  geom_point(
    aes(color = sex), #<<
    alpha = .7
  )


## ----echo=TRUE------------------------------------------------------------------------------
ggplot(
    pisa_usa, 
    aes(x = math, y = reading,   #<<
        color = sex),      #<<
  ) +
  geom_point(
    alpha = .7
  )


## ----echo=TRUE------------------------------------------------------------------------------
ggplot(pisa_usa) +
  geom_point( #<<
    aes(x = math, y = reading), #<<
    color = "#3C5488", 
    alpha = .7)


## ----echo=TRUE------------------------------------------------------------------------------
ggplot(pisa_usa) +
  geom_density( #<<
    aes(x = math), #<<
    color = "#3C5488", 
    fill = "#3C5488",
    alpha = .7)


## ----echo=TRUE------------------------------------------------------------------------------
ggplot(pisa_usa) +
  geom_point( #<<
    aes(x = math, y = reading, #<<
        color = parent_edu), 
    alpha = .7)


## ----echo=TRUE------------------------------------------------------------------------------
ggplot(pisa_usa) +
  geom_boxplot( #<<
    aes(x = parent_edu, y = reading, #<<
        color = parent_edu,
        fill = parent_edu), 
    alpha = .7)


## ----eval = FALSE, echo = TRUE--------------------------------------------------------------
## ggplot(pisa_usa, aes(x = math)) +
##   ## your code here


## ----eval = FALSE, echo = TRUE--------------------------------------------------------------
## ggplot(pisa_usa, aes(x = sex, y = math)) +
##   ## your code here


## ----add-layer0, echo=TRUE, fig.show='hide'-------------------------------------------------
ggplot(
    pisa_usa, 
    aes(x = parent_edu, y = reading,
        fill = parent_edu, 
        color = parent_edu)
  ) +
  geom_boxplot( #<<
    alpha = .2  #<<
  )     #<<      


## ---- ref.label="add-layer0", echo=FALSE, out.width='100%'----------------------------------


## ----add-layer, echo=TRUE, fig.show='hide'--------------------------------------------------
ggplot(
    pisa_usa, 
    aes(x = parent_edu, y = reading,
        fill = parent_edu, 
        color = parent_edu)
  ) +
  geom_boxplot( 
    alpha = .2  
  ) +           
  geom_point( #<<
    alpha = .5 #<<
  )  #<<


## ---- ref.label="add-layer", echo=FALSE, out.width='100%'-----------------------------------


## ----add-layer2, echo=TRUE, fig.show='hide'-------------------------------------------------
ggplot(
    pisa_usa, 
    aes(x = parent_edu, y = reading,
        fill = parent_edu, 
        color = parent_edu) #<<
  ) +
  geom_boxplot( 
    
    alpha = .4
  ) +           
  geom_point(
    color = "black", #<<
    alpha = .5
  ) 


## ---- ref.label="add-layer2", echo=FALSE, out.width='100%'----------------------------------


## ----geombar, echo=TRUE, fig.show='hide'----------------------------------------------------
ggplot(pisa_usa, aes(x = parent_edu)) +
  geom_bar() #<<


## ---- ref.label="geombar", echo=FALSE, out.width='100%'-------------------------------------


## ----statidentity0, echo=TRUE, results='hide'-----------------------------------------------
pisa_usa_counted <- pisa_usa %>%
  count(parent_edu)

pisa_usa_counted #<<


## ---- ref.label="statidentity0", echo=FALSE, out.width='100%'-------------------------------


## ----statidentity, echo=TRUE, fig.show='hide'-----------------------------------------------
pisa_usa_counted <- pisa_usa %>%
  count(parent_edu)

ggplot(pisa_usa_counted, 
       aes(x = parent_edu)) +
  geom_bar(aes(y = n),     #<<
           stat = 'identity')  #<<


## ---- ref.label="statidentity", echo=FALSE, out.width='100%'--------------------------------


## ----geomcol, echo=TRUE, fig.show='hide'----------------------------------------------------
pisa_usa_counted <- pisa_usa %>%
  count(parent_edu)

ggplot(pisa_usa_counted,
       aes(x = parent_edu)) +
  geom_col(aes(y = n))   #<<


## ---- ref.label="geomcol", echo=FALSE, out.width='100%'-------------------------------------


## ----afterstat, echo=TRUE, fig.show='hide'--------------------------------------------------
ggplot(pisa_usa) +
  geom_bar(
    aes(
      x = parent_edu,
      y = after_stat( #<<
        100 * count / sum(count) #<<
        )  #<<
    )
  )


## ---- ref.label="afterstat", echo=FALSE, out.width='100%'-----------------------------------


## ----facetgrid, echo=TRUE, fig.show='hide'--------------------------------------------------
ggplot(pisa_small, 
       aes(x = math)) +
  geom_density(
    color = "#3C5488",
    fill = "#3C5488",
    alpha = .7
  ) +
  facet_grid( #<<
    cols = vars(sex),  #<<
    rows = vars(OECD) #<<
  )  #<<


## ---- ref.label="facetgrid", echo=FALSE, out.width='100%'-----------------------------------


## ----facetwrap, echo=TRUE, fig.show='hide'--------------------------------------------------
ggplot(pisa_small, 
       aes(math, reading)) +
  geom_point(
    color = "#3C5488",
    alpha = .7
  ) +
  facet_wrap(vars(region)) #<<


## ---- ref.label="facetwrap", echo=FALSE, out.width='100%'-----------------------------------


## ----echo=TRUE------------------------------------------------------------------------------
pisa_plot <- ggplot(pisa_usa, aes(x = math, y = reading, color = sex)) +
  geom_point(alpha = .7)

class(pisa_plot)


## ----echo=TRUE------------------------------------------------------------------------------
str(pisa_plot)


## ----echo=TRUE, fig.height=4----------------------------------------------------------------
pisa_plot +
  geom_smooth(method = "lm")

