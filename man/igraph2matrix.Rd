% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/igraph2matrix.R
\name{igraph2matrix}
\alias{igraph2matrix}
\title{Convert \code{} network to matrix}
\usage{
igraph2matrix(igraph_network, diagonal = 0)
}
\arguments{
\item{igraph_network}{\code{} network object}

\item{diagonal}{Numeric (length = 1).
Value to be placed on the diagonal of \code{network}.
Defaults to \code{0}}
}
\value{
Returns a network in the \code{} format
}
\description{
Converts \code{} network to matrix
}
\examples{
# Convert network to {igraph}
igraph_network <- convert2igraph(ega.wmt$network)

# Convert network back to matrix
igraph2matrix(igraph_network)

}
\author{
Hudson Golino <hfg9s at virginia.edu> & Alexander P. Christensen <alexander.christensen at Vanderbilt.Edu>
}
