library(maptools)

url = "http://efele.net/maps/tz/world/tz_world_mp.zip"

d = tempdir()
out_file = file.path(d,"world.zip")

download.file(url, destfile=out_file)
unzip(out_file, exdir=d)

world_tz_shapes = readShapeSpatial(file.path(d,"world","tz_world_mp.shp"))

save(world_tz_shapes, file = "./world_tz_shapes.rda")