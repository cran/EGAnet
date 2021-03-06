% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dnn.weights.R
\docType{data}
\name{dnn.weights}
\alias{dnn.weights}
\title{Loadings Comparison Test Deep Learning Neural Network Weights}
\format{
A list of with a length of 4
}
\usage{
data(dnn.weights)
}
\description{
A list of weights from four different neural network models:
random vs. non-random model (\code{r_nr_weights}),
low correlation factor vs. network model (\code{lf_n_weights}),
high correlation with variables less than or equal to factors vs. network model (\code{hlf_n_weights}), and
high correlation with variables greater than factors vs. network model (\code{hgf_n_weights})
}
\examples{
data("dnn.weights")

}
\keyword{datasets}
