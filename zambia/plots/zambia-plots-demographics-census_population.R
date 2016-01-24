require(tikzDevice)
require(ggplot2)
require(reshape2)
require(grid)
require(scales)
require(ggthemes)
require(extrafont)

dataset1 <- read.csv(
text="Census,European,Asiatic,Coloured,African,Total
1911,1497,39,0,820000,821536
1921,3634,56,145,980000,983835
1931,13846,176,425,1330000,1344447
1946,21907,1117,804,1660000,1683828
1951,37221,2529,1092,1890000,1930842
1956,65277,5450,1577,2100000,2172304
1963,,,,,3490540
1969,,,,,4056995
1980,,,,,5661801
1990,,,,,7383097
2000,,,,,9885591
2010,,,,,13092666", header=TRUE
)

dataset <- read.csv(
text="Census,European,Asiatic,Coloured,African,Total
1963,,,,,3490540
1969,,,,,4056995
1980,,,,,5661801
1990,,,,,7383097
2000,,,,,9885591
2010,,,,,13092666", header=TRUE
)

experimentdataset <- melt(dataset[c(1, 6)], id.vars=c(1))

experimentdataset["yaba"] <- "Population of Zambian territories 1900 - 2010"


#png(filename = "zambia-plots-demographics-census_population.png")

options(scipen=999)

pp <- ggplot(data=experimentdataset,
       aes(x=as.factor(Census),
           y=value,
           colour="wheat",
           group=variable)) +
             ggtitle("Population in Zambia 1960 - 2010") + 
             ylim(0, 20000000) +
             scale_y_continuous(breaks = seq(0, 20000000, 2000000)) +
             #geom_line(aes(linetype=variable), size=1.5) +
             geom_line(size=0.6) +
             labs(x="Year",y="Population") +
             theme_bw() + 
             theme(
                   text=element_text(family="CM Roman"),
                   legend.title=element_blank(),
                   legend.position="none",
                   #legend.text=element_text(size=14),
                   plot.margin=unit(c(0.1,0,0,0),"cm"),
                   axis.title.x = element_text(vjust=-0.8, face="bold", size = 12),
                   axis.title.y = element_text(vjust=-0.2, face="bold", size = 12),
                   axis.text.x = element_text(face = "italic"),
                   axis.text.y = element_text(face = "italic"),
                   plot.title = element_text(lineheight=.8, face="bold")
                   )

svg("zambia-plots-demographics-census_population.svg", bg = 'transparent', height = 2.5)

pp

dev.off()