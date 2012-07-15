\name{adjust}
\alias{adjust}
\alias{adjust.editmatrix}
\alias{adjust.matrix}
\alias{adjust.sparseConstraints}
\title{Adjust a data to meet linear (in)equality constraints}
\usage{
  adjust(object, ...)

  \method{adjust}{editmatrix} (object, x,
    w = rep(1, length(x)), method = c("dense", "sparse"),
    ...)

  \method{adjust}{sparseConstraints} (object, x,
    w = rep(1, length(x)), tol = 0.01, maxiter = 1000L,
    ...)

  \method{adjust}{matrix} (object, b, x, neq = length(b),
    w = rep(1, length(x)), tol = 0.01, maxiter = 1000L,
    ...)
}
\arguments{
  \item{object}{an \code{R} object describing constraints
  (see details)}

  \item{...}{Arguments to be passed to other methods}

  \item{method}{use dense or sparse matrix method.}

  \item{b}{Constant vector of the constraint system
  \eqn{Ax\leq b}}

  \item{x}{The vector to be adjusted}

  \item{neq}{the first \code{neq} linear relations are
  equalities.}

  \item{w}{A positive weight vector}

  \item{tol}{The maximum allowed deviation from the
  constraints (see details).}

  \item{maxiter}{maximum number of iterations}
}
\value{
  Object of class \code{\link{adjusted}}.
}
\description{
  Adjust a vector \eqn{\boldsymbol{x}} to meet constraints
  \eqn{\boldsymbol{Ax} \leq \boldsymbol{b}}.
}
\section{Details}{
  \code{adjust} is a generic function allowing several
  definitions of the constraints in \code{object}.

  \itemize{ \item[editmatrix]{If \code{object} is an
  \code{editmatrix}, the function will try to match the
  names of \code{x} to the variable names in \code{object}
  before further processing. In that case the \code{length}
  of \code{x} is unimportant, as long as all variables in
  \code{object} are also in \code{x}. Depending on the
  choice of \code{method}, \code{object} is converted to
  \code{matrix} or \code{sparseConstraints} format before
  solving the adjustment problem.  } \item[matrix]{If
  \code{object} is a \code{matrix}, you also need to
  provide the constant vector \code{b} and the number of
  equations \code{neq} to define the problem. It is assumed
  that the first \code{neq} rows of \code{object} and the
  first \code{new} elements of \code{b} correspond to
  equalities. No names are matched, so \code{x} must be in
  the correct order and must be of the right dimension.
  See \code{\link{sparseConstraints}} on how to translate a
  \code{matrix} problem to the sparse version.  }

  \item[sparseConstraints] {If \code{object} is of class
  \code{\link{sparseConstraints}}, the sparse method is
  used to adjust \code{x}. Some basic checks on \code{x}
  and \code{w} are performed, but no attempt is made to
  match names of \code{x} to those of \code{object}. } }

  The tolerance \code{tol} is defined as the maximum
  absolute value of the difference vector
  \eqn{\boldsymbol{Ax}-\boldsymbol{b}} for equalities. For
  inequalities, the difference vector is set to zero when
  it's value is lesser than zero (i.e. when the restriction
  is obeyed). The function keeps iterating until either the
  tolerance is met, the number of allowed iterations is
  exceeded or divergence is detected.
}

\section{Note}{
  \code{adjust} does not perform any consistency checks.
  When the system of constraints is contradictory
  (\emph{e.g.} \eqn{x>1} and \eqn{x<0}) this will result in
  either divergence or in exceeding the number of
  iterations.
}
\examples{

# a very simple adjustment example
E <- editmatrix(expression(
	x + y == 10,
	x > 0,
	y > 0
)) 

# x and y will be adjusted by the same amount
adjust(E, c(x=4,y=5))

# One of the inequalies violated
adjust(E, c(x=-1,y=5))

# Weighted distances: 'heavy' variables change less
adjust(E,c(x=4,y=5), w=c(100,1))

# if w=1/x0, the ratio between coefficients of x0 stay the same (to first order)
x0 <- c(x=4,y=5)
x1 <- adjust(E,x0,w=1/x0)

x0[1]/x0[2]
x1$x[1] / x1$x[2]



}

