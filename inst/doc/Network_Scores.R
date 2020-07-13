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
ega <- EGA(neoOpen, model = "glasso", algorithm = "louvain")

## ----loadings, echo = TRUE, message = FALSE, warning = FALSE------------------
# Standardized
n.loads <- net.loads(A = ega)$std

## ----scores, echo = TRUE, message = FALSE, warning = FALSE--------------------
# Network scores
net.scores <- net.scores(data = neoOpen, A = ega)

## ----latent scores setup, echo = FALSE, eval = TRUE, message = FALSE, warning = FALSE----
# Latent variable scores
## Estimate CFA
output <- capture.output(cfa.net <- CFA(ega, estimator = "WLSMV", data = neoOpen, plot.CFA = FALSE))

## Compute latent variable scores
lv.scores <- lavPredict(cfa.net$fit)

## Initialize correlations vector
cors <- numeric(ega$n.dim)

## Compute correlations
for(i in 1:ega$n.dim)
{cors[i] <- cor(net.scores$std.scores[,i], lv.scores[,i], method = "spearman")}

## Create matrix for table
cors.mat <- as.matrix(round(cors,3))
colnames(cors.mat) <- "Correlations"
row.names(cors.mat) <- paste("Factor", 1:ega$n.dim)

## ----latent scores present, echo = TRUE, eval = FALSE, message = FALSE, warning = FALSE----
#  # Latent variable scores
#  ## Estimate CFA
#  cfa.net <- CFA(ega, estimator = "WLSMV", data = neoOpen)
#  
#  ## Compute latent variable scores
#  lv.scores <- lavPredict(cfa.net$fit)
#  
#  ## Initialize correlations vector
#  cors <- numeric(ega$n.dim)
#  
#  ## Compute correlations
#  for(i in 1:ega$n.dim)
#  {cors[i] <- cor(net.scores$std.scores[,i], lv.scores[,i], method = "spearman")}

## ----latent scores table, echo = FALSE, eval = TRUE, message = FALSE, warning = FALSE----
# Print table
knitr::kable(cors.mat)

