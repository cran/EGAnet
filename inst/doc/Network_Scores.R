## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#"
)

## ----install, echo = TRUE, eval = FALSE, message = FALSE, warning = FALSE-----
#  # Install 'NetworkToolbox' package
#  install.packages("NetworkToolbox")
#  # Install 'lavaan' package
#  install.packages("lavaan")

## ----load, echo = TRUE, message = FALSE, warning = FALSE----------------------
# Load packages
library(EGAnet)
library(NetworkToolbox)
library(lavaan)

## ----Fig1, fig.align = 'center', fig.pos = "H", echo = TRUE, message = FALSE, warning = FALSE----
# Run EGA
ega <- EGA(neoOpen)

## ----loadings, echo = TRUE, message = FALSE, warning = FALSE------------------
# Standardized
net.loads <- net.loads(A = ega)$std

## ----scores, echo = TRUE, message = FALSE, warning = FALSE--------------------
# Network scores
net.scores <- net.scores(data = neoOpen, A = ega)

