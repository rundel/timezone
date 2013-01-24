# timezone

This is a small R package that implements the function find_tz, which can be used to find the TZ timezone name that corresponds to the given geographic coordinates.

The package uses Eric Muller's shapefile of the TZ timezones of (available at http://efele.net/maps/tz/world/) to determine the appropriate timezone name. The package additionally implements functionality that uses the Google Maps API to find the timezone name (Note that this API limits you to a maximum of 2500 requests per day).

## Examples

```r
library(timezone)

# Los Angeles - 34.0522° N, 118.2428° W
find_tz(-118.2428,34.0522)
find_tz(-118.2428,34.0522, use_google=TRUE)

# Edinburgh - 55.9500° N, 3.2200° W
find_tz(cbind(-3.2200, 55.9500))

# Istanbul - 41.0128° N, 28.9744° E
find_tz(SpatialPoints(cbind(41.0128, 28.9744)))
```
