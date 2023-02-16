---
title: "Lab 10 Homework"
author: "Please Add Your Name Here"
date: "2023-02-16"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
```

## Desert Ecology
For this assignment, we are going to use a modified data set on [desert ecology](http://esapubs.org/archive/ecol/E090/118/). The data are from: S. K. Morgan Ernest, Thomas J. Valone, and James H. Brown. 2009. Long-term monitoring and experimental manipulation of a Chihuahuan Desert ecosystem near Portal, Arizona, USA. Ecology 90:1708.

```r
deserts <- read_csv(here("lab10", "data", "surveys_complete.csv"))
```

```
## Rows: 34786 Columns: 13
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (6): species_id, sex, genus, species, taxa, plot_type
## dbl (7): record_id, month, day, year, plot_id, hindfoot_length, weight
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

1. Use the function(s) of your choice to get an idea of its structure, including how NA's are treated. Are the data tidy?  

```r
glimpse(deserts)
```

```
## Rows: 34,786
## Columns: 13
## $ record_id       <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,…
## $ month           <dbl> 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, …
## $ day             <dbl> 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16…
## $ year            <dbl> 1977, 1977, 1977, 1977, 1977, 1977, 1977, 1977, 1977, …
## $ plot_id         <dbl> 2, 3, 2, 7, 3, 1, 2, 1, 1, 6, 5, 7, 3, 8, 6, 4, 3, 2, …
## $ species_id      <chr> "NL", "NL", "DM", "DM", "DM", "PF", "PE", "DM", "DM", …
## $ sex             <chr> "M", "M", "F", "M", "M", "M", "F", "M", "F", "F", "F",…
## $ hindfoot_length <dbl> 32, 33, 37, 36, 35, 14, NA, 37, 34, 20, 53, 38, 35, NA…
## $ weight          <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ genus           <chr> "Neotoma", "Neotoma", "Dipodomys", "Dipodomys", "Dipod…
## $ species         <chr> "albigula", "albigula", "merriami", "merriami", "merri…
## $ taxa            <chr> "Rodent", "Rodent", "Rodent", "Rodent", "Rodent", "Rod…
## $ plot_type       <chr> "Control", "Long-term Krat Exclosure", "Control", "Rod…
```

```r
##Data looks tidy.
```

2. How many genera and species are represented in the data? What are the total number of observations? Which species is most/ least frequently sampled in the study?

```r
deserts %>% 
  summarise(
    n_total=n(),
    n_genera=n_distinct(genus),
    n_species=n_distinct(species))
```

```
## # A tibble: 1 × 3
##   n_total n_genera n_species
##     <int>    <int>     <int>
## 1   34786       26        40
```

```r
deserts %>% 
  tabyl(species)
```

```
##          species     n      percent
##         albigula  1252 3.599149e-02
##        audubonii    75 2.156040e-03
##          baileyi  2891 8.310815e-02
##        bilineata   303 8.710401e-03
##  brunneicapillus    50 1.437360e-03
##        chlorurus    39 1.121141e-03
##           clarki     1 2.874720e-05
##         eremicus  1299 3.734261e-02
##           flavus  1597 4.590927e-02
##       fulvescens    75 2.156040e-03
##      fulviventer    43 1.236129e-03
##           fuscus     5 1.437360e-04
##        gramineus     8 2.299776e-04
##          harrisi   437 1.256253e-02
##         hispidus   179 5.145748e-03
##      intermedius     9 2.587248e-04
##      leucogaster  1006 2.891968e-02
##       leucophrys     2 5.749439e-05
##         leucopus    36 1.034899e-03
##      maniculatus   899 2.584373e-02
##        megalotis  2609 7.500144e-02
##      melanocorys    13 3.737136e-04
##         merriami 10596 3.046053e-01
##         montanus     8 2.299776e-04
##     ochrognathus    43 1.236129e-03
##            ordii  3027 8.701777e-02
##     penicillatus  3123 8.977750e-02
##       savannarum     2 5.749439e-05
##       scutalatus     1 2.874720e-05
##              sp.    86 2.472259e-03
##      spectabilis  2504 7.198298e-02
##        spilosoma   248 7.129305e-03
##         squamata    16 4.599552e-04
##          taylori    46 1.322371e-03
##     tereticaudus     1 2.874720e-05
##           tigris     1 2.874720e-05
##         torridus  2249 6.465245e-02
##        undulatus     5 1.437360e-04
##        uniparens     1 2.874720e-05
##          viridis     1 2.874720e-05
```

```r
##merriami shows up most often while 5 species only appear once:scutalatus, tereticaudus, tigris, uniparens, viridis.
```


3. What is the proportion of taxa included in this study? Show a table and plot that reflects this count.

```r
deserts %>% 
  tabyl(taxa)
```

```
##     taxa     n      percent
##     Bird   450 0.0129362387
##   Rabbit    75 0.0021560398
##  Reptile    14 0.0004024608
##   Rodent 34247 0.9845052607
```


```r
deserts %>% 
  ggplot(aes(x=taxa))+geom_bar()+scale_y_log10()+labs(title = "Observations by Taxon in Deserts Data",
       x = "Taxonomic Group",
       y= "# of Individuals, log10 scaled"
       )+theme(plot.title = element_text(size = rel(1.25), hjust = 0.5))
```

![](lab10_hw_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

4. For the taxa included in the study, use the fill option to show the proportion of individuals sampled by `plot_type.`

```r
deserts %>% 
   ggplot(aes(x=taxa,fill=plot_type))+geom_bar(position = "dodge")+scale_y_log10()+labs(title = "Observations by Taxon in Deserts Data",
       x = "Taxonomic Group",
       y = "# of Individuals, log10 scaled",
       fill = "Plot Type")
```

![](lab10_hw_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

5. What is the range of weight for each species included in the study? Remove any observations of weight that are NA so they do not show up in the plot.

```r
deserts %>% 
  filter(weight!="NA") %>% 
  ggplot(aes(x=species_id, y=weight, na.rm = T))+geom_boxplot()+scale_y_log10()+labs(title = "Weight Plot for Desert Animals", x = "Species ID", y = "Plot of Animal Weight Distribution")
```

![](lab10_hw_files/figure-html/unnamed-chunk-8-1.png)<!-- -->


6. Add another layer to your answer from #4 using `geom_point` to get an idea of how many measurements were taken for each species.

```r
deserts %>% 
  filter(weight!="NA") %>% 
  ggplot(aes(x=species_id, y=weight, na.rm = T))+geom_boxplot()+scale_y_log10()+labs(title = "Weight Plot for Desert Animals", x = "Species ID", y = "Plot of Animal Weight Distribution")+geom_point(alpha=0.3, color="tomato", position = "jitter") +
  coord_flip()
```

![](lab10_hw_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

7. [Dipodomys merriami](https://en.wikipedia.org/wiki/Merriam's_kangaroo_rat) is the most frequently sampled animal in the study. How have the number of observations of this species changed over the years included in the study?

```r
deserts %>% 
  filter(species == "merriami") %>% 
  group_by(year) %>% 
  summarise(n_merriami = n()) %>% 
  ggplot(aes(x=as.factor(year), y=n_merriami))+geom_col()+labs(title = "Number of merriami Sampled Annual Distribution",y= "Number of merriami Sampled", x= "Year" ) + theme(axis.text.x = element_text(angle = 60, hjust = 1))
```

![](lab10_hw_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

8. What is the relationship between `weight` and `hindfoot` length? Consider whether or not over plotting is an issue.

```r
deserts %>% 
  ggplot(aes(x=weight, y=hindfoot_length))+geom_point(size=0.9)+geom_smooth(method=lm, se=F)
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

```
## Warning: Removed 4048 rows containing non-finite values (`stat_smooth()`).
```

```
## Warning: Removed 4048 rows containing missing values (`geom_point()`).
```

![](lab10_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

9. Which two species have, on average, the highest weight? Once you have identified them, make a new column that is a ratio of `weight` to `hindfoot_length`. Make a plot that shows the range of this new ratio and fill by sex.

```r
deserts %>% 
  group_by(species) %>% 

  summarise(max_weight = max(weight,na.rm=T))
```

```
## Warning: There were 18 warnings in `summarise()`.
## The first warning was:
## ℹ In argument: `max_weight = max(weight, na.rm = T)`.
## ℹ In group 2: `species = "audubonii"`.
## Caused by warning in `max()`:
## ! no non-missing arguments to max; returning -Inf
## ℹ Run ]8;;ide:run:dplyr::last_dplyr_warnings()dplyr::last_dplyr_warnings()]8;; to see the 17 remaining warnings.
```

```
## # A tibble: 40 × 2
##    species         max_weight
##    <chr>                <dbl>
##  1 albigula               280
##  2 audubonii             -Inf
##  3 baileyi                 55
##  4 bilineata             -Inf
##  5 brunneicapillus       -Inf
##  6 chlorurus             -Inf
##  7 clarki                -Inf
##  8 eremicus                40
##  9 flavus                  25
## 10 fulvescens              20
## # … with 30 more rows
```


```r
deserts %>% 
  filter(species == "albigula"  | species == "spectabilis") %>% 
  filter(weight!="NA" & hindfoot_length!="NA" & sex!="NA") %>% 
  mutate(foot_weight_ratio = weight/hindfoot_length) %>% 
  ggplot(aes(x=species, y=foot_weight_ratio, fill=sex))+geom_boxplot()+labs(title = "Ranges of Weight-Foot Pad Ratio", x="Species", y= "Weight-Foot Pad Ratio", fill = "Sex") + theme(plot.title = element_text(size = rel(1.25), hjust = 0.5))
```

![](lab10_hw_files/figure-html/unnamed-chunk-13-1.png)<!-- -->


10. Make one plot of your choice! Make sure to include at least two of the aesthetics options you have learned.

```r
deserts %>% 
##Can't figure out how to get rid of my NAs rn, will come back to this
  mutate(mean_weight = mean(weight, na.rm=T)) %>% 
  ggplot(aes(x = species_id ,  y=mean_weight, fill=sex))+geom_col(position= "dodge")+scale_y_log10()+theme(axis.text.x = element_text(angle = 80, hjust = 0.75))
```

![](lab10_hw_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
