% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/events.modifications.R
\name{events.modifications}
\alias{events.modifications}
\alias{events.modification}
\alias{random.extinction}
\alias{trait.extinction}
\alias{bd.params.update}
\alias{traits.update}
\alias{modifiers.update}
\alias{founding.event}
\title{Events modifications}
\usage{
events.modification(x, ...)
}
\arguments{
\item{x}{a numerical value to update.}

\item{...}{any specific argument for the modification (see details).}
}
\value{
This function outputs a \code{"function"} to be passed to \code{\link{make.events}}.
}
\description{
Inbuilt modifications functions for helping designing events
}
\details{
The following functions allow to design specific modifications for events:

\itemize{
     
\item modifications for the target \code{"taxa"}
     \itemize{
         \item \code{random.extinction}: this function removes (makes extinct) a proportion of living taxa when the event is triggered. The proportion of taxa to remove can be changed with the argument \code{x}.
         \item \code{trait.extinction}: this function removes (makes extinct) a number of living taxa based on their trait(s) values when the event is triggered. The trait value is specified with the argument \code{x}.This function has one optional argument:
         \itemize{
             \item{condition} to specify the condition in relation to that trait value (the default is \code{condition = `<`} meaning taxa with a trait value lower that \code{x} will go extinct).
             \item{trait} to specify which trait will be affected (the default is \code{trait = 1}, meaning it will only consider the first trait).
         }

     }

\item modifications for the target \code{"bd.params"}
     \itemize{
         \item \code{bd.params.update}: this function updates a \code{"bd.params"} object within the birth death process. It takes any unambiguous named argument to be passed to \code{\link{make.bd.params}}. For example, to update the speciation from any current rate to a new rate of 42, you can use \code{bd.params.update(speciation = 42)}.
     }

\item modifications for the target \code{"traits"} 
     \itemize{
         \item \code{traits.update}: this function updates a \code{"traits"} object within the birth death process. It takes any unambiguous named argument to be passed to \code{\link{make.traits}}. For example, to update the trait process from the current one to an OU process, you can use \code{traits.update(process = OU.process)}.
     }

\item modifications for the target \code{"modifiers"}
     \itemize{
         \item \code{modifiers.update}: this function updates a \code{"modifiers"} object within the birth death process. It takes any unambiguous named argument to be passed to \code{\link{make.modifiers}}. For example, to update the speciation from the current process to be dependent to trait values, you can use \code{modifiers.update(speciation = speciation.trait)}.
     }

\item modifications for the target \code{"founding"} 
     \itemize{
         \item \code{founding.event}: this function runs an independent birth-death process when the condition is met. This function takes any of the arguments normally passed to \code{\link{treats}} (\code{"bd.params"}, \code{"traits"}, \code{"modifiers"} and \code{"events"}). The \code{stop.rule} and other arguments are handled internally: namely the \code{stop.rule} argument is updated to match the time and number of taxa when the founding event is triggered. \emph{Note that this can lead to the simulation stopping just before reaching the \code{max.taxa} or \code{max.living} stop rule}.
     }
}

More details about the \code{events} functions is explained in the \code{treats} manual: \url{http://tguillerme.github.io/treats}.
}
\examples{
## Generating a mass extinction
## 80\% mass extinction at time 4
mass_extinction <- make.events(
                      target       = "taxa",
                      condition    = age.condition(4),
                      modification = random.extinction(0.8))

## Set the simulation parameters
stop.rule <- list(max.time = 5)
bd.params <- list(extinction = 0, speciation = 1)

## Run the simulations
set.seed(123)
results <- treats(bd.params = bd.params,
                stop.rule = stop.rule,
                events    = mass_extinction)
## Plot the results
plot(results, show.tip.label = FALSE)
axisPhylo()

## Changing the trait process
## The 95\% upper quantile value of a distribution
upper.95 <- function(x) {
    return(quantile(x, prob = 0.95))
} 
## Create an event to change the trait process
change_process <- make.events(
                  target       = "traits",
                  ## condition is triggered if(upper.95(x) > 3)
                  condition    = trait.condition(3, condition = `>`, what = upper.95),
                  modification = traits.update(process = OU.process))

## Set the simulation parameters
bd.params <- list(extinction = 0, speciation = 1)
stop.rule <- list(max.time = 6)
traits    <- make.traits()

## Run the simulations
set.seed(1)
no_change <- treats(bd.params = bd.params,
                  stop.rule = stop.rule,
                  traits    = traits)
set.seed(1)
process_change <- treats(bd.params = bd.params,
                       stop.rule = stop.rule,
                       traits    = traits,
                       events    = change_process)
## Plot the results
oldpar <- par(mfrow = c(1,2))
plot(no_change, ylim = c(-7, 7))
plot(process_change, ylim = c(-7, 7))
par(oldpar)


}
\seealso{
\code{\link{treats}} \code{\link{make.events}} \code{\link{events.conditions}}
}
\author{
Thomas Guillerme
}
