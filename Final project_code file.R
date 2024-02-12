
# install packages and libraries 

install.packages("plm")
install.packages("lmtest")
install.packages("car")
install.packages("GGally")
install.packages(c('ggplot2','dplyr','hrbrthemes','viridis', 'patchwork'))
install.packages("sf")
install.packages("raster")
install.packages("tmap")  
install.packages("leaflet")
install.packages("ggspatial")
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
install.packages("ggmap")
install.packages("scales")
install.packages("maps")
install.packages("here")
install.packages("remotes")
install.packages(c("cartography","sp"))
install.packages("usmap")
install.packages("gganimate")
install.packages("magick")
install.packages("webshot2")
install.packages("corrplot")

library(ggplot2)
library(dplyr)
library(viridis)
library(hrbrthemes)
library(GGally)
library(plm)
library(lmtest)
library(car)
library(patchwork)
library(usmap) 
library(sf)
library(raster)
library(spData)
library(tmap)  
library(ggspatial)
library(rnaturalearth)
library(ggmap)
library(leaflet)
library(scales)
library(cartography)
library(sp)
library(webshot2)
library(magick)
library(gganimate)
library(corrplot)



options(scipen = 999)

# Loading data set and Cleaning it before exploratory data analysis 

energy_data<-read.csv("D:\\Rutgers MPI Courses\\Data Visualisation\\Final Project\\Workings\\Final\\Energy_Dataset_MDA.csv")

energy_data <- data.frame(lapply(energy_data, function(x) if(is.numeric(x)) as.integer(x) else x))
str(energy_data)

summary(energy_data)


# Exploratory Data Analysis

####*** checking Energy Consumption Data distribution through Violin Plot****


states_to_compare=c('PA','NJ','NY')


state.Data=data.frame() #Dummy datafarme

#using for loop for creating subset dataframe of selected counties

for(I in 1:length(states_to_compare))
{
  Dat1=energy_data[which(energy_data$STATE==states_to_compare[I]),c(1,2,6,9)]
  state.Data=rbind(state.Data,Dat1) #Append data through looping  
}

head(state.Data)

# Calculate the median value for each country

median_data <- state.Data %>%
  group_by(STATE) %>%
  summarise(Median = quantile(EC_TOTAL, 0.5), Observations = n())

# setting limits for my plot

y_axis_limits <- seq(170000, 1100000, by = 200000)
y_axis_intervals <- seq(170000, 1100000, by = 200000)

state.Data %>%
  left_join(median_data, by = c("STATE" = "STATE")) %>% # to join data set with median values
  mutate(myaxis = paste0(STATE, "\n", "n=", Observations)) %>%
  ggplot(aes(x = myaxis, y = EC_TOTAL, fill = STATE)) + # plot parameters
  geom_violin(position = position_dodge(width = 0.5), width = 0.8) +
  geom_point(aes(x = myaxis, y = Median, color = STATE, size = 3)) +
  geom_text(aes(x = myaxis, y = Median, label = round(Median, 1)), vjust = -1.2, size = 3, color = "white", hjust = 0.5) +
  scale_fill_viridis(discrete = TRUE) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 20),
  ) +
  ggtitle("VIOLIN PLOT WITH MEDIAN ENERGY CONSUMPTION BY STATE") +
  xlab("STATE") +
  ylab("ENERGY CONSUMPTION (000 MWH)") +
  scale_y_continuous(breaks = y_axis_intervals, limits = c(min(y_axis_limits), max(y_axis_limits)))+
  theme(
    axis.title.x = element_text(hjust = 0.5),  # Center x-axis label
    axis.title.y = element_text(hjust = 0.5, vjust = 0.5),# Center y-axis label
    plot.title = element_text(hjust = 0.5)
  )


#*****#### checking Renewable Energy Generation Data distribution through Violin Plot*****

states_to_compare=c('PA','NJ','NY')


state.Data=data.frame() #Dummy datafarme

#using for loop for creating subset dataframe of selected counties

for(I in 1:length(states_to_compare))
{
  Dat1=energy_data[which(energy_data$STATE==states_to_compare[I]),c(1,2,6,9)]
  state.Data=rbind(state.Data,Dat1) #Append data through looping  
}

head(state.Data)

# Calculate the median value for each country

median_data <- state.Data %>%
  group_by(STATE) %>%
  summarise(Median = quantile(EG_RE_TOTAL, 0.5), Observations = n())

# setting limits for my plot

y_axis_limits <- seq(800, 11800, by = 900)
y_axis_intervals <- seq(800, 11800, by = 900)

state.Data %>%
  left_join(median_data, by = c("STATE" = "STATE")) %>% # to join data set with median values
  mutate(myaxis = paste0(STATE, "\n", "n=", Observations)) %>%
  ggplot(aes(x = myaxis, y = EG_RE_TOTAL, fill = STATE)) + # plot parameters
  geom_violin(position = position_dodge(width = 0.5), width = 0.8) +
  geom_point(aes(x = myaxis, y = Median, color = STATE, size = 3)) +
  geom_text(aes(x = myaxis, y = Median, label = round(Median, 1)), vjust = -1.2, size = 3, color = "white", hjust = 0.5) +
  scale_fill_viridis(discrete = TRUE) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 20),
  ) +
  ggtitle("VIOLIN PLOT WITH MEDIAN RENEWABLE GENERATION BY STATE") +
  xlab("STATE") +
  ylab("RENEWABLE GENERATION (000 MWH)") +
  scale_y_continuous(breaks = y_axis_intervals, limits = c(min(y_axis_limits), max(y_axis_limits)))+
  theme(
    axis.title.x = element_text(hjust = 0.5),  # Center x-axis label
    axis.title.y = element_text(hjust = 0.5, vjust = 0.5),# Center y-axis label
    plot.title = element_text(hjust = 0.5)
  )


#******checking Data distribution through Box Plot******


par(mfrow = c(1, 2))

b1 <- boxplot(energy_data$EC_TOTAL~energy_data$STATE, horizontal = F, 
              xlab='STATE', ylab='THOUSAND MWH ',main='BOXPLOT: DISTRIBUTION FOR THE TOTAL ENERGY CONSUMPTION BY STATE', 
              cex.axis = 0.8, cex.lab = 0.8 ,col = "grey" , cex.main = 0.8)

b2 <-boxplot(energy_data$EG_RE_TOTAL~energy_data$STATE, horizontal = F, 
             xlab='STATE', ylab='THOUSAND MWH ',main='BOXPLOT: DISTRIBUTION FOR THE TOTAL RENEWABLE ENERGY GENERATION BY STATE', 
             cex.axis = 0.8, cex.lab = 0.8 ,col = "grey" , cex.main = 0.8)




#*******Comparing Median Energy Consumption by Each state*****


allstate_median <- energy_data %>%
  group_by(STATE) %>%
  summarise(Median = quantile(EC_TOTAL, 0.5))
# i will arrange them to be used in plot
arranged_allstate_median <- allstate_median %>%
  arrange(Median)

#plotting lolipop plot with arranged sorted data in ascending order

ggplot(arranged_allstate_median, aes(x = 0, y = reorder(STATE, Median))) +
  geom_segment(aes(xend = Median, yend = reorder(STATE, Median)), color = "maroon4", size = 1.2) +
  geom_point(aes(x = Median), position = position_nudge(x = 0.05), color = "red3", size = 3) +
  geom_text(aes(x = Median, label = round(Median, 1)), vjust = -1.5, hjust = 0.6, size = 3) +
  labs(
    x = "MEDIAN Energy CONSUMPTION (000 MWH)",
    y = "STATE",
    title = "HORIZONTAL LOLLIPOP PLOT OF MEDIAN ENERGY CONSUMPTION BY STATE "
  ) +
  theme_minimal() +
  theme(
    axis.text.y = element_text(hjust = 1),
    plot.title = element_text(size = 14, hjust = 0.5)
  )

#*****Comparing Median Renewable Energy Generation by Each state*****

allstate_median <- energy_data %>%
  group_by(STATE) %>%
  summarise(Median = quantile(EG_RE_TOTAL, 0.5))
# i will arrange them to be used in plot
arranged_allstate_median <- allstate_median %>%
  arrange(Median)

#plotting lolipop plot with arranged sorted data in ascending order

ggplot(arranged_allstate_median, aes(x = 0, y = reorder(STATE, Median))) +
  geom_segment(aes(xend = Median, yend = reorder(STATE, Median)), color = "maroon4", size = 1.2) +
  geom_point(aes(x = Median), position = position_nudge(x = 0.05), color = "red3", size = 3) +
  geom_text(aes(x = Median, label = round(Median, 1)), vjust = -1.5, hjust = 0.6, size = 3) +
  labs(
    x = "MEDIAN RENEWABLE ENERGY GENERATION (000 MWH)",
    y = "STATE",
    title = "HORIZONTAL LOLLIPOP PLOT OF TOTAL RENEWABLE ENERGY GENERATION BY STATE "
  ) +
  theme_minimal() +
  theme(
    axis.text.y = element_text(hjust = 1),
    plot.title = element_text(size = 14, hjust = 0.5)
  )


#*****Choloropeth map for the Energy Consumption*******


NJ=energy_data[which(energy_data$STATE=='NJ'),c(1:21)]
NY=energy_data[which(energy_data$STATE=='NY'),c(1:21)]
PA=energy_data[which(energy_data$STATE=='PA'),c(1:21)]


#energy consumption 2022

# Extracting values for each state

NJ_EC_2022 <- NJ[which(NJ$YEAR=='2022'),c(1:9)]
NY_EC_2022 <- NY[which(NY$YEAR=='2022'),c(1:9)]
PA_EC_2022 <- PA[which(PA$YEAR=='2022'),c(1:9)]
NJ_EC_2022$fips=34
NY_EC_2022$fips=36
PA_EC_2022$fips=42

states_EC_2022 <- rbind(NJ_EC_2022, NY_EC_2022, PA_EC_2022)


states_EC_2022_plot <- plot_usmap(include = .mid_atlantic ,data = states_EC_2022, values = "EC_TOTAL", labels = TRUE) +
  scale_fill_continuous(
    name = "THOUSAND MWH",
    label = scales::comma,
    type = "gradient",
    low = "lightyellow", 
    high = "lightyellow4"# 
  ) +
  theme(legend.position = c(0.8, 0.5),  #
        legend.text = element_text(size = 10),  
        legend.title = element_text(size = 10),  
        plot.title = element_text(size = 15))+
  ggtitle("ENERGY CONSUMPTION 2022")

states_EC_2022_plot


NJ_EC_2001 <- NJ[which(NJ$YEAR=='2001'),c(1:9)]
NY_EC_2001 <- NY[which(NY$YEAR=='2001'),c(1:9)]
PA_EC_2001 <- PA[which(PA$YEAR=='2001'),c(1:9)]
NJ_EC_2001$fips=34
NY_EC_2001$fips=36
PA_EC_2001$fips=42

states_EC_2001 <- rbind(NJ_EC_2001, NY_EC_2001, PA_EC_2001)


states_EC_2001_plot <- plot_usmap(include = .mid_atlantic ,data = states_EC_2001, values = "EC_TOTAL", labels = TRUE) +
  scale_fill_continuous(
    name = "Thousand MWH",
    label = scales::comma,
    type = "gradient",
    low = "lightyellow", 
    high = "lightyellow4"
  ) +
  theme(legend.position = c(0.8, 0.5),  
        legend.text = element_text(size = 10),  
        legend.title = element_text(size = 10),  
        plot.title = element_text(size = 15))+
  ggtitle("ENERGY CONSUMPTION 2001")

states_EC_2001_plot


states_EC_2001_plot +  states_EC_2022_plot



#******Choloropeth map for the Renewable Energy Gen*****

states_EG_RE_2001_plot <- plot_usmap(include = .mid_atlantic ,data = states_EC_2001, values = "EG_RE_TOTAL", labels = TRUE) +
  scale_fill_continuous(
    name = "THOUSAND MWH",
    label = scales::comma,
    type = "gradient",
    low = "yellowgreen", 
    high = "seagreen4"
  ) +
  theme(legend.position = c(0.8, 0.5),  
        legend.text = element_text(size = 10),  
        legend.title = element_text(size = 10),  
        plot.title = element_text(size = 15))+
  ggtitle("RENEWABLE ENERGY GENERATION 2001")

states_EG_RE_2001_plot


states_EG_RE_2022_plot <- plot_usmap(include = .mid_atlantic ,data = states_EC_2022, values = "EG_RE_TOTAL", labels = TRUE) +
  scale_fill_continuous(
    name = "THOUSAND MWH",
    label = scales::comma,
    type = "gradient",
    low = "yellowgreen", 
    high = "seagreen4"
  ) +
  theme(legend.position = c(0.8, 0.5),  
        legend.text = element_text(size = 10),  
        legend.title = element_text(size = 10),  
        plot.title = element_text(size = 15))+
  ggtitle("RENEWABLE ENERGY GENERATION 2001")

states_EG_RE_2022_plot

states_EG_RE_2001_plot + states_EG_RE_2022_plot


#*****Energy Consumption Change over years*****

par(mfrow = c(1, 2))
states_EC <- rbind(states_EC_2001, states_EC_2022)

lower_year_color <- "blue"
final_year_color <- "lightyellow4"


ce<-ggplot(states_EC, aes(x = STATE, y = EC_TOTAL, fill = factor(YEAR))) +
  geom_bar(stat = "identity", position = "identity", alpha = 0.7) +
  scale_fill_manual(values = c(lower_year_color, final_year_color)) +
  labs(title = "ENERGY CONSUMPTION CHANGE OVER YEARS", x = "State", y = "THOUSAND MWH") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 18),
        axis.text.y = element_text(size = 18),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        plot.title = element_text(size = 16),
        legend.text = element_text(size = 18),  
        legend.title = element_text(size = 16)) +  
  guides(fill = guide_legend(title = "YEAR", title.position = "top")) 





#*******Renewable Energy Generation  Change over years*****
states_EC <- rbind(states_EC_2001, states_EC_2022)

lower_year_color <- "blue"
final_year_color <- "lightyellow4"


GE<- ggplot(states_EC, aes(x = STATE, y = EG_RE_TOTAL, fill = factor(YEAR))) +
  geom_bar(stat = "identity", position = "identity", alpha = 0.7) +
  scale_fill_manual(values = c(lower_year_color, final_year_color)) +
  labs(title = "RENEWABLE ENERGY GENERATION CHANGE OVER YEARS", x = "State", y = "Thousand MWH") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 18),
        axis.text.y = element_text(size = 18),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        plot.title = element_text(size = 16),
        legend.text = element_text(size = 18),  # Adjust legend text size
        legend.title = element_text(size = 16)) +  # Adjust legend title size
  guides(fill = guide_legend(title = "Year", title.position = "top"))


ce + GE



#*****Line animation plot ******

p <- ggplot(
  energy_data,
  aes( YEAR, EC_TOTAL, group = STATE, color = factor(STATE))
) +
  geom_line() +
  scale_color_viridis_d() +
  labs(x = "YEAR", y = "TOTAL ENERGY CONSUMPTION (000 MWH)") +
  theme(legend.position = "top",
        panel.background = element_rect(fill = "grey99")
        
        
  )
p

E_con<-p + geom_point(aes(group = seq_along(YEAR))) +transition_reveal(YEAR)


R <- ggplot(
  energy_data,
  aes( YEAR, EG_RE_TOTAL, group = STATE, color = factor(STATE))
) +
  geom_line() +
  scale_color_viridis_d() +
  labs(x = "YEAR", y = "TOTAL RENEWABLE ENERGY GENERATION (000 MWH)") +
  theme(legend.position = "top" ,
        panel.background = element_rect(fill = "grey99")
  )
R

E_Gen <-R + geom_point(aes(group = seq_along(YEAR))) +transition_reveal(YEAR)

C <- ggplot(
  energy_data,
  aes( YEAR, COAL_CONS, group = STATE, color = factor(STATE))
) +
  geom_line() +
  scale_color_viridis_d() +
  labs(x = "YEAR", y = "TOTAL COAL CONSUMPTION (000 MWH)") +
  theme(legend.position = "top",
        panel.background = element_rect(fill = "grey99")
        
  
  )
C

CC <-C + geom_point(aes(group = seq_along(YEAR))) +transition_reveal(YEAR)


#*****Comparison of Relationship between Energy Consumption and Renewable Energy ******

par(mfrow = c(1, 1))

# Pennsylvania

plot(energy_data$EG_RE_TOTAL[energy_data$STATE=='PA'],
     energy_data$EC_TOTAL[energy_data$STATE=='PA'],
     pch=20, 
     cex=2, 
     col="green4",
     xlab='TOTAL GENERATION RENEWABLES (000 MWH)',
     ylab='TOTAL ENERGY CONSUMPTION (000 MWH)', 
     bty='o',
     main="PENNSYLVANIA"
)


# New York

plot(energy_data$EG_RE_TOTAL[energy_data$STATE=='NY'],
     energy_data$EC_TOTAL[energy_data$STATE=='NY'],
     pch=20, 
     cex=2, 
     col="seagreen",
     xlab='TOTAL GENERATION RENEWABLES (000 MWH)',
     ylab='TOTAL ENERGY CONSUMPTION (000 MWH)',  
     bty='o',
     main="NEW YORK"
)

# New Jersey

plot(energy_data$EG_RE_TOTAL[energy_data$STATE=='NJ'],
     energy_data$EC_TOTAL[energy_data$STATE=='NJ'],
     pch=20, 
     cex=2, 
     col="olivedrab",
     xlab='TOTAL GENERATION RENEWABLES (000 MWH)',
     ylab='TOTAL ENERGY CONSUMPTION (000 MWH)', 
     bty='o',
     main="NEW JERSEY"
)


#********Comparison of all variables ******


# Pennsylvania

comp_PA=energy_data[which(energy_data$STATE=='PA'),c(3,6,9,14,23,24,25)]

head(comp_PA)

# correlogram plot between variables 

ggpairs(comp_PA, title="Correlogram For Pensylvania")

correlation_matrix_PA <- cor(comp_PA)

corrplot(correlation_matrix_PA, method = "color", type = "upper", 
         addCoef.col = "black", tl.col = "black", tl.srt = 45)



# New York

comp_NY=energy_data[which(energy_data$STATE=='NY'),c(3,6,9,14,23,24,25)]

head(comp_NY)

# correlogram plot between variables 

ggpairs(comp_NY, title="CORRELOGRAM FOR NEW YORK")


correlation_matrix_NY <- cor(comp_NY)

corrplot(correlation_matrix_NY, method = "color", type = "upper", 
         addCoef.col = "black", tl.col = "black", tl.srt = 45)



# New Jersey
comp_NJ=energy_data[which(energy_data$STATE=='NJ'),c(3,6,9,14,23,24,25)]

head(comp_NJ)

# correlogram plot between variables 

ggpairs(comp_NJ, title="CORRELOGRAM FOR NEW JERSEY")

correlation_matrix_NJ <- cor(comp_NJ)

corrplot(correlation_matrix_NJ, method = "color", type = "upper", 
         addCoef.col = "black", tl.col = "black", tl.srt = 45)



#*********parallel coordinate plot*****

states_to_compare=c('PA','NJ','NY')

Data=data.frame()


# iterating through for loop to make out database 


for(I in 1:length(states_to_compare))
{
  data=energy_data[which(energy_data$STATE==states_to_compare[I]),c(1,3,6,9,24,25)]
  Data=rbind(Data,data)
}

Data



my_color_palette <- c("darkblue", "green4", "coral4")


# plotting parallel plot 


p <- ggparcoord(Data,columns = 2:6, groupColumn = 'STATE', scale='std', showPoints=T, title='PARALLEL COORDINATES PLOT WITH SCALED COMPARISON FOR DESIRED VARIABLES', aes(color = Entity.Name))


#using custom colors palette
p + scale_color_manual(values = my_color_palette)


#******************Comparing Energy Consumptions trend of Each state over Years using radar*****************************

nj_radar=energy_data[which(energy_data$STATE=='NJ'),c(1,2,6,9)]

pa_radar=energy_data[which(energy_data$STATE=='PA'),c(1,2,6,9)]

ny_radar=energy_data[which(energy_data$STATE=='NY'),c(1,2,6,9)]


nj.EC = nj_radar[,3]
pa.EC = pa_radar[,3]
ny.EC = ny_radar[,3]

#Make a dataframe
ec.radar=data.frame(rbind(nj.EC,pa.EC,ny.EC))

colnames(ec.radar)=c('2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020','2021','2022')


Max=rep(max(ec.radar),22)
Min=rep(min(ec.radar),22)

ec.radar=rbind(Max,Min,ec.radar)
rownames(ec.radar)=c('Max','Min','NJ','PA','NY')

library(fmsb)
colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )


# plot with default options:
radarchart(ec.radar, axistype=1 , 
           #custom polygon
           pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
           #custom the grid
           cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
           #custom labels
           vlcex=0.8 
)

# Add a legend
legend(x=1.3,y=0.9,legend = rownames(ec.radar[-c(1,2),]), bty = "n", horiz =F, pch=20 , col=colors_in , text.col =1, cex=1.2, pt.cex=3)

title(main = "Energy Consumption Comparison (NJ, PA, NY)", cex.main = 1.5)



#******Comparing Renewable Energy Generation trend of Each state over Years using radar*****


nj_radar=energy_data[which(energy_data$STATE=='NJ'),c(1,2,6,9)]

pa_radar=energy_data[which(energy_data$STATE=='PA'),c(1,2,6,9)]

ny_radar=energy_data[which(energy_data$STATE=='NY'),c(1,2,6,9)]


nj.re = nj_radar[,4]
pa.re = pa_radar[,4]
ny.re = ny_radar[,4]

#Make a dataframe
re.radar=data.frame(rbind(nj.re,pa.re,ny.re))

colnames(re.radar)=c('2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020','2021','2022')


Max=rep(max(re.radar),22)
Min=rep(min(re.radar),22)

re.radar=rbind(Max,Min,re.radar)
rownames(re.radar)=c('Max','Min','NJ','PA','NY')

library(fmsb)
colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )


# plot with default options:
radarchart(re.radar, axistype=1 , 
           #custom polygon
           pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
           #custom the grid
           cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
           #custom labels
           vlcex=0.8 
)

# Add a legend
legend(x=1.3,y=0.9,legend = rownames(re.radar[-c(1,2),]), bty = "n", horiz =F, pch=20 , col=colors_in , text.col =1, cex=1.2, pt.cex=3)

title(main = "Renewable Energy Generation Comparison (NJ, PA, NY)", cex.main = 1.5)


#********Heatmap Comparison *******

statesvar2022=energy_data[which(energy_data$YEAR=="2022"),c(1,3,6,9,14,23,24,25)]
statesvar_2022=statesvar2022[,-1] 
rownames(statesvar_2022)=statesvar2022[,1]
colnames(statesvar_2022)=c('COAL Consumption','Energy Consumption','Renewable Energy','Tariff', 'Income', 'Population', 'GDP')
statesvar_2022
install.packages('heatmaply')
library(heatmaply)
install.packages("RColorBrewer")
library("RColorBrewer")
col <- colorRampPalette(brewer.pal(80, "RdYlBu"))(80)
Heatmap<- heatmaply(statesvar_2022, colors =col,
                    dendrogram = "none",
                    xlab = "Variables", 
                    ylab = "STATE", 
                    main = "VARIABLES COMPARISON YEAR 2022",
                    scale = "column",
                    grid_color = "white",
                    grid_width = 0.00001,
                    titleX = TRUE,
                    hide_colorbar = FALSE,
                    branches_lwd = 0.1,
                    fontsize_row = 10, fontsize_col = 10,
                    labCol = colnames(statesvar_2022),
                    labRow = rownames(statesvar_2022),
                    heatmap_layers = theme(axis.line=element_blank()),
                    annotation_legend = TRUE,
                    showlegend = TRUE
)
Heatmap

std_energy_ratio <- numeric(nrow(energy_data))

for ( i in 1:nrow(energy_data)){
  std_energy_ratio[i]<-energy_data$EC_TOTAL[i]/energy_data$EG_RE_TOTAL[i]
}

energy_data$std_energy_ratio<-std_energy_ratio

# Assuming 'energy_data' is your dataset
subset_data <- energy_data[, c("YEAR", "std_energy_ratio")]

transposed_data <- t(subset_data )
rownames(subset_data)=energy_data[,1]


#*********dual Y *******

# Plotting the data with dual Y-axes

dual_NY<-ggplot(NY, aes(x=YEAR)) +
  geom_bar( aes(y=EC_TOTAL), stat="identity", size=.1, fill='maroon', color="black", alpha=.8) + 
  geom_line( aes(y=EG_RE_TOTAL*100), linewidth=2, color='midnightblue') +
  scale_y_continuous(
    # Features of the first axis
    name = "TOTAL ENERGY CONSUMPTION (IN '00S MW)",
    # Add a second axis and specify its features
    sec.axis = sec_axis(~.*0.01, name="TOTAL RENEW. ENERGY GENERATION (IN MW)")
  ) + 
  theme_ipsum() +
  theme(
    axis.title.y = element_text(color = 'maroon', size=10),
    axis.title.y.right = element_text(color = 'midnightblue', size=10),
    plot.title = element_text(size = 10, hjust = 0.5),
    plot.title.position = "plot"
  ) +
  ggtitle("ENERGY CONSUMPTION VS RENEWABLE ENERGY GENERATION IN NEW YORK")
dual_NY



dual_NJ<-ggplot(NJ, aes(x=YEAR)) +
  geom_bar( aes(y=EC_TOTAL), stat="identity", size=.1, fill='maroon', color="black", alpha=.8) + 
  geom_line( aes(y=EG_RE_TOTAL*100), linewidth=2, color='midnightblue') +
  scale_y_continuous(
    # Features of the first axis
    name = "TOTAL ENERGY CONSUMPTION (IN '00S MW)",
    # Add a second axis and specify its features
    sec.axis = sec_axis(~.*0.01, name="TOTAL RENEW. ENERGY GENERATION (IN MW)")
  ) + 
  theme_ipsum() +
  theme(
    axis.title.y = element_text(color = 'maroon', size=10),
    axis.title.y.right = element_text(color = 'midnightblue', size=10),
    plot.title = element_text(size = 10, hjust = 0.5),
    plot.title.position = "plot"
  ) +
  ggtitle("ENERGY CONSUMPTION VS RENEWABLE ENERGY GENERATION IN NEW JERSEY")
dual_NJ



dual_PA<-ggplot(PA, aes(x=YEAR)) +
  geom_bar( aes(y=EC_TOTAL), stat="identity", size=.1, fill='maroon', color="black", alpha=.8) + 
  geom_line( aes(y=EG_RE_TOTAL*100), linewidth=2, color='midnightblue') +
  scale_y_continuous(
    # Features of the first axis
    name = "Total Energy Consumption (in '000s MW)",
    # Add a second axis and specify its features
    sec.axis = sec_axis(~.*0.01, name="TOTAL RENEW. ENERGY GENERATION (IN '000S MW)")
  ) + 
  theme_ipsum() +
  theme(
    axis.title.y = element_text(color = 'maroon', size=10),
    axis.title.y.right = element_text(color = 'midnightblue', size=10),
    plot.title = element_text(size = 10, hjust = 0.5),
    plot.title.position = "plot"
  ) +
  ggtitle("ENERGY CONSUMPTION VS RENEWABLE ENERGY GENERATION IN PENNSYLVANIA")
dual_PA

dual_NY + dual_NJ + dual_PA

#*******dual Y-COAL ********

# Plotting the data with dual Y-axes

dual_NY_C<-ggplot(NY, aes(x=YEAR)) +
  geom_bar( aes(y=COAL_CONS), stat="identity", size=.1, fill='maroon', color="black", alpha=.8) + 
  geom_line( aes(y=EG_RE_TOTAL), linewidth=2, color='midnightblue') +
  scale_y_continuous(
    # Features of the first axis
    name = "TOTAL COAL CONSUMPTION (IN '00S MW)",
    # Add a second axis and specify its features
    sec.axis = sec_axis(~.*1, name="TOTAL RENEW. ENERGY GENERATION (IN MW)")
  ) + 
  theme_ipsum() +
  theme(
    axis.title.y = element_text(color = 'maroon', size=10),
    axis.title.y.right = element_text(color = 'midnightblue', size=10),
    plot.title = element_text(size = 10, hjust = 0.5),
    plot.title.position = "plot"
  ) +
  ggtitle("COAL CONSUMPTION VS RENEWABLE ENERGY GENERATION IN NEW YORK")
dual_NY_C



dual_NJ_C<-ggplot(NJ, aes(x=YEAR)) +
  geom_bar( aes(y=COAL_CONS), stat="identity", size=.1, fill='maroon', color="black", alpha=.8) + 
  geom_line( aes(y=EG_RE_TOTAL), linewidth=2, color='midnightblue') +
  scale_y_continuous(
    # Features of the first axis
    name = "TOTAL COAL CONSUMPTION (IN '00S MW)",
    # Add a second axis and specify its features
    sec.axis = sec_axis(~.*1, name="TOTAL RENEW. ENERGY GENERATION (IN MW)")
  ) + 
  theme_ipsum() +
  theme(
    axis.title.y = element_text(color = 'maroon', size=10),
    axis.title.y.right = element_text(color = 'midnightblue', size=10),
    plot.title = element_text(size = 10, hjust = 0.5),
    plot.title.position = "plot"
  ) +
  ggtitle("COAL CONSUMPTION VS RENEWABLE ENERGY GENERATION IN NEW JERSEY")
dual_NJ_C



dual_PA_C<-ggplot(PA, aes(x=YEAR)) +
  geom_bar( aes(y=COAL_CONS), stat="identity", size=.1, fill='maroon', color="black", alpha=.8) + 
  geom_line( aes(y=EG_RE_TOTAL), linewidth=2, color='midnightblue') +
  scale_y_continuous(
    # Features of the first axis
    name = "Total COAL Consumption (in '000s MW)",
    # Add a second axis and specify its features
    sec.axis = sec_axis(~.*1, name="TOTAL RENEW. ENERGY GENERATION (IN '000S MW)")
  ) + 
  theme_ipsum() +
  theme(
    axis.title.y = element_text(color = 'maroon', size=10),
    axis.title.y.right = element_text(color = 'midnightblue', size=10),
    plot.title = element_text(size = 10, hjust = 0.5),
    plot.title.position = "plot"
  ) +
  ggtitle("COAL CONSUMPTION VS RENEWABLE ENERGY GENERATION IN PENNSYLVANIA")
dual_PA_C

dual_NY_C + dual_NJ_C + dual_PA_C


#*********Dot chart ******


par(mfrow = c(1, 1))

energy_data$Region[1:22]='PENNSYLVANIA' 
energy_data$Region[23:44]='NEW YORK'
energy_data$Region[45:66]='NEW JERSEY'
energy_data

region <- as.factor(energy_data$Region)
my_cols <- c(2:5) 
labels_combined <- paste(energy_data$STATE, energy_data$YEAR)
dotchart(
  energy_data$EC_TOTAL,
  labels = labels_combined,
  groups = region,
  gcolor = my_cols,
  color = 1,
  cex = 0.9,
  pch = 2,
  xlab = 'ENERGY CONSUMPTION (000 MWH)',
  main = "TOTAL ENERGY CONSUMPTION FROM 2001 TO 2022"
)



energy_data$Region[1:22]='PENNSYLVANIA' 
energy_data$Region[23:44]='NEW YORK'
energy_data$Region[45:66]='NEW JERSEY'
energy_data


region <- as.factor(energy_data$Region)
my_cols <- c(2:5) 
labels_combined <- paste(energy_data$STATE, energy_data$YEAR)
dotchart(
  energy_data$EG_RE_TOTAL,
  labels = labels_combined,
  groups = region,
  gcolor = my_cols,
  color = 1,
  cex = 0.9,
  pch = 2,
  xlab = 'RENEWABALE ENERGY GENERATION (000 MWH)',
  main = "TOTAL ENERGY CONSUMPTION FROM 2001 TO 2022"
)


region <- as.factor(energy_data$Region)
my_cols <- c(2:5) 
labels_combined <- paste(energy_data$STATE, energy_data$YEAR)
dotchart(
  energy_data$std_energy_ratio,
  labels = labels_combined,
  groups = region,
  gcolor = my_cols,
  color = 1,
  cex = 0.9,
  pch = 2,
  xlab = 'STANDARDIZED ENERGY RATIO (000 MWH)',
  main = "STANDARDIZED ENERGY RATIO (000 MWH) FROM 2001 TO 2022"
)



#*********************************Regression************************

par(mfrow = c(2, 2))

ggplot(data = PA, aes(x = EG_RE_TOTAL, y = EC_TOTAL)) +
  geom_point() +  # Scatterplot of data points
  geom_smooth(method = "lm", se = FALSE, color = "red") +  # Add regression line
  labs(x = "RENEWABLE ENERGY GENERATION(000 MWH)", y = "TOTAL ENERGY CONSUMPTION(000 MWH)", title = "RENEWABLE ENERGY VS ENERGY CONSUMPTION PENNSYLVANIA")


ggplot(data = NY, aes(x = EG_RE_TOTAL, y = EC_TOTAL)) +
  geom_point() +  # Scatterplot of data points
  geom_smooth(method = "lm", se = FALSE, color = "red") +  # Add regression line
  labs(x = "RENEWABLE ENERGY GENERATION(000 MWH)", y = "TOTAL ENERGY CONSUMPTION(000 MWH)", title = "RENEWABLE ENERGY VS ENERGY CONSUMPTION NEW YORK")


ggplot(data = NJ, aes(x = EG_RE_TOTAL, y = EC_TOTAL)) +
  geom_point() +  # Scatterplot of data points
  geom_smooth(method = "lm", se = FALSE, color = "red") +  # Add regression line
  labs(x = "RENEWABLE ENERGY GENERATION(000 MWH)", y = "TOTAL ENERGY CONSUMPTION(000 MWH)", title = "RENEWABLE ENERGY VS ENERGY CONSUMPTION NEW JERSEY")



