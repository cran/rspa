\name{adjustedRecords}
\alias{adjustedRecords}
\alias{plot.adjustedRecords}
\alias{print.adjustedRecords}
\alias{summary.adjustedRecords}
\title{Adjusted records}
\usage{
  \method{print}{adjustedRecords} (x, ...)

  \method{summary}{adjustedRecords} (object, ...)

  \method{plot}{adjustedRecords} (x, ...)
}
\arguments{
  \item{x}{object of class \code{adjustedRecords}}

  \item{...}{additional parameters to pass to other
  methods}

  \item{object}{object of class \code{adjustedRecords}}
}
\description{
  Adjusted records
}
\section{Details}{
  The \code{adjustedRecords} object contains adjusted data
  as well as some information on the adjusting process. In
  particular: \itemize{ \item{\code{\$adjusted}:
  \code{data.frame} similar to \code{dat} with adjusted
  values.}

  \item{\code{$status}: \code{data.frame} with the same
  number of rows as \code{dat}. Each row stores the
  information of one \code{\link{adjusted}} object.} }

  When printed, only the first 10 rows of
  \code{cbind(adjusted, status)} are shown. Use
  \code{summary} for a quick overview. The \code{plot}
  method shows kernel density estimates of the accuracy and
  objective functions. To avoid densities at values below
  0, the accuracy densities are evaluated under a
  sqrt-transform and transformed back before plotting. For
  the objective function values a log-transform is used.
}
\seealso{
  \code{\link{adjustRecords}}
}

