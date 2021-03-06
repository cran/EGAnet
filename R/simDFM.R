#' Simulate data following a Dynamic Factor Model
#'
#' @description Function to simulate data following a dynamic factor model (DFM). Two DFMs are currently available:
#' the direct autoregressive factor score model (Engle & Watson, 1981; Nesselroade, McArdle, Aggen, and Meyers, 2002) and the
#' dynamic factor model with random walk factor scores.
#'
#' @param variab Number of variables per factor.
#'
#' @param timep Number of time points.
#'
#' @param nfact Number of factors.
#'
#' @param error Value to be used to construct a diagonal matrix Q. This matrix is p x p covariance matrix Q that will
#' generate random errors following a multivariate normal distribution with mean zeros.
#' The value provided is squared before constructing Q.
#'
#' @param dfm A string indicating the dynamical factor model to use.
#' Current options are:
#'
#' \itemize{
#'
#' \item{\strong{\code{DAFS}}}
#' {Simulates data using the direct autoregressive factor score model.
#' This is the default method}
#'
#' \item{\strong{\code{RandomWalk}}}
#' {Simulates data using a dynamic factor model with random walk factor scores.}
#'}
#'
#' @param loadings Magnitude of the loadings.
#'
#' @param autoreg Magnitude of the autoregression coefficients.
#'
#' @param crossreg Magnitude of the cross-regression coefficients.
#'
#' @param var.shock Magnitude of the random shock variance.
#'
#' @param cov.shock Magnitude of the random shock covariance
#'
#' @param burnin Number of n first samples to discard when computing the factor scores. Defaults to 1000.
#'
#' @examples
#'
#'
#' \dontrun{
#' \donttest{
#' # Estimate EGA network
#' data1 <- simDFM(variab = 5, timep = 50, nfact = 3, error = 0.05,
#' dfm = "DAFS", loadings = 0.7, autoreg = 0.8,
#' crossreg = 0.1, var.shock = 0.18,
#' cov.shock = 0.36, burnin = 1000)
#'  }
#'}
#'
#' @references
#'
#' A one-factor multivariate time series model of metropolitan wage rates.
#' \emph{Journal of the American Statistical Association}, \emph{76(376)}, 774-781.
#' ref:\href{https://amstat.tandfonline.com/doi/abs/10.1080/01621459.1981.10477720#.XmkWWy2ZMuA}{01621459.1981.10477720#.XmkWWy2ZMuA}
#'
#' Nesselroade, J. R., McArdle, J. J., Aggen, S. H., & Meyers, J. M. (2002).
#' Dynamic factor analysis models for representing process in multivariate time-series. In D. S. Moskowitz & S. L. Hershberger (Eds.),
#' \emph{Multivariate applications book series. Modeling intraindividual variability with repeated measures data: Methods and applications}, 235–265.
#' \href{https://psycnet.apa.org/record/2001-05300-009}{https://psycnet.apa.org/record/2001-05300-009}
#'
#' @author Hudson F. Golino <hfg9s at virginia.edu>
#'
#' @export
#Dimension Stability function
simDFM <- function(variab, timep, nfact, error, dfm = c("DAFS","RandomWalk"),
                   loadings, autoreg, crossreg, var.shock, cov.shock, burnin = 1000){

  #### MISSING ARGUMENTS HANDLING ####
  if(missing(dfm))
  {dfm <- "DAFS"
  }else{level <- match.arg(dfm)}

  # Factor Scores:

  if(dfm == "VAR1"){
    # B = Matrix of Bl is a nfact x nfact matrix containing the autoregressive and cross-regressive coefficients
    B <- matrix(autoreg, ncol = nfact, nrow = nfact)
    diag(B) <- crossreg

    # Shock = Random shock vectors following a multivariate normal distribution with mean zeros and nfact x nfact q covariance matrix D
    D <- matrix(var.shock,nfact,nfact)
    diag(D) <- cov.shock
    Shock <- MASS::mvrnorm(burnin+timep,matrix(0,nfact,1),D)

    Fscores <- matrix(0,burnin+timep,nfact)
    Fscores[1,] <- Shock[1,]

    for (t in 2: (burnin+timep)){
      Fscores[t,] <- Fscores[t-1,] %*% B+ Shock[t,]
    }
    Fscores <- Fscores[-c(1:burnin),]

  }else{
    Fscores <- matrix(rnorm(nfact*(burnin+timep), 0, 1), nfact, burnin+timep)
    Fscores <- Fscores[,-c(1:burnin)]
    ## nfact x timep matrix of scaled latent trends
    Fscores <- scale(apply(Fscores,1,cumsum))
  }


  LoadMat <- as.matrix(Matrix::bdiag(lapply(rep(loadings, nfact), rep, variab)))

  ## Error: multivariate normal distribution with mean zeros and p x p covariance matrix Q
  var <- error^2
  Q <- diag(var,variab*nfact,variab*nfact)
  e <- t(MASS::mvrnorm(timep, matrix(0,variab*nfact,1),Q))


  ## Simulated obs data
  obs.data <- LoadMat %*% t(Fscores) + e
  obs.data <- as.data.frame(t(obs.data))
  colnames(obs.data) <- paste0("V", 1:ncol(obs.data))
  results <- list()
  results$data <- obs.data
  results$Fscores <- as.data.frame(Fscores)
  colnames(results$Fscores) <- paste0("F", 1:ncol(Fscores))
  results$LoadMat <- LoadMat
  results$Structure <- rep(1:nfact, each = variab)
  return(results)
}
#----
