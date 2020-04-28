# Import dataset----
library(tidyquant)

movies <- read_csv("Movie-Ratings.csv")                         

colnames(movies) <- c("Film","Genre","CriticRating","AudienceRating","BudgetMillions","Year")  

glimpse(movies)

summary(movies)

movies$Year <- as.factor(movies$Year)

glimpse(movies)


# Aesthetics----

ggplot(movies, aes(x=CriticRating, y=AudienceRating))

#add geometry
ggplot(movies, aes(x=CriticRating, y=AudienceRating)) + 
  geom_point()

#add colour
ggplot(movies, aes(x=CriticRating, y=AudienceRating, 
                        colour=Genre)) + 
  geom_point()

#add size 
ggplot(movies, aes(x=CriticRating, y=AudienceRating, 
                        colour=Genre, size=BudgetMillions)) + 
  geom_point()


# Overriding Aesthetics----
p1 <- ggplot(movies, aes(x=CriticRating, y=AudienceRating,
                        colour=Genre, size=BudgetMillions))

p1 + geom_point(aes(size=CriticRating))


# Mapping vs Setting----

p2 <- ggplot(movies, aes(x=CriticRating, y=AudienceRating))
p2 + geom_point()

#Add colour
#1. Mapping 
p2 + geom_point(aes(colour=Genre))
#Setting:
p2 + geom_point(colour="DarkGreen")
#ERROR:
p2 + geom_point(aes(colour="DarkGreen"))

#Add size
#1. Mapping
p2 + geom_point(aes(size=BudgetMillions))
#Setting:
p2 + geom_point(size=7)
#ERROR:
p2 + geom_point(aes(size=7))


# Histograms----

p3 <- ggplot(movies, aes(x=BudgetMillions))

p3 + geom_histogram(binwidth = 10)
p3 + geom_histogram(binwidth = 10, fill="Green")
p3 + geom_histogram(binwidth = 10, aes(fill=Genre))
p3 + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")


# Boxplot----

p4 <- ggplot(movies, aes(x=CriticRating, y=AudienceRating, 
                        colour=Genre))

p4 + geom_boxplot()
p4 + geom_boxplot(size=1.2)


# Using Facets----

p5 <- ggplot(movies, aes(x=BudgetMillions))
p5 + geom_histogram(binwidth=10, aes(fill=Genre), 
                   colour="Black")

#facets  - - - - - install.packages("stringr")
p5 + geom_histogram(binwidth=10, aes(fill=Genre), 
                   colour="Black") + 
  facet_grid(Genre~.)


#scatterplots
p6 <- ggplot(movies,aes(x=CriticRating, y=AudienceRating,
                            colour=Genre))
p6 + geom_point(size=2)

#facets
p6 + geom_point(size=2) + 
  facet_grid(Genre~.,scales="free")

p6 + geom_point(size=2) + 
  facet_grid(.~Year,scales="free")

p6 + geom_point(size=2) + 
  geom_smooth(method = "loess") +
  facet_grid(Genre~Year,scales="free")


# Theme----

p <- ggplot(movies, aes(x=BudgetMillions)) + 
  geom_histogram(binwidth=10, aes(fill=Genre), colour="Black")


p + 
  xlab("Money Axis") + 
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour="DarkGreen", size=30),
        axis.title.y = element_text(colour="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20))


#title
p + 
  xlab("Money Axis") + 
  ylab("Number of Movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(colour="DarkGreen", size=30),
        axis.title.y = element_text(colour="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=15),
        legend.text = element_text(size=15),
        
        plot.title = element_text(colour="DarkBlue",
                                  size=30))
