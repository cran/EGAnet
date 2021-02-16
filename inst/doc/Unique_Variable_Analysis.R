## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#"
)

## ----packages load, eval = FALSE, echo = TRUE, comment = NA, warning = FALSE, message = FALSE----
#  # Download latest EGAnet package
#  devtools::install_github("hfgolino/EGAnet",
#                           dependencies = c("Imports", "Suggests"))
#  
#  # Load packages
#  library(psychTools)
#  library(EGAnet)
#  
#  # Set seed for reproducibility
#  set.seed(6724)
#  
#  # Load SAPA data
#  # Select Five Factor Model personality items only
#  idx <- na.omit(match(gsub("-", "", unlist(spi.keys[1:5])), colnames(spi)))
#  items <- spi[,idx]
#  
#  # Obtain item descriptions for UVA
#  key.ind <- match(colnames(items), as.character(spi.dictionary$item_id))
#  key <- as.character(spi.dictionary$item[key.ind])

## ----Fig6 code, eval = FALSE, echo = TRUE, comment = NA, warning = FALSE, message = FALSE----
#  # EGA (with redundancy)
#  ega.wr <- EGA(items, algorithm = "louvain", plot.EGA = FALSE)
#  plot(ega.wr, plot.args = list(node.size = 8,
#                                edge.alpha = 0.2))

## ----Fig6, fig.cap = "Figure 1. Exploratory Graph Analaysis of SAPA Inventory Before Unique Variable Analysis", fig.align = 'center', fig.pos = "H", eval = TRUE, echo = FALSE, comment = NA, warning = FALSE, message = FALSE----
# Initial EGA
knitr::include_graphics("./Figures/Fig6-1.png", dpi = 75)

## ----analysis, eval = FALSE, echo = TRUE, comment = NA, warning = FALSE, message = FALSE----
#  # Perform unique variable analysis (latent variable)
#  sapa.ra <- UVA(data = items, method = "wTO",
#                 type = "adapt", key = key,
#                 reduce = TRUE, reduce.method = "latent",
#                 adhoc = TRUE)

## ----Fig7, fig.cap = "Figure 2. R Console Interface for Selecting Redundant Variables", fig.align = 'center', fig.pos = "H", eval = TRUE, echo = FALSE, comment = NA, warning = FALSE, message = FALSE----
# R console example
knitr::include_graphics("./Figures/Figure7.png", dpi = 700)

## ----Fig8, fig.cap = "Figure 3. Example of a Redundancy Chain Plot", fig.align = 'center', fig.pos = "H", eval = TRUE, echo = FALSE, comment = NA, warning = FALSE, message = FALSE----
# Redundancy chain example
knitr::include_graphics("./Figures/Figure8.png", dpi = 1300)

## ----Fig9, fig.cap = "Figure 4. Second Target Variable Demonstrating Latent Variable Keying", fig.align = 'center', fig.pos = "H", eval = TRUE, echo = FALSE, comment = NA, warning = FALSE, message = FALSE----
# Latent keying example
knitr::include_graphics("./Figures/Figure9.png", dpi = 900)

## ----Fig10 code, eval = FALSE, echo = TRUE, comment = NA, warning = FALSE, message = FALSE----
#  # EGA (with redundant variables combined)
#  ega <- EGA(sapa.ra$reduced$data, algorithm = "louvain", plot.EGA = FALSE)
#  plot(ega, plot.args =
#         list(vsize = 8,
#              edge.alpha = 0.2,
#              label.size = 4,
#              legend.names = c("Conscientiousness", "Neuroticism",
#                               "Extraversion", "Openness to Experience",
#                               "Agreeableness")))

## ----Fig10, fig.cap = "Figure 5. Exploratory Graph Analaysis of SAPA Inventory After Unique Variable Analysis", fig.align = 'center', fig.pos = "H", eval = TRUE, echo = FALSE, comment = NA, warning = FALSE, message = FALSE----
# Re-estimate EGA
knitr::include_graphics("./Figures/Fig10-1.png", dpi = 75)

## ----remove, eval = FALSE, echo = TRUE, comment = NA, warning = FALSE, message = FALSE----
#  # Perform unique variable analysis (removing all but one variable)
#  sapa.rm <- UVA(data = items, method = "wTO",
#                 type = "adapt", key = key,
#                 reduce = TRUE, reduce.method = "remove",
#                 adhoc = TRUE)

## ----Fig11, fig.cap = "Figure 6. R Console Interface for Selecting Redundant Variables", fig.align = 'center', fig.pos = "H", eval = TRUE, echo = FALSE, comment = NA, warning = FALSE, message = FALSE----
# R console example
knitr::include_graphics("./Figures/Figure11.png", dpi = 600)

## ----Fig12, fig.cap = "Figure 7. Example of Reundancy Descriptives Table", fig.align = 'center', fig.pos = "H", eval = TRUE, echo = FALSE, comment = NA, warning = FALSE, message = FALSE----
# R console example
knitr::include_graphics("./Figures/Figure12.png", dpi = 600)

## ----Fig13 code, eval = FALSE, echo = TRUE, comment = NA, warning = FALSE, message = FALSE----
#  # EGA (with redundant variables removed)
#  ega.rm <- EGA(sapa.rm$reduced$data, algorithm = "louvain", plot.EGA = FALSE)
#  plot(ega.rm, plot.args = list(vsize = 8,
#                             edge.alpha = 0.2,
#                             label.size = 4,
#                             layout.exp = 0.5,
#                             legend.names = c("Conscientiousness",
#                                              "Neuroticism", "Extraversion",
#                                              "Openness to Experience",
#                                              "Agreeableness")))

## ----Fig13, fig.cap = "Figure 8. Exploratory Graph Analaysis of SAPA Inventory After Unique Variable Analysis (removed)", fig.align = 'center', fig.pos = "H", eval = TRUE, echo = FALSE, comment = NA, warning = FALSE, message = FALSE----
# Removed dimensionality
knitr::include_graphics("./Figures/Fig13-1.png", dpi = 75)

## ----table, eval = TRUE, echo = FALSE, comment = NA, warning = FALSE, message = FALSE----
# Read in .csv
merged <- read.csv("./merged.items.csv")
colnames(merged)[1] <- "Latent Variable"

# Make table
knitr::kable(merged)

