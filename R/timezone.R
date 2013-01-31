find_tz = function(x, y, p4s = "", use_google = FALSE)
{
    if (missing(x))
        stop("X and Y coordinates or a SpatialPoints object must be provided.")

    if (inherits(x, "SpatialPoints"))
    {
        coords = as.data.frame(x)
    }
    else
    {
        x = as.matrix(x)
        if (!missing(y))
            coords = cbind(x,y)
        else
            coords = x
    }

    if(ncol(coords) != 2)
        stop("Expected X and Y coordinates.")

    if (p4s != "")
    {
        coords = project(coords, p4s, inverse=TRUE)
    }

    if (use_google)
    {
        tzs = apply(coords,1,get_google_tz)
    }
    else
    {
        if (!exists("world_tz_shapes",envir=.TZ_DATA))
            load(system.file("world_tz_shapes.rda",package="timezone"),envir=.TZ_DATA)

        zone_ids = as.character(get("world_tz_shapes",envir=.TZ_DATA)@data[,1])

        coords = SpatialPoints(coords,proj4string=CRS(p4s))
        tz_index = t(gIntersects(get("world_tz_shapes",envir=.TZ_DATA), coords, byid=TRUE))

        if (any(apply(tz_index,2,sum) > 1))
        {
            stop("Some coordinates reported multiple timezones - Indexes: ",  
                 paste(which(apply(tz_index,2,sum) > 1),collapse=", "))
        }

        tzs = apply(tz_index,2,function(x) {
                if(sum(x) == 0) 
                    NA 
                else 
                    zone_ids[x]
            })

        names(tzs) = NULL
    }

    return(tzs)
}

get_google_tz = function(coords)
{
    # Google Maps API Documentation
    # https://developers.google.com/maps/documentation/timezone/

    stopifnot(length(coords) == 2)

    require(RCurl)
    require(RJSONIO)

    url = paste0("https://maps.googleapis.com/maps/api/timezone/json?location=",coords[2],",",coords[1], "&timestamp=0&sensor=false")

    id = fromJSON(getURL(url))$timeZoneId 

    return( ifelse(is.null(id), NA, id) )
}