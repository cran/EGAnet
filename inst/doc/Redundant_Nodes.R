## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#"
)

## ----install, echo = TRUE, eval = FALSE, message = FALSE, warning = FALSE-----
#  # Install 'psychTools' package
#  devtools::install_version("psychTools", version = 1.9.12)

## ----load, echo = TRUE, message = FALSE, warning = FALSE----------------------
# Load packages
library(psychTools)

## ----background packages load, eval = TRUE, echo = FALSE, comment = NA, warning = FALSE, message = FALSE----
# Load background packages
library(kableExtra)
library(EGAnet)

## ----data, eval = TRUE, echo = TRUE, comment = NA, warning = FALSE, message = FALSE----
# Select Five Factor Model personality items only
idx <- na.omit(match(gsub("-", "", unlist(spi.keys[1:5])), colnames(spi)))
items <- spi[,idx]

## ----wto example, eval = TRUE, echo = TRUE, comment = NA, warning = FALSE, message = FALSE, cache = FALSE----
# Identify redundant nodes
redund <- node.redundant(items, type = "wTO", method = "adapt")

# Change names in redundancy output to each item's description
key.ind <- match(colnames(items), as.character(spi.dictionary$item_id))
key <- as.character(spi.dictionary$item[key.ind])

# Use key to rename variables
named.nr <- node.redundant.names(redund, key)

## ----tab1, eval = TRUE, echo = FALSE, comment = NA, warning = FALSE, message = FALSE, cache = FALSE----
# Example of first element in redundancy list
knitr::kable(named.nr$redundant[1], booktabs = TRUE,
             col.names = names(named.nr$redundant)[1],
             align = 'c', caption = "Example of first element in redundancy list") %>% kable_styling(latex_options = "hold_position")

## ----combine NR example, eval = FALSE, echo = TRUE, comment = NA, warning = FALSE, message = FALSE, cache = FALSE----
#  # Combining redundant responses
#  combined.nr <- node.redundant.combine(named.nr, type = "optimal")

## ----Fig1, fig.cap = "An example of the menu that appears for each redundant item",  fig.align = 'center', fig.pos = "H", warning=FALSE, message=FALSE, echo=FALSE----
knitr::include_graphics(path = "./Figure_SI1_Code.png", dpi = 900)

## ----Fig2, fig.cap = "An example of a redundancy chain plot. The red node indicates the target item and the white nodes with numbers correspond to the numbered options (Figure 1). A connection represents significant overlap determined by the redundancy analysis and the thickness of the connection represents the regularized partial correlation between the nodes in the network.",  fig.align = 'center', fig.pos = "H", warning=FALSE, message=FALSE, echo=FALSE----
knitr::include_graphics(path = "./Figure_SI2_NR.png", dpi = 900)

