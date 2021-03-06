\name{GenerateQualificationRequirement}
\alias{GenerateQualificationRequirement}
\title{Generate QualificationRequirement}
\description{Generate a QualificationRequirement data structure for use with \code{\link{CreateHIT}} or \code{\link{RegisterHITType}}.}
\usage{
GenerateQualificationRequirement(qual, comparator, value, preview = NULL, 
                                qual.number = NULL, format = "REST")
}
\arguments{
  \item{qual}{A character string containing a QualificationTypeId, or a vector of QualificationTypeIds. This parameter also accepts shorthand labels for built-in QualificationTypes: \dQuote{Approved} (percent of assignments approved), \dQuote{NumberApproved} (number of assignments approved), \dQuote{Locale}, \dQuote{Adult}, and MTurk \dQuote{masters} QualificationTypes (\dQuote{Masters}, \dQuote{Categorization}, or \dQuote{Photo Moderation}).}
  \item{comparator}{A character string containing a comparator, or a vector of comparators, by which a worker's score of a qualification is compared to the specified \code{value}. One of \code{<},\code{<=},\code{>},\code{>=},\code{==},\code{!=},\code{Exists}. For \dQuote{Masters}-type qualifications, only \code{Exists} is available.}
  \item{value}{A numeric or character string value (or vecotr of such) against which workers scores will be compared. Must be a non-negative integer.}
  \item{preview}{An optional logical specifying whether a worker must have the Qualification in order to preview the HIT on the MTurk worker site. The default is \code{FALSE}.}
  \item{qual.number}{An optional integer. Intended only for advanced users to construct custom QualificationRequirements.}
  \item{format}{Format of QualificationRequirement (SOAP or REST). Currently only REST is supported (and is the default).}
}
\details{
A convenience function to translate the details of a QualificationRequirement into the necessary structure for use in the \code{qual.req} parameter of \code{\link{CreateHIT}} or \code{\link{RegisterHITType}}. The function accepts three required parameters: \code{qual}, \code{comparator}, and \code{value}. \code{qual} must be a valid QualificationTypeId for either a built-in QualificaitonType (see \code{\link{ListQualificationTypes}}) or a custom QualificationType (e.g., one created with \code{\link{CreateQualificationType}}). Multiple QualificationRequirements can be generated in one call --- that is, if a requester intends to impose multiple QualificationRequirements on a single HITType, those requirements must be specified in a single call to \code{GenerateQualificationRequirements}. Once attached to a HITType, only workers who meet all of the specified QualificationRequirements can complete assignments for a HIT of that HITType.
}
\value{Returns a character string containing one or more QualificationRequirements in the form of URL query parameters.}
\references{
\href{http://docs.amazonwebservices.com/AWSMechTurk/latest/AWSMturkAPI/ApiReference_QualificationRequirementDataStructureArticle.html}{API Reference}
}
\author{Thomas J. Leeper}
%\note{}
\seealso{
\code{\link{CreateHIT}}

\code{\link{RegisterHITType}}
}
\examples{
\dontrun{
a <- ListQualificationTypes()[2,2] # Number of HITs Approved
b <- GenerateQualificationRequirement(a,">","90")
}
}
\keyword{Qualifications}
