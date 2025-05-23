#' @title EGAnet-package
#'
#' @description Implements the Exploratory Graph Analysis (EGA) framework for dimensionality
#' and psychometric assessment. EGA estimates the number of dimensions in
#' psychological data using network estimation methods and community detection
#' algorithms. A bootstrap method is provided to assess the stability of dimensions
#' and items. Fit is evaluated using the Entropy Fit family of indices. Unique
#' Variable Analysis evaluates the extent to which items are locally dependent (or
#' redundant). Network loadings provide similar information to factor loadings and
#' can be used to compute network scores. A bootstrap and permutation approach are
#' available to assess configural and metric invariance. Hierarchical structures
#' can be detected using Hierarchical EGA. Time series and intensive longitudinal
#' data can be analyzed using Dynamic EGA, supporting individual, group, and
#' population level assessments.
#'
#' @references
#' Christensen, A. P. (2023).
#' Unidimensional community detection: A Monte Carlo simulation, grid search, and comparison.
#' \emph{PsyArXiv}. \cr
#' # Related functions: \code{\link[EGAnet]{community.unidimensional}}
#'
#' Christensen, A. P., Garrido, L. E., & Golino, H. (2023).
#' Unique variable analysis: A network psychometrics method to detect local dependence.
#' \emph{Multivariate Behavioral Research}. \cr
#' # Related functions: \code{\link[EGAnet]{UVA}}
#'
#' Christensen, A. P., Garrido, L. E., Guerra-Pena, K., & Golino, H. (2023).
#' Comparing community detection algorithms in psychometric networks: A Monte Carlo simulation.
#' \emph{Behavior Research Methods}. \cr
#' # Related functions: \code{\link[EGAnet]{EGA}}
#'
#' Christensen, A. P., & Golino, H. (2021a).
#' Estimating the stability of the number of factors via Bootstrap Exploratory Graph Analysis: A tutorial.
#' \emph{Psych}, \emph{3}(3), 479-500. \cr
#' # Related functions: \code{\link[EGAnet]{bootEGA}}, \code{\link[EGAnet]{dimensionStability}},
#' # and \code{\link[EGAnet]{itemStability}}
#'
#' Christensen, A. P., & Golino, H. (2021b).
#' Factor or network model? Predictions from neural networks.
#' \emph{Journal of Behavioral Data Science}, \emph{1}(1), 85-126. \cr
#' # Related functions: \code{\link[EGAnet]{LCT}}
#'
#' Christensen, A. P., & Golino, H. (2021c).
#' On the equivalency of factor and network loadings.
#' \emph{Behavior Research Methods}, \emph{53}, 1563-1580. \cr
#' # Related functions: \code{\link[EGAnet]{LCT}} and \code{\link[EGAnet]{net.loads}}
#'
#' Christensen, A. P., Golino, H., & Silvia, P. J. (2020).
#' A psychometric network perspective on the validity and validation of personality trait questionnaires.
#' \emph{European Journal of Personality}, \emph{34}, 1095-1108. \cr
#' # Related functions: \code{\link[EGAnet]{bootEGA}}, \code{\link[EGAnet]{dimensionStability}},
#' # \code{\link[EGAnet]{EGA}}, \code{\link[EGAnet]{itemStability}}, and \code{\link[EGAnet]{UVA}}
#'
#' Christensen, A. P., Gross, G. M., Golino, H., Silvia, P. J., & Kwapil, T. R. (2019).
#' Exploratory graph analysis of the Multidimensional Schizotypy Scale.
#' \emph{Schizophrenia Research}, \emph{206}, 43-51.
#' # Related functions: \code{\link[EGAnet]{CFA}} and \code{\link[EGAnet]{EGA}}
#'
#' Golino, H., Christensen, A. P., Moulder, R., Kim, S., & Boker, S. M. (2021).
#' Modeling latent topics in social media using Dynamic Exploratory Graph Analysis: The case of the right-wing and left-wing trolls in the 2016 US elections.
#' \emph{Psychometrika}. \cr
#' # Related functions: \code{\link[EGAnet]{dynEGA}} and \code{\link[EGAnet]{simDFM}}
#'
#' Golino, H., & Demetriou, A. (2017).
#' Estimating the dimensionality of intelligence like data using Exploratory Graph Analysis.
#' \emph{Intelligence}, \emph{62}, 54-70. \cr
#' # Related functions: \code{\link[EGAnet]{EGA}}
#'
#' Golino, H., & Epskamp, S. (2017).
#' Exploratory graph analysis: A new approach for estimating the number of dimensions in psychological research.
#' \emph{PLoS ONE}, \emph{12}, e0174035. \cr
#' # Related functions: \code{\link[EGAnet]{CFA}}, \code{\link[EGAnet]{EGA}}, and \code{\link[EGAnet]{bootEGA}}
#'
#' Golino, H., Moulder, R., Shi, D., Christensen, A. P., Garrido, L. E., Nieto, M. D., Nesselroade, J., Sadana, R., Thiyagarajan, J. A., & Boker, S. M. (2020).
#' Entropy fit indices: New fit measures for assessing the structure and dimensionality of multiple latent variables.
#' \emph{Multivariate Behavioral Research}. \cr
#' # Related functions: \code{\link[EGAnet]{entropyFit}}, \code{\link[EGAnet]{tefi}}, and \code{\link[EGAnet]{vn.entropy}}
#'
#' Golino, H., Nesselroade, J. R., & Christensen, A. P. (2022).
#' Towards a psychology of individuals: The ergodicity information index and a bottom-up approach for finding generalizations.
#' \emph{PsyArXiv}. \cr
#' # Related functions: \code{\link[EGAnet]{boot.ergoInfo}}, \code{\link[EGAnet]{ergoInfo}},
#' \code{\link[EGAnet]{jsd}}, and \code{\link[EGAnet]{infoCluster}}
#'
#' Golino, H., Shi, D., Christensen, A. P., Garrido, L. E., Nieto, M. D., Sadana, R., Thiyagarajan, J. A., & Martinez-Molina, A. (2020).
#' Investigating the performance of exploratory graph analysis and traditional techniques to identify the number of latent factors:
#' A simulation and tutorial.
#' \emph{Psychological Methods}, \emph{25}, 292-320. \cr
#' # Related functions: \code{\link[EGAnet]{EGA}}
#'
#' Golino, H., Thiyagarajan, J. A., Sadana, M., Teles, M., Christensen, A. P., & Boker, S. M. (2020).
#' Investigating the broad domains of intrinsic capacity, functional ability, and environment:
#' An exploratory graph analysis approach for improving analytical methodologies for measuring healthy aging.
#' \emph{PsyArXiv}. \cr
#' # Related functions: \code{\link[EGAnet]{EGA.fit}} and \code{\link[EGAnet]{tefi}}
#'
#' Jamison, L., Christensen, A. P., & Golino, H. (2021).
#' Optimizing Walktrap's community detection in networks using the Total Entropy Fit Index.
#' \emph{PsyArXiv}. \cr
#' # Related functions: \code{\link[EGAnet]{EGA.fit}} and \code{\link[EGAnet]{tefi}}
#'
#' Jamison, L., Golino, H., & Christensen, A. P. (2023).
#' Metric invariance in exploratory graph analysis via permutation testing.
#' \emph{PsyArXiv}. \cr
#' # Related functions: \code{\link[EGAnet]{invariance}}
#'
#' Shi, D., Christensen, A. P., Day, E., Golino, H., & Garrido, L. E. (2023).
#' A Bayesian approach for dimensionality assessment in psychological networks.
#' \emph{PsyArXiv} \cr
#' # Related functions: \code{\link[EGAnet]{EGA}}
#'
#' @author Hudson Golino <hfg9s@virginia.edu> and Alexander P. Christensen <alexpaulchristensen@gmail.com>
#'
#' @useDynLib EGAnet, .registration = TRUE
#'
#' @importFrom graphics par text
#' @importFrom methods formalArgs is
#' @importFrom stats as.dendrogram as.dist as.hclust complete.cases cor cov cov2cor cutree dist dnorm hclust ks.test mad median na.omit nlm nlminb optimize p.adjust pchisq pgamma pnorm qchisq qf qgamma qnorm qt quantile rnorm runif sd setNames t.test uniroot var wilcox.test
#' @importFrom utils browseURL capture.output combn data globalVariables object.size packageDescription packageVersion setTxtProgressBar txtProgressBar
#'
"_PACKAGE"
#> [1] "_PACKAGE"
#EGAnet----
