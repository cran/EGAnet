#' @title Estimates \code{\link[EGAnet]{EGA}} for Multidimensional Structures
#'
#' @description A basic function to estimate \code{\link[EGAnet]{EGA}} for multidimensional structures.
#' This function does \emph{not} include the unidimensional check and it does not
#' plot the results. This function can be used as a streamlined approach
#' for quick \code{\link[EGAnet]{EGA}} estimation when unidimensionality or visualization
#' is not a priority
#'
#' @param data Matrix or data frame.
#' Should consist only of variables to be used in the analysis
#'
#' @param n Numeric (length = 1).
#' Sample size if \code{data} provided is a correlation matrix
#'
#' @param corr Character (length = 1).
#' Method to compute correlations.
#' Defaults to \code{"auto"}.
#' Available options:
#'
#' \itemize{
#'
#' \item \code{"auto"} --- Automatically computes appropriate correlations for
#' the data using Pearson's for continuous, polychoric for ordinal,
#' tetrachoric for binary, and polyserial/biserial for ordinal/binary with
#' continuous. To change the number of categories that are considered
#' ordinal, use \code{ordinal.categories}
#' (see \code{\link[EGAnet]{polychoric.matrix}} for more details)
#'
#' \item \code{"cor_auto"} --- Uses \code{\link[qgraph]{cor_auto}} to compute correlations.
#' Arguments can be passed along to the function
#'
#' \item \code{"cosine"} --- Uses \code{\link[EGAnet]{cosine}} to compute cosine similarity
#'
#' \item \code{"pearson"} --- Pearson's correlation is computed for all
#' variables regardless of categories
#'
#' \item \code{"spearman"} --- Spearman's rank-order correlation is computed
#' for all variables regardless of categories
#'
#' }
#'
#' For other similarity measures, compute them first and input them
#' into \code{data} with the sample size (\code{n})
#'
#' @param na.data Character (length = 1).
#' How should missing data be handled?
#' Defaults to \code{"pairwise"}.
#' Available options:
#'
#' \itemize{
#'
#' \item \code{"pairwise"} --- Computes correlation for all available cases between
#' two variables
#'
#' \item \code{"listwise"} --- Computes correlation for all complete cases in the dataset
#'
#' }
#'
#' @param model Character (length = 1).
#' Defaults to \code{"glasso"}.
#' Available options:
#'
#' \itemize{
#'
#' \item \code{"BGGM"} --- Computes the Bayesian Gaussian Graphical Model.
#' Set argument \code{ordinal.categories} to determine
#' levels allowed for a variable to be considered ordinal.
#' See \code{?BGGM::estimate} for more details
#'
#' \item \code{"glasso"} --- Computes the GLASSO with EBIC model selection.
#' See \code{\link[EGAnet]{EBICglasso.qgraph}} for more details
#'
#' \item \code{"TMFG"} --- Computes the TMFG method.
#' See \code{\link[EGAnet]{TMFG}} for more details
#'
#' }
#'
#' @param algorithm Character or
#' \code{igraph} \code{cluster_*} function (length = 1).
#' Defaults to \code{"walktrap"}.
#' Three options are listed below but all are available
#' (see \code{\link[EGAnet]{community.detection}} for other options):
#'
#' \itemize{
#'
#' \item \code{"leiden"} --- See \code{\link[igraph]{cluster_leiden}} for more details
#'
#' \item \code{"louvain"} --- By default, \code{"louvain"} will implement the Louvain algorithm using
#' the consensus clustering method (see \code{\link[EGAnet]{community.consensus}}
#' for more information). This function will implement
#' \code{consensus.method = "most_common"} and \code{consensus.iter = 1000}
#' unless specified otherwise
#'
#' \item \code{"walktrap"} --- See \code{\link[igraph]{cluster_walktrap}} for more details
#'
#' }
#'
#' @param verbose Boolean (length = 1).
#' Whether messages and (insignificant) warnings should be output.
#' Defaults to \code{FALSE} (silent calls).
#' Set to \code{TRUE} to see all messages and warnings for every function call
#'
#' @param ... Additional arguments to be passed on to
#' \code{\link[EGAnet]{auto.correlate}},
#' \code{\link[EGAnet]{network.estimation}},
#' \code{\link[EGAnet]{community.detection}}, and
#' \code{\link[EGAnet]{community.consensus}}
#'
#' @author Alexander P. Christensen <alexpaulchristensen at gmail.com> and Hudson Golino <hfg9s at virginia.edu>
#'
#' @return Returns a list containing:
#'
#' \item{network}{A matrix containing a network estimated using
#' \code{link[EGAnet]{network.estimation}}}
#'
#' \item{wc}{A vector representing the community (dimension) membership
#' of each node in the network. \code{NA} values mean that the node
#' was disconnected from the network}
#'
#' \item{n.dim}{A scalar of how many total dimensions were identified in the network}
#'
#' \item{cor.data}{The zero-order correlation matrix}
#'
#' \item{n}{Number of cases in \code{data}}
#'
#' @examples
#' # Obtain data
#' wmt <- wmt2[,7:24]
#'
#' # Estimate EGA
#' ega.wmt <- EGA.estimate(data = wmt)
#'
#' # Estimate EGA with TMFG
#' ega.wmt.tmfg <- EGA.estimate(data = wmt, model = "TMFG")
#'
#' # Estimate EGA with an {igraph} function (Fast-greedy)
#' ega.wmt.greedy <- EGA.estimate(
#'   data = wmt,
#'   algorithm = igraph::cluster_fast_greedy
#' )
#'
#' @references
#' \strong{Original simulation and implementation of EGA} \cr
#' Golino, H. F., & Epskamp, S. (2017).
#' Exploratory graph analysis: A new approach for estimating the number of dimensions in psychological research.
#' \emph{PLoS ONE}, \emph{12}, e0174035.
#'
#' \strong{Introduced unidimensional checks, simulation with continuous and dichotomous data} \cr
#' Golino, H., Shi, D., Christensen, A. P., Garrido, L. E., Nieto, M. D., Sadana, R., & Thiyagarajan, J. A. (2020).
#' Investigating the performance of Exploratory Graph Analysis and traditional techniques to identify the number of latent factors: A simulation and tutorial.
#' \emph{Psychological Methods}, \emph{25}, 292-320.
#'
#'
#' \strong{Compared all} \code{igraph} \strong{community detection algorithms, simulation with continuous and polytomous data} \cr
#' Christensen, A. P., Garrido, L. E., Guerra-Pena, K., & Golino, H. (2023).
#' Comparing community detection algorithms in psychometric networks: A Monte Carlo simulation.
#' \emph{Behavior Research Methods}.
#'
#' @seealso \code{\link[EGAnet]{plot.EGAnet}} for plot usage in \code{EGAnet}
#'
#' @export
#'
# Estimates multidimensional EGA only (no automatic plots)
# Updated 21.09.2024
EGA.estimate <- function(
    data, n = NULL,
    corr = c("auto", "cor_auto", "cosine", "pearson", "spearman"),
    na.data = c("pairwise", "listwise"),
    model = c("BGGM", "glasso", "TMFG"),
    algorithm = c("leiden", "louvain", "walktrap"),
    verbose = FALSE, ...
)
{

  # Check for missing arguments (argument, default, function)
  corr <- set_default(corr, "auto", EGA.estimate)
  na.data <- set_default(na.data, "pairwise", auto.correlate)
  model <- set_default(model, "glasso", network.estimation)
  algorithm <- set_default(algorithm, "walktrap", community.detection)

  # Argument errors (return data in case of tibble)
  data <- EGA.estimate_errors(data, n, verbose, ...)

  # Obtain ellipse arguments
  ellipse <- list(needs_usable = FALSE, ...)

  # Handle legacy arguments (`model.args` and `algorithm.args`)
  ellipse <- legacy_EGA_args(ellipse)

  # Ensure data has names
  data <- ensure_dimension_names(data)

  # First, get necessary inputs
  output <- obtain_sample_correlations(
    data = data, n = n,
    corr = corr, na.data = na.data,
    verbose = verbose, needs_usable = FALSE, # skips usable data check
    ...
  )

  # Get outputs
  data <- output$data; n <- output$n
  correlation_matrix <- output$correlation_matrix

  # Model branching checks (in order of most likely to be used)
  # GLASSO = can handle correlation matrix but needs iterative gamma procedure
  # BGGM = needs original data and not correlation matrix
  # TMFG = can handle correlation matrix
  if(model == "glasso"){

    # Use wrapper to clean up iterative gamma procedure
    network <- glasso_wrapper(
      data = correlation_matrix, n = n, corr = corr,
      na.data = na.data, model = model, network.only = TRUE,
      verbose = verbose, ellipse = ellipse
    )

  }else{

    # Set up network estimation arguments
    estimation_ARGS <- list(
      n = n, corr = corr, na.data = na.data,
      model = model, network.only = TRUE,
      verbose = verbose
    )

    # Check for BGGM
    if(model == "bggm"){

      # Check for correlation input
      if(is_symmetric(data)){
        stop(
          "A symmetric matrix was provided in the 'data' argument. For 'model = \"BGGM\"', the original data is required.",
          call. = FALSE
        )
      }

      # Set "data" as data
      estimation_ARGS$data <- data

    }else if(model == "tmfg"){ # Set "data" as correlation matrix
      estimation_ARGS$data <- correlation_matrix
    }

    # Estimate network
    network <- do.call(
      what = network.estimation,
      args = c(
        estimation_ARGS,
        ellipse # pass on ellipse
      )
    )

  }

  # Check for function or non-Louvain method
  if(is.function(algorithm) || algorithm != "louvain"){

    # Apply non-Louvain method
    wc <- do.call(
      what = community.detection,
      args = c(
        list(
          network = network, algorithm = algorithm,
          membership.only = TRUE
        ),
        ellipse # pass on ellipse
      )
    )

  }else{ # for Louvain, use consensus clustering

    # Check for consensus method
    if(!"consensus.method" %in% names(ellipse)){
      ellipse$consensus.method <- "most_common" # default
    }

    # Check for consensus iterations
    if(!"consensus.iter" %in% names(ellipse)){
      ellipse$consensus.iter <- 1000 # default
    }

    # Apply consensus clustering
    wc <- do.call(
      what = community.consensus,
      args = c(
        list(
          network = network,
          correlation.matrix = correlation_matrix,
          membership.only = TRUE
        ),
        ellipse # pass on ellipse
      )
    )

  }

  # Set up results
  results <- list(
    network = network, wc = wc,
    n.dim = unique_length(wc),
    cor.data = correlation_matrix,
    n = n
  )

  # Set class (attributes are stored in `network` and `wc`)
  class(results) <- "EGA.estimate"

  # Return results
  return(results)

}

# Bug checking ----
## Basic input
# data = wmt2[,7:24]; n = NULL
# corr = "auto"; na.data = "pairwise"
# model = "glasso"; algorithm = igraph::cluster_spinglass
# verbose = FALSE; ellipse = list()

#' @noRd
# Errors ----
# Updated 07.09.2023
EGA.estimate_errors <- function(data, n, verbose, ...)
{

  # 'data' errors
  object_error(data, c("matrix", "data.frame", "tibble"), "EGA.estimate")

  # Check for tibble
  if(get_object_type(data) == "tibble"){
    data <- as.data.frame(data)
  }

  # 'n' errors
  if(!is.null(n)){
    length_error(n, 1, "EGA.estimate")
    typeof_error(n, "numeric", "EGA.estimate")
  }

  # 'verbose' errors
  length_error(verbose, 1, "EGA.estimate")
  typeof_error(verbose, "logical", "EGA.estimate")

  # Check for usable data
  if(needs_usable(list(...))){
    data <- usable_data(data, verbose)
  }

  # Return data (in case of tibble)
  return(data)

}

#' @exportS3Method
# S3 Print Method ----
# Updated 22.06.2023
print.EGA.estimate <- function(x, ...)
{

  # Print network estimation
  print(x$network)

  # Add break space
  cat("\n----\n\n")

  # Print community detection
  print(x$wc)

}

#' @exportS3Method
# S3 Summary Method ----
# Updated 22.06.2023
summary.EGA.estimate <- function(object, ...)
{
  print(object, ...) # same as print
}

#' @exportS3Method
# S3 Plot Method ----
# Updated 22.06.2023
plot.EGA.estimate <- function(x, ...)
{

  # Return plot
  single_plot(
    network = x$network,
    wc = x$wc,
    ...
  )

}

#' @noRd
# Wrapper for GLASSO ----
# Updated 23.07.2023
glasso_wrapper <- function(
    network, data, n, corr, na.data,
    model, network.only, verbose,
    ellipse
)
{

  # Go with `gamma` provided
  if("gamma" %in% names(ellipse)){

    # Obtain `gamma`
    gamma <- ellipse$gamma

    # Remove `gamma` from ellipse
    ellipse <- ellipse[names(ellipse) != "gamma"]

    # Return result
    return(
      do.call(
        what = network.estimation,
        args = c(
          list( # functions passed into this function
            data = data, n = n, corr = corr, na.data = na.data,
            model = model, network.only = TRUE, verbose = verbose,
            gamma = gamma
          ),
          ellipse # pass on ellipse
        )
      )
    )

  }

  # Set gamma
  gamma <- 0.50

  # Check for any disconnected nodes
  while(TRUE){

    # Re-estimate network
    network <- do.call(
      what = network.estimation,
      args = c(
        list( # functions passed into this function
          data = data, n = n, corr = corr, na.data = na.data,
          model = model, network.only = TRUE, verbose = verbose,
          gamma = gamma
        ),
        ellipse # pass on ellipse
      )
    )

    # Check for disconnected nodes
    if(any(colSums(abs(network), na.rm = TRUE) == 0) && gamma > 0){
      gamma <- gamma - 0.25 # decrease gamma
    }else{
      break # all nodes are connected or gamma equals zero
    }

  }

  # Return network
  return(network)

}

