# Class5: Data visualization 

# Today we are going to use ggplot2 packages to help us visualize data

#First we need to load the packages! 
library(ggplot2)


# We will use this inbiult "cars" dataset first
head(cars)

# All ggplots have at least 3 layers, 
# data + aes + geoms
ggplot(cars) + 
  aes(x=speed, y=dist) +
  #geom_points develops scatter plot 
  #do different plots with geom_(type of graph you want)
  #lm= linear model (linearizes data sets)
  #smooth adds line of best regression 
  #method is used to argue what methods we want to see to visualize data 
  geom_point() + 
  geom_smooth(method="lm") +
  #labs= labels that we will be adding to the data set
  labs(title="Stopping Distance of Old Cars", 
                      x="Speed (MPH)", y="Stopping Distance (ft)")

#Side-not: ggplot is not the only graphics system 
#a very popular one is good old "base" R graphcs 
url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)
nrow(genes)
colnames(genes)
ncol(genes)
table(genes$State)
round(table(genes$State)/nrow(genes) * 100, 2)
ggplot(genes) + 
  aes(x=Condition1, y=Condition2, col=State) +
  geom_point()
p <- ggplot(genes) + 
  aes(x=Condition1, y=Condition2, col=State) +
  geom_point()
p 
p+scale_color_manual(values = c("green", "antiquewhite4", "dark green")) + 
  labs(x="Control (No Drug Treatment)", y="Drug Treatment", title="Gene Expresion Changes Upon Drug Treatment")
#install.packages("gapminder")
library(gapminder)


ggplot(gapminder) + aes(x=year, y=lifeExp, col=continent) + geom_jitter(width=0.3, alpha=0.4) + geom_violin(aes(group=year), alpha=0.2, draw_quantiles=0.5)

#install.packages("plotly")
#library (plotly)
#ggplotly()

# install.packages("dplyr")  ## uncoment to install if needed
#install.packages("dplyr")
library(dplyr)
gapminder_2007 <- gapminder %>% filter(year==2007)
gapminder_2007
ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp, size=pop) +
  #aplha makes the points transparent
  geom_point(alpha=0.5) + 
  scale_size_area(max_size = 10)

gapminder_1957 <- gapminder %>% filter(year==1957)

ggplot(gapminder_1957) + 
  aes(x = gdpPercap, y = lifeExp, color=continent,size = pop) +
  geom_point(alpha=0.7) + 
  scale_size_area(max_size = 10) 

gapminder_1957 <- gapminder %>% filter(year==1957 | year==2007)
# the |year ==2007 will add the data from 2007 next to 1957 data sets
ggplot(gapminder_1957) + 
  aes(x = gdpPercap, y = lifeExp, color=continent,size = pop) +
  geom_point(alpha=0.7) + 
  scale_size_area(max_size = 10) + 
  facet_wrap(~year)
#You should now include the layer facet_wrap(~year) to produce the following plot:

gapminder_top5 <- gapminder %>% 
  filter(year==2007) %>% 
  arrange(desc(pop)) %>% 
  top_n(5, pop)

gapminder_top5
ggplot(gapminder_top5) + 
  geom_col(aes(x = country, y = pop, fill=continent))

ggplot(gapminder_top5) + 
  geom_col(aes(x = country, y = pop, fill=lifeExp))

# Plot population size by country
ggplot(gapminder_top5) +
  aes(x=reorder (country, -pop), y=pop, fill=country) +
  geom_col(col="gray30") +
  guides(fill=FALSE)

#FLIPPING CHARTS
head(USArrests)
USArrests$State <- rownames(USArrests)
ggplot(USArrests) +
  aes(x=reorder(State,Murder), y=Murder) +
  geom_col() +
  coord_flip()

ggplot(USArrests) +
  aes(x=reorder(State,Murder), y=Murder) +
  geom_point() +
  geom_segment(aes(x=State, 
                   xend=State, 
                   y=0, 
                   yend=Murder), color="blue") +
  coord_flip()

#install.packages("gifski")
#install.packages("gganimate")
library(gapminder)
library(gganimate)

# Setup nice regular ggplot of the gapminder data
#ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  #geom_point(alpha = 0.7, show.legend = FALSE) +
  #scale_colour_manual(values = country_colors) +
  #scale_size(range = c(2, 12)) +
  #scale_x_log10() +
  # Facet by continent
  #facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  #labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  #transition_time(year) +
  #shadow_wake(wake_length = 0.1, alpha = FALSE)


#install.packages("patchwork")
library(patchwork)

# Setup some example plots 
p1 <- ggplot(mtcars) + geom_point(aes(mpg, disp))
p2 <- ggplot(mtcars) + geom_boxplot(aes(gear, disp, group = gear))
p3 <- ggplot(mtcars) + geom_smooth(aes(disp, qsec))
p4 <- ggplot(mtcars) + geom_bar(aes(carb))

# Use patchwork to combine them here:
(p1 | p2 | p3) / p4




