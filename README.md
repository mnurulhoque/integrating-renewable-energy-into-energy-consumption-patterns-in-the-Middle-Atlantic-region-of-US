# Analytical visualization of integrating renewable energy into energy consumption patterns in the Middle Atlantic region of the US

# Project Overview
This project was conducted as the final project required by the 'Data Visualization' course at E.J. Bloustein School of Planning and Public Policy, Rutgers University. Graphical visualization techniques have been employed to assess the impact of integrating renewable energy into energy consumption patterns in the Middle Atlantic region of the United States, particularly emphasizing New Jersey, New York, and Pennsylvania. Utilizing data spanning from 2001 to 2022, these visualizations offered insights into the evolving relationship between renewable energy adoption and energy consumption trends within this region. 

# Data Set
This [CSV file](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/blob/main/Energy_Dataset_MDA.csv) was used here as the data set.  

# Resources & Tools Used
Core programming language: R version 4.3.1

Development environment: RStudio

Libraries & packages: ggplot2, dplyr, viridis, hrbrthemes, GGally, plm, lmtest, car, patchwork, usmap, sf, raster, tmap, ggspatial, rnaturalearth, ggmap, leaflet, scales, cartography, sp, webshot2, magick, gganimate, corrplot

# Data Cleaning
In the initial data preparation phase, the following data cleaning tasks were performed:
1. Data loading and inspection
2. Handling missing values and formatting 

# Exploratory Data Analysis
First, an exploratory analysis was conducted to observe the distribution, median, and trend of the selected variables. 

## Distribution of total energy consumption and total renewable energy generation data
![Box Plot Distribution for Renewable and Consumption](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/9f1959ff-e12b-4bab-9267-139e25a989cd)

The states' median energy usage varies, as can be seen from the box plot of total energy consumption. Pennsylvanian and New Jerseyan data are skewed to the right. The majority of the data is focused on the lower end of the energy usage spectrum. However, the majority of the data for New York is concentrated on the higher range of total energy usage, and the data are therefore biased. The median generation in this case varies by state as well, according to the box plot of the total amount of renewable energy generated. New Jersey and New York's data exhibit a right-skewed distribution. The majority of the data is focused on the lower end of the spectrum for the overall generation of renewable energy. Data in Pennsylvania are essentially regularly distributed. Finally, there is no outlier data in both distributions.

![Violin plot-distribution of total energy consumption](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/b5cd7c8e-b039-46ea-8a70-ec5e1d759916)

The violin charts demonstrate how the states' overall energy use differs from one another. New Jersey, New York, and Pennsylvania have median energy consumptions of 295098, 574677.50, and 95487 megawatts, respectively. 

![Violin plot-distribution of renew energy generation](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/cca37b56-039f-4f0e-bf03-2c4bdfad573a)

The violin charts demonstrate how the states' overall amounts of renewable energy generation differ from one another. New Jersey, New York, and Pennsylvania had median renewable energy generation of 962.50, 5014, and 4331.50 megawatts, respectively. 

## Growth of total energy consumption and total renewable energy generation over the years
![Parallel coordinates plot](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/6580cb30-d482-4a56-8fc6-180bf0c9f810)

Pennsylvania consumed the most energy overall, followed by New Jersey and New York. In contrast to the other two states, Pennsylvania experiences a larger variation. However, the state of New York generated the most renewable energy overall, followed by New Jersey and Pennsylvania. In this case, Pennsylvania and New York differed more than New Jersey did. In terms of population, Pennsylvania and New Jersey were next in line, with New York having the largest. All three states, however, had the least variation in population. Among all the states, the GDP index had the most deviation. 

<img width="556" alt="Radar plot" src="https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/724c9fab-37a2-4b51-a01c-53b9e8a0e168">

Findings in the parallel coordinate plots are repeated by radar plots, which show that Pennsylvania consumed the most energy overall, followed by New York and New Jersey. The state of New York generated the most renewable energy overall, followed by New Jersey and Pennsylvania.

## Trends of total energy consumption and total renewable energy generation over the years 
![unnamed-chunk-12-1](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/a6ff2b82-67a2-456e-857a-a00e4919305f)

The trend of total energy consumption and renewable energy generation in all three states from 2001 to 2022 is displayed in an animated line plot. Up until 2015, New York was the largest user of energy. Pennsylvania was the state with the lowest energy consumption from 2021 to 2004, but because of its steady increase in energy consumption, it moved up to the second position and ultimately took the top spot after 2015. New Jersey continued to rank second in terms of overall energy usage after 2004. 

![unnamed-chunk-12-2](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/328031cd-d204-4e1e-969d-f272514fb851)

Regarding renewable energy generation, Pennsylvania was the highest producer from 2001 to 2005 followed by New York and New Jersey. From 2006, New York became the highest producer followed by Pennsylvania and New Jersey. Pennsylvania and New York experienced an upward trend throughout the periods.  Though New Jersey was almost stable from 2001 to 2013 in renewables generation, then it increased.

## Choropleth map indicating the outline for the base year and the final year 
![Choropleth map-energy consumption](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/cc5d4a58-8437-4063-bb64-6e62391791c6)

When it came to overall energy consumption in 2001, New York came in first with around 520,000 thousand MW, followed by New Jersey with about 240,000 thousand MW and Pennsylvania with about 200,000 thousand MW. In 2022, Pennsylvania topped the list of states with the highest overall energy consumption (over 1,000,000 thousand MW), followed by New York (just over 600,000 thousand MW) and New Jersey (about 300,000 thousand MW), after 21 years. 

![Choropleth map-renew energy generation](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/e418e583-2c74-4243-aa40-ef5d617bfd82)

New Jersey (about 1000 thousand MW) and Pennsylvania (around 1600 thousand MW) produced the most renewable energy overall. After 21 years, in 2022, New York ranked first in the world for the total generation of renewable energy (just under 12,000 thousand MW), with Pennsylvania and New Jersey coming in second and third, respectively, at around 6,000 thousand MW and 5,500 thousand MW.  

# Data Analysis
## Main Graph
We have used the Correlogram and correlation matrix as our main graph to prove our hypothesis in this study that renewable energy generation does have an impact on the total energy consumption in the selected states. The rationale behind choosing the Correlogram and correlation matrix here because the correlation coefficient helps us to decide the direction as well as the strength of the relationship between the variables. 

## New Jersey
![Correlogram-NJ](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/fb1bfdb5-2a3f-4984-bd94-bf6543cd8c3f)
![Correlation matrix-NJ](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/b10f8bef-43cd-4cf8-ba99-ce5fcb896926)

The variables total energy consumption, renewable energy generation, tariff, income, population, and GDP all showed a significant negative connection with coal consumption. Except for renewable energy generation and GDP, which showed a high positive link, total energy consumption showed a moderately positive correlation with the variables (tariff, income, and population). Apart from tariffs, which had a somewhat favorable association, the production of renewable energy exhibited a substantial positive correlation with income, population, and GDP. There was a significant positive association between all other variables.

## New York
![Correlogram-NY](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/ee3d53dc-b82d-4e28-bdaa-67292fc1089f)
![Correlation matrix-NY](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/6b648f61-25fa-493b-a304-a562968b9009)

Except for tariff (moderately negative), coal use had a high negative connection with all of the variables (total energy consumption, renewable energy generation, income, population, and GDP). Except for income, which exhibited a somewhat positive association, total energy consumption had a high positive correlation with population, GDP, and renewable energy generation. Except for GDP (very positive), tariffs had a somewhat positive connection with population and income. There was a significant positive association between all other variables. Except for tariff (moderately negative), coal use had a high negative connection with all of the variables (total energy consumption, renewable energy generation, income, population, and GDP). Except for income, which exhibited a somewhat positive association, total energy consumption had a high positive correlation with population, GDP, and renewable energy generation. Except for GDP (very positive), tariffs had a somewhat positive connection with population and income. There was a significant positive association between all other variables.

## Pennsylvania
![Correlogram-PA](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/0dbb10c9-9671-4106-be41-7acc678b4e8b)
![Correlation matrix-PA](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/d70a32a2-6df3-4c34-abc5-d52c02454cfe)

The variables total energy consumption, renewable energy generation, tariff, income, population, and GDP all showed a significant negative connection with coal consumption. There was a strong positive association between any other variable and the others. 

## Alternate Graph
We have used Scatter Plot, Dual Y-axis Plot, and Dot Chart as our alternate graphs to support our findings in the main graph. The rationale behind choosing these graphs as alternate as these provided us the further information on the relationship between the variables we selected here.  

![Scatter Plot for impact analysis](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/5f956d76-9ca0-4c25-b926-540ec911d969)

Pennsylvania demonstrates a substantial positive correlation between total energy generation and total energy consumption. However, there is no obvious tie between New Jersey and New York. 

![Dual Y-axix plot](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/02f8e424-39c4-4772-b2a7-675273cd7ab2)

The dual y-axis graphic for New York demonstrates that while overall energy consumption fluctuated over time, the amount of renewable energy generated increased significantly. Over time, New Jersey's overall energy use fluctuated as well. However, until 2015, the overall generation of renewable energy was essentially constant; following that, there was a notable increase. During that time, Pennsylvania's overall energy usage increased steadily. Nonetheless, there was a dip in the overall production of renewable energy from 2015 to 2022 after years of steady increase from 2001 to 2014. 

![Dot plot](https://github.com/mnurulhoque/integrating-renewable-energy-on-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-the-US/assets/152673435/b74727a6-8c3f-4b43-b63b-0a9e02ab0bae)

The standardized energy ratio for each of the three states from 2001 to 2022 is displayed on a dot plot. The Pennsylvania data was centered in the range of 90–170 thousand MW. The spread ranges for the data for New Jersey and New York, however, were larger, ranging from 50 to 350 thousand MW. 

# Conclusions
The conclusions drawn from the visualizations in this research highlight a noticeable correlation between the growth of renewable energy generation and the overall energy consumption within the studied context. The observed strong positive relationship indicates that as renewable energy integration increases, there's a concurrent rise in overall energy consumption. However, it's crucial to acknowledge the complexity of energy consumption as it's influenced by numerous interconnected variables beyond just renewable energy integration. Therefore, asserting that energy consumption solely increases due to the integration of renewable sources becomes challenging given this multifaceted nature which requires further research. 

# Policy Implications 
Governments and policymakers can use these insights to strengthen policies promoting renewable energy adoption. They can incentivize and invest in renewable energy projects, offer subsidies for clean energy technologies, and establish renewable energy targets to reduce reliance on coal and other fossil fuels. 

# Project Code File 
[R Code File](https://github.com/mnurulhoque/integrating-renewable-energy-into-energy-consumption-patterns-in-the-Middle-Atlantic-region-of-US/blob/main/Final%20project_code%20file.R)


