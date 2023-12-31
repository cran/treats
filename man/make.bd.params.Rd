% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make.bd.params.R
\name{make.bd.params}
\alias{make.bd.params}
\title{Make birth death parameters}
\usage{
make.bd.params(
  speciation = NULL,
  extinction = NULL,
  joint = NULL,
  absolute = NULL,
  speciation.args = NULL,
  extinction.args = NULL,
  test = TRUE,
  update = NULL
)
}
\arguments{
\item{speciation}{The speciation parameter. Can be a single \code{numeric} value, a \code{numeric} vector or a \code{function} (default is \code{1}).}

\item{extinction}{The extinction parameter. Can be a single \code{numeric} value, a \code{numeric} vector or a \code{function} (default is \code{0}).}

\item{joint}{Logical, whether to estimate both birth and death parameter jointly with speciation > extinction (\code{TRUE}) or not (\code{FALSE}; default).}

\item{absolute}{Logical, whether always return absolute values (\code{TRUE}) or not (\code{FALSE}; default).}

\item{speciation.args}{If \code{speciation} is a function, any additional arguments to passed to the \code{speciation} function.}

\item{extinction.args}{If \code{speciation} is a function, any additional arguments to passed to the \code{speciation} function.}

\item{test}{Logical whether to test if the bd.params object will work (default is \code{TRUE}).}

\item{update}{Optional, another previous \code{"treats"} \code{"bd.params"} object to update (see details).}
}
\value{
This function outputs a \code{treats} object that is a named list of elements handled internally by the \code{\link{treats}} function.
}
\description{
Making bd.params objects for treats.
}
\details{
When using \code{update}, the provided arguments (to \code{make.bd.params}) will be the ones updated in the \code{"bd.params"} object.
}
\examples{
## A default set of birth death parameters
make.bd.params()

## Speciation is randomly picked between 1, 10 and 100
## and extinction is always 2
make.bd.params(speciation = c(1,10,100), extinction = 2)

## Speciation is a normal distribution(with sd = 0.75)
## and extinction is a lognormal distribution always lower than
## speciation (joint). Both are always positive values (absolute)
my_bd_params <- make.bd.params(speciation = rnorm,
                               speciation.args = list(sd = 0.75),
                               extinction = rlnorm,
                               joint = TRUE,
                               absolute = TRUE)
my_bd_params

## Visualising the distributions
plot(my_bd_params)


}
\seealso{
\code{\link{treats}}
}
\author{
Thomas Guillerme
}
