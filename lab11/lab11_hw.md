---
title: "Lab 11 Homework"
author: "Ben Ramirez"
date: "2023-02-20"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

**In this homework, you should make use of the aesthetics you have learned. It's OK to be flashy!**

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
```

## Resources
The idea for this assignment came from [Rebecca Barter's](http://www.rebeccabarter.com/blog/2017-11-17-ggplot2_tutorial/) ggplot tutorial so if you get stuck this is a good place to have a look.  

## Gapminder
For this assignment, we are going to use the dataset [gapminder](https://cran.r-project.org/web/packages/gapminder/index.html). Gapminder includes information about economics, population, and life expectancy from countries all over the world. You will need to install it before use. This is the same data that we will use for midterm 2 so this is good practice.

```r
#install.packages("gapminder")
library("gapminder")
```

```
## Warning: package 'gapminder' was built under R version 4.2.2
```

## Questions
The questions below are open-ended and have many possible solutions. Your approach should, where appropriate, include numerical summaries and visuals. Be creative; assume you are building an analysis that you would ultimately present to an audience of stakeholders. Feel free to try out different `geoms` if they more clearly present your results.  

**1. Use the function(s) of your choice to get an idea of the overall structure of the data frame, including its dimensions, column names, variable classes, etc. As part of this, determine how NA's are treated in the data.**  

```r
glimpse(gapminder)
```

```
## Rows: 1,704
## Columns: 6
## $ country   <fct> "Afghanistan", "Afghanistan", "Afghanistan", "Afghanistan", …
## $ continent <fct> Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, …
## $ year      <int> 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992, 1997, …
## $ lifeExp   <dbl> 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.854, 40.8…
## $ pop       <int> 8425333, 9240934, 10267083, 11537966, 13079460, 14880372, 12…
## $ gdpPercap <dbl> 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 786.1134, …
```

```r
any_na(gapminder)
```

```
## [1] FALSE
```

```r
summary(gapminder)
```

```
##         country        continent        year         lifeExp     
##  Afghanistan:  12   Africa  :624   Min.   :1952   Min.   :23.60  
##  Albania    :  12   Americas:300   1st Qu.:1966   1st Qu.:48.20  
##  Algeria    :  12   Asia    :396   Median :1980   Median :60.71  
##  Angola     :  12   Europe  :360   Mean   :1980   Mean   :59.47  
##  Argentina  :  12   Oceania : 24   3rd Qu.:1993   3rd Qu.:70.85  
##  Australia  :  12                  Max.   :2007   Max.   :82.60  
##  (Other)    :1632                                                
##       pop              gdpPercap       
##  Min.   :6.001e+04   Min.   :   241.2  
##  1st Qu.:2.794e+06   1st Qu.:  1202.1  
##  Median :7.024e+06   Median :  3531.8  
##  Mean   :2.960e+07   Mean   :  7215.3  
##  3rd Qu.:1.959e+07   3rd Qu.:  9325.5  
##  Max.   :1.319e+09   Max.   :113523.1  
## 
```

**2. Among the interesting variables in gapminder is life expectancy. How has global life expectancy changed between 1952 and 2007?**

```r
gapminder %>% 
  ggplot(aes(x=as.factor(year), y=lifeExp, fill=continent))+geom_col()+labs(title="Global Life Expectancy from 1952-2007", x= "Year")+theme(plot.title = (element_text(hjust = 0.5)))
```

![](lab11_hw_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

**3. How do the distributions of life expectancy compare for the years 1952 and 2007?**

```r
gapminder %>% 
  filter(year == 1952 | year == 2007) %>% 
  ggplot(aes(x=year, y=lifeExp, fill=continent))+geom_col(position="dodge")+labs(title = "Distribution of Life Expectancy for 1952 and 2007 by Continent")
```

![](lab11_hw_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

**4. Your answer above doesn't tell the whole story since life expectancy varies by region. Make a summary that shows the min, mean, and max life expectancy by continent for all years represented in the data.**

```r
gapminder %>% 
  ggplot(aes( y= lifeExp,fill=continent, group =continent))+geom_boxplot()+labs(title= "Life Expectancy Distribution by Continent", y= "Life Expectancy")+ theme(plot.title=(element_text(hjust=0.5)))
```

![](lab11_hw_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

**5. How has life expectancy changed between 1952-2007 for each continent?**

```r
gapminder %>% 

  ggplot(aes(x=as.factor(year), y=lifeExp, fill=continent))+geom_col()+labs(title="Life Expectancy from 1952-2007 by Continent", x= "Year", y= "Life Expectancy")+theme(plot.title = (element_text(hjust = 0.5)))
```

![](lab11_hw_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

**6. We are interested in the relationship between per capita GDP and life expectancy; i.e. does having more money help you live longer?**

```r
gapminder %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp))+geom_point()+geom_smooth(method=lm, se=F)
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](lab11_hw_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

**7. Which countries have had the largest population growth since 1952?**

```r
gapminder_summed<-gapminder %>% 
  filter(year==1952| year==2007) %>% 
  group_by(country) %>% 
  mutate(max_pop = max(pop)) %>% 
  mutate(min_pop = min(pop)) %>% 
  mutate(range_pop = max_pop - min_pop) %>% 
  arrange(desc(range_pop))
gapminder_summed
```

```
## # A tibble: 284 × 9
## # Groups:   country [142]
##    country       continent  year lifeExp     pop gdpPe…¹ max_pop min_pop range…²
##    <fct>         <fct>     <int>   <dbl>   <int>   <dbl>   <int>   <int>   <int>
##  1 China         Asia       1952    44    5.56e8    400.  1.32e9  5.56e8  7.62e8
##  2 China         Asia       2007    73.0  1.32e9   4959.  1.32e9  5.56e8  7.62e8
##  3 India         Asia       1952    37.4  3.72e8    547.  1.11e9  3.72e8  7.38e8
##  4 India         Asia       2007    64.7  1.11e9   2452.  1.11e9  3.72e8  7.38e8
##  5 United States Americas   1952    68.4  1.58e8  13990.  3.01e8  1.58e8  1.44e8
##  6 United States Americas   2007    78.2  3.01e8  42952.  3.01e8  1.58e8  1.44e8
##  7 Indonesia     Asia       1952    37.5  8.21e7    750.  2.24e8  8.21e7  1.41e8
##  8 Indonesia     Asia       2007    70.6  2.24e8   3541.  2.24e8  8.21e7  1.41e8
##  9 Brazil        Americas   1952    50.9  5.66e7   2109.  1.90e8  5.66e7  1.33e8
## 10 Brazil        Americas   2007    72.4  1.90e8   9066.  1.90e8  5.66e7  1.33e8
## # … with 274 more rows, and abbreviated variable names ¹​gdpPercap, ²​range_pop
```
**8. Use your results from the question above to plot population growth for the top five countries since 1952.**

```r
gapminder_summed %>% 
  filter(country =="China"|country == "India"|country=="United States"|country=="Indonesia"|country=="Brazil") %>% 
  ggplot(aes(x=year,y=pop, color=country))+geom_line()+scale_y_log10()
```

![](lab11_hw_files/figure-html/unnamed-chunk-10-1.png)<!-- -->
**9. How does per-capita GDP growth compare between these same five countries?**

```r
gapminder %>% 
  filter(country =="China"|country == "India"|country=="United States"|country=="Indonesia"|country=="Brazil") %>% 
  ggplot(aes(x=year, y=gdpPercap, color=country))+geom_line()+facet_wrap(~country, ncol=5)+theme(axis.text.x = element_text(angle=60, hjust =0.5))+labs(title= "GDP Comparison for Highest Growth Populations", x= "Year", y = "GDP per Cap")
```

![](lab11_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

**10. Make one plot of your choice that uses faceting!**

```r
gapminder %>% 
  filter(country =="China"|country == "India"|country=="United States"|country=="Indonesia"|country=="Brazil") %>% 
  ggplot(aes(x=pop, y=lifeExp, color=country))+geom_line()+facet_wrap(~country, ncol=5)+theme(axis.text.x = element_text(angle=60, hjust =0.5))+labs(title= "Life Expectancy vs. Population Growth Comparison", x= "Population Size", y = "Life Expectancy")+scale_x_log10()
```

![](lab11_hw_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

```r
## I was curious to see if life expectancy might lower or slow down in countries where population growth was largest as a way of looking for signs of overpopulation.
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
