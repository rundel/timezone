\name{find_tz}
\alias{find_tz}

\title{TZ timezone name query}

\description{Returns TZ timezone names for each provided location.}

\usage{
find_tz(x, y, p4s = "", use_google = FALSE)
}

\arguments{
  \item{x}{the x coordinates of the locations. Alternatively, an n x 2 matrix or data frame of coordinates or an sp SpatialPoints object.}
  \item{y}{the y coordinates of the locations, optional if x is an appropriate structure.}
  \item{p4s}{the proj4 string for the coordinates if they are not currently in lat / long.}
  \item{use_google}{boolean argumenting indicating if the Google Maps API should be used.}
}

\details{
Given a set of coordinates this functions returns the timezone names for each using either Eric Muller's world timezone shapefile (\url{http://efele.net/maps/tz/world/}) or the Google Maps API.

For locations where an approapriate timezone name is not found \code{NA} will be returned.
}

\value{
A vector of timezone names.
}
\author{
Colin Rundel
}

\examples{
library(lubridate)

cities = data.frame(
            City = c("Tokyo", "Shanghai", "New Delhi", "Moscow", "Istanbul", "New York", "London"), 
            Lat  = c(35.685, 31.045, 28.6, 55.752, 41.018, 40.714, 51.514), 
            Long = c(139.751, 121.399, 77.2, 37.615, 28.964, -74.006, -0.093)
         )

(tzs = find_tz(cities$Long, cities$Lat)) 

lapply(tzs, now)
}
