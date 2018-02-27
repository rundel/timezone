library(maptools)

library(httr)
library(jsonlite)

api_data <- GET("https://api.github.com/repos/evansiroky/timezone-boundary-builder/releases/latest")
latest <- fromJSON(content(api_data, "text"))

url <- with(latest$assets, browser_download_url[name == "timezones.shapefile.zip"])

d = tempdir()
out_file = file.path(d,"world.zip")

download.file(url, destfile=out_file)
unzip(out_file, exdir=d)

world_tz_shapes = readShapeSpatial(file.path(d,"dist","combined_shapefile.shp"))

save(world_tz_shapes, file = "./world_tz_shapes.rda")