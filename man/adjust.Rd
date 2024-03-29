% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adjust.R
\name{adjust}
\alias{adjust}
\alias{adjust.editmatrix}
\alias{adjust.sparseConstraints}
\alias{adjust.matrix}
\title{DEPRECATED Adjust a data to meet linear (in)equality constraints}
\usage{
adjust(object, ...)

\method{adjust}{editmatrix}(object, x, w = rep(1, length(x)), method = c("dense", "sparse"), ...)

\method{adjust}{sparseConstraints}(object, x, w = rep(1, length(x)), tol = 0.01, maxiter = 1000L, ...)

\method{adjust}{matrix}(
  object,
  b,
  x,
  neq = length(b),
  w = rep(1, length(x)),
  tol = 0.01,
  maxiter = 1000L,
  ...
)
}
\arguments{
\item{object}{an \code{R} object describing constraints (see details)}

\item{...}{Arguments to be passed to other methods}

\item{x}{The vector to be adjusted}

\item{w}{A positive weight vector}

\item{method}{use dense or sparse matrix method.}

\item{tol}{The maximum allowed deviation from the constraints (see details).}

\item{maxiter}{maximum number of iterations}

\item{b}{Constant vector of the constraint system \eqn{Ax\leq b}}

\item{neq}{the first \code{neq} linear relations are equalities.}
}
\value{
Object of class \code{\link{adjusted}}.
}
\description{
Adjust a vector \eqn{\boldsymbol{x}} to meet
constraints \eqn{\boldsymbol{Ax} \leq \boldsymbol{b}}. 
As of version 0.2 this function is deprecated. Please use
\itemize{
\item{\code{\link[lintools]{project}} from package \code{\link[lintools]{lintools}} to replace \code{adjust.matrix}}
\item{\code{\link[lintools]{sparse_project}} from pacakge \code{\link[lintools]{lintools}} to replace \code{adjust.sparseConstraints}}
}
}
\section{Details}{

\code{adjust} is a generic function allowing several definitions of the constraints in \code{object}.

\itemize{
 \item{\code{editmatrix}:If \code{object} is an \code{editmatrix}, the function will 
   try to match the names of \code{x} to the variable names in \code{object} before further
   processing. In that case the \code{length} of \code{x} is unimportant, as long as all variables in \code{object} 
   are also in \code{x}. Depending on the choice of \code{method}, \code{object} is converted to \code{matrix} or 
   \code{sparseConstraints} format before solving the adjustment problem.
 }
 \item{\code{matrix}: If \code{object} is a \code{matrix}, you also need to provide the constant vector
  \code{b} and the number of equations \code{neq} to define the problem. It is assumed that the first
  \code{neq} rows of \code{object} and the first \code{new} elements of \code{b} correspond to equalities. No names are matched, so \code{x}
   must be in the correct order and must be of the right dimension.
   See \code{\link{sparseConstraints}} on how to translate
   a \code{matrix} problem to the sparse version.
 } 

\item{\code{sparseConstraints}: If \code{object} is of class \code{\link{sparseConstraints}}, 
  the sparse method is used to adjust \code{x}. Some basic checks on \code{x} and \code{w} 
  are performed, but no attempt is made to match names of \code{x} to those of \code{object}.
}
}

The tolerance \code{tol} is defined as the maximum absolute value of the difference vector 
\eqn{\boldsymbol{Ax}-\boldsymbol{b}} for equalities. For inequalities, the difference vector
is set to zero when it's value is lesser than zero (i.e. when the restriction is obeyed). The
function keeps iterating until either the tolerance is met, the number of allowed iterations is
exceeded or divergence is detected.
}

\section{Note}{

\code{adjust} does not perform any consistency checks. When the system of constraints is
contradictory (\emph{e.g.} \eqn{x>1} and \eqn{x<0}) this will result in either divergence
or in exceeding the number of iterations.
}

\keyword{internal}
