library(ggplot2)
require(extrafont)
library(maps)
library(mapproj)
library(ggplot2)
library(ggmap)
library(rgdal)
library(maptools)
if (!require(gpclib)) install.packages("gpclib", type="source")
gpclibPermit()

languages.df <- read.table(text="Region,Language,Percent
Central,Bemba,31.8
Copperbelt,Bemba,83.9
Eastern,Chewa,34.6
Luapula,Bemba,71.3
Lusaka,Nyanja,61.9
Muchinga,Bemba,46.9
Northern,Bemba,69.2
North-Western,Lunda,33.8
Southern,Tonga,74.7
Western,Lozi,69.6
", header=TRUE, sep=",")


zambia.adm1.spdf <- readOGR(dsn="../data", layer="ZMB_adm1")
zambia.adm1.df <- fortify(zambia.adm1.spdf, region = "NAME_1")
#zambia.adm1.df <- merge(zambia.adm1.df, census.df, by.y="KEY", by.x="id")
zambia.adm1.df <- merge(zambia.adm1.df, languages.df, by.y="Region", by.x="id")


zambia.adm1.centroids.df <- data.frame(long = coordinates(zambia.adm1.spdf)[, 1], 
   lat = coordinates(zambia.adm1.spdf)[, 2]) 

# Get names and id numbers corresponding to administrative areas
zambia.adm1.centroids.df[, 'ID_1'] <- zambia.adm1.spdf@data[,'ID_1']
zambia.adm1.centroids.df[, 'NAME_1'] <- zambia.adm1.spdf@data[,'NAME_1']
zambia.adm1.centroids.df <- merge(zambia.adm1.centroids.df, languages.df, by.y="Region", by.x="NAME_1")


pp <- ggplot(zambia.adm1.df, aes(x = long, y = lat, group = group)) + 
  geom_polygon(aes(fill = Language)) +
  geom_path(colour = 'black', linetype = 1) + 
  #geom_text(data = zambia.adm1.centroids.df, aes(label = Percent, x = long, y = lat, group = NAME_1), size=9*0.35, family = "CM Roman", fontface = "bold") + 
  labs(x=" ", y=" ") + 
  theme_bw() +  
  scale_fill_brewer(palette = "RdYlBu") +
  #scale_fill_manual(values = c("#f0f0f0", "#f0f0f0", "#f0f0f0", "#f0f0f0", "#f0f0f0", "#f0f0f0", "#f0f0f0", "#f0f0f0", "#f0f0f0", "#f0f0f0")) +
  coord_map() +
  #guides(fill = guide_legend(nrow = 1, byrow = TRUE)) +
  theme(
        text=element_text(family="CM Roman"),
        panel.background = element_blank(),
        panel.background = element_rect(fill = "transparent",colour = NA),
        panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(),
        panel.border = element_blank(),
        plot.margin=unit(c(-0.7,-0.8,-1.3,-1.3),"cm"),
        legend.title = element_blank(),
        legend.position = "none",
        axis.ticks = element_blank(), 
        axis.text.x = element_blank(), 
        axis.text.y = element_blank()
        )

svg("zambia-maps-demographics-regional_languages.svg", bg = 'transparent')

pp
        
dev.off()