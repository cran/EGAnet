#' Dimension Stability Statistics from \code{\link[EGAnet]{bootEGA}}
#'
#' @description Based on the \code{\link[EGAnet]{bootEGA}} results, this function
#' computes the stability of dimensions. This is computed by assessing the proportion
#' of items that replicate within the defined factor/dimension (see argument \code{orig.wc})
#' for each bootstrap. The mean of these proportions represent the dimensional stability
#' for each dimension
#' 
#' @param bootega.obj A \code{\link[EGAnet]{bootEGA}} object
#'
#' @param orig.wc Numeric or character.
#' A vector with community numbers or labels for each item.
#' Typically uses community results (\code{wc}) from \code{\link[EGAnet]{EGA}}
#'
#' @param item.stability Boolean.
#' Should the item stability statistics be computed
#' using \code{[EGAnet]{itemStability}}?
#' Defaults to \code{TRUE}
#' 
#' @return When argument \code{item.stability = TRUE}, returns a list containing:
#' 
#' \item{dimensions}{The dimensional stability of each dimension}
#' 
#' \item{items}{The output from \code{[EGAnet]{itemStability}}}
#' 
#' When argument \code{item.stability = FALSE}, returns a vector of the
#' dimensional stability of each dimension
#'
#' @examples
#'
#' # Load data
#' wmt <- wmt2[,7:24]
#'
#' \dontrun{
#' # Estimate EGA network
#' ega.wmt <- EGA(data = wmt, model = "glasso")
#'
#' # Estimate dimension stability
#' boot.wmt <- bootEGA(data = wmt, n = 100, typicalStructure = TRUE,
#' plot.typicalStructure = TRUE, model = "glasso",
#' type = "parametric", ncores = 4)
#'
#' }
#'
#' # Estimate item stability statistics
#' dimStability(boot.wmt, orig.wc = ega.wmt$wc, item.stability = FALSE)
#'
#' @seealso \code{\link[EGAnet]{EGA}} to estimate the number of dimensions of an instrument using EGA and
#' \code{\link[EGAnet]{CFA}} to verify the fit of the structure suggested by EGA using confirmatory factor analysis.
#'
#' @author Hudson F. Golino <hfg9s at virginia.edu> and Alexander P. Christensen <alexpaulchristensen@gmail.com>
#'
#' @export
#Dimension Stability function
dimStability <- function(bootega.obj, orig.wc, item.stability = TRUE)
{
  if(class(bootega.obj) != "bootEGA")
  {stop("Input for 'bootega.obj' is not a 'bootEGA' object")}
  
  # Compute item stability
  items <- EGAnet::itemStability(bootega.obj, orig.wc, item.freq = 0, plot.item.rep = item.stability)
  
  # Compute dimension stability
  ## Grab dimensions from itemStability output
  dims <- items$wc
  ## Identify unique dimensions
  uniq.dim <- sort(unique(orig.wc))
  ## Number of dimensions
  dim.len <- length(uniq.dim)
  ## Initialize dimension stability vector
  dim.stab <- numeric(dim.len)
  names(dim.stab) <- uniq.dim
  
  # Loop through dims
  for(i in 1:dim.len)
  {
    # Target items
    target <- which(orig.wc == uniq.dim[i])
    
    # Initialize count vector
    dim.count <- numeric(length = ncol(dims))
    
    # Identify consistency across bootstraps
    for(j in 1:ncol(dims))
    {dim.count[j] <- length(which(dims[target,j] == uniq.dim[i])) / length(target)}
    
    # Input mean into dimension stabiltiy vector
    dim.stab[i] <- mean(dim.count)
  }
  
  # Results list
  if(item.stability)
  {
    res <- list()
    res$dimensions <- round(dim.stab,3)
    res$items <- items
  }else{res <- round(dim.stab,3)}
  
  return(res)
}
#----