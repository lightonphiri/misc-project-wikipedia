{{CSS image crop
|Image         = File:Provincial Administrative Divisions of Zambia.svg
|bSize         = The Base Image size (the image we are cropping on)
|cWidth        = Crop Image Width in pixels
|cHeight       = Crop image Height in pixels
|oTop          = Offset Top in pixels
|oLeft         = Offset Left in pixels
|Location      = 'right', 'left', 'center' or 'none'. Determines placement of the image on the page
                 Defaults to 'right' when description is provided (as is default for thumb images)
                 When description is blank, location on left (as is default for non-thumbs)
|Description   = Description (will render out using thumbnail class)
|Link          = Name of an article to be linked by clicking on the image (omit unless there is a
                 good reason to link to an article instead of the image).
|Alt           = The alt text for the image.
|Page          = The page of the file, if there are multiple pages (such as pdf files).
|magnify-link  = The image to be linked by the magnify icon (Use if the Image parameter is set to
                 {{Annotated image}} or the Link parameter leads to something other than the image).
}}



[[File:Provincial Administrative Divisions of Zambia.svg|540px|left|Map of Zambia with the ten administrative divisions]]


library(maptools)
library(mapproj)
library(RColorBrewer)
library(ggmap)

colors <- brewer.pal(9, "RdPu")
colors <- brewer.pal(9, "BuGn")

ZMB_water_areas <- readShapePoly("../data/ZMB_water_areas_dcw.shp")
ZMB_water_areas <- readShapePoly("../data/ZMB_water_lines_dcw.shp")



mapImage <- get_map(location = c(lon = 28.17, lat = -15.25),
  color = "color",
  source = "osm",
  maptype = "roadmap",
  zoom = 6)

  
mapImage <- get_map(location = "Zambia",
  color = "color",
  source = "osm",
  maptype = "roadmap",
  zoom = 4)
  
  
ZMB_map <- get_map(location = 'Zambia',source = "google", maptype = "terrain", zoom = 6)

pp <- ggmap(ZMB_map) + 
geom_polygon(aes(x = long,
      y = lat,
      group = group),
    data = ZMB_water_areas.points,
    color = colors[9],
    fill = colors[6],
    alpha = 0.5) +
labs(x = "Longitude", y = "Latitude")  +
theme(text=element_text(family="CM Roman"))

svg("zambia-maps-geography_climate-geography.svg", bg = 'transparent')

pp
        
dev.off()
  

ggmap(mapImage) +
  geom_polygon(aes(x = long,
      y = lat,
      group = group),
    data = ZMB_water_areas.points,
    color = colors[9],
    fill = colors[6],
    alpha = 0.5) +
labs(x = "Longitude",
  y = "Latitude")

