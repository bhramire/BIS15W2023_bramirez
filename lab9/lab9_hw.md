---
title: "Lab 9 Homework"
author: "Please Add Your Name Here"
date: "2023-02-15"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
```

For this homework, we will take a departure from biological data and use data about California colleges. These data are a subset of the national college scorecard (https://collegescorecard.ed.gov/data/). Load the `ca_college_data.csv` as a new object called `colleges`.

```r
colleges <- read_csv(here("lab9", "data", "ca_college_data.csv")) %>% clean_names()
```

```
## Rows: 341 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (4): INSTNM, CITY, STABBR, ZIP
## dbl (6): ADM_RATE, SAT_AVG, PCIP26, COSTT4_A, C150_4_POOLED, PFTFTUG1_EF
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

The variables are a bit hard to decipher, here is a key:  

INSTNM: Institution name  
CITY: California city  
STABBR: Location state  
ZIP: Zip code  
ADM_RATE: Admission rate  
SAT_AVG: SAT average score  
PCIP26: Percentage of degrees awarded in Biological And Biomedical Sciences  
COSTT4_A: Annual cost of attendance  
C150_4_POOLED: 4-year completion rate  
PFTFTUG1_EF: Percentage of undergraduate students who are first-time, full-time degree/certificate-seeking undergraduate students  

1. Use your preferred function(s) to have a look at the data and get an idea of its structure. Make sure you summarize NA's and determine whether or not the data are tidy. You may also consider dealing with any naming issues.

```r
glimpse(colleges)
```

```
## Rows: 341
## Columns: 10
## $ instnm        <chr> "Grossmont College", "College of the Sequoias", "College…
## $ city          <chr> "El Cajon", "Visalia", "San Mateo", "Ventura", "Oxnard",…
## $ stabbr        <chr> "CA", "CA", "CA", "CA", "CA", "CA", "CA", "CA", "CA", "C…
## $ zip           <chr> "92020-1799", "93277-2214", "94402-3784", "93003-3872", …
## $ adm_rate      <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ sat_avg       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ pcip26        <dbl> 0.0016, 0.0066, 0.0038, 0.0035, 0.0085, 0.0151, 0.0000, …
## $ costt4_a      <dbl> 7956, 8109, 8278, 8407, 8516, 8577, 8580, 9181, 9281, 93…
## $ c150_4_pooled <dbl> NA, NA, NA, NA, NA, NA, 0.2334, NA, NA, NA, NA, 0.1704, …
## $ pftftug1_ef   <dbl> 0.3546, 0.5413, 0.3567, 0.3824, 0.2753, 0.4286, 0.2307, …
```


```r
colleges %>% summarize(number_nas = sum(is.na(colleges)))
```

```
## # A tibble: 1 × 1
##   number_nas
##        <int>
## 1        949
```


```r
colleges %>% 
  pivot_wider( 
               names_from = "city",
              values_from = "adm_rate":"pftftug1_ef" )
```

```
## # A tibble: 341 × 969
##    instnm   stabbr zip   adm_r…¹ adm_r…² adm_r…³ adm_r…⁴ adm_r…⁵ adm_r…⁶ adm_r…⁷
##    <chr>    <chr>  <chr>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
##  1 Grossmo… CA     9202…      NA      NA      NA      NA      NA      NA      NA
##  2 College… CA     9327…      NA      NA      NA      NA      NA      NA      NA
##  3 College… CA     9440…      NA      NA      NA      NA      NA      NA      NA
##  4 Ventura… CA     9300…      NA      NA      NA      NA      NA      NA      NA
##  5 Oxnard … CA     9303…      NA      NA      NA      NA      NA      NA      NA
##  6 Moorpar… CA     9302…      NA      NA      NA      NA      NA      NA      NA
##  7 Skyline… CA     9406…      NA      NA      NA      NA      NA      NA      NA
##  8 Glendal… CA     9120…      NA      NA      NA      NA      NA      NA      NA
##  9 Citrus … CA     9174…      NA      NA      NA      NA      NA      NA      NA
## 10 Fresno … CA     93741      NA      NA      NA      NA      NA      NA      NA
## # … with 331 more rows, 959 more variables: adm_rate_Glendale <dbl>,
## #   adm_rate_Glendora <dbl>, adm_rate_Fresno <dbl>,
## #   `adm_rate_Redwood City` <dbl>, adm_rate_Bakersfield <dbl>,
## #   `adm_rate_Los Altos Hills` <dbl>, adm_rate_Reedley <dbl>,
## #   adm_rate_Porterville <dbl>, adm_rate_Walnut <dbl>,
## #   `adm_rate_Santa Maria` <dbl>, adm_rate_Lancaster <dbl>,
## #   `adm_rate_San Marcos` <dbl>, `adm_rate_San Francisco` <dbl>, …
```

2. Which cities in California have the highest number of colleges?

```r
colleges %>% 
  count(city) %>% 
  slice_max(n,n=10)
```

```
## # A tibble: 12 × 2
##    city              n
##    <chr>         <int>
##  1 Los Angeles      24
##  2 San Diego        18
##  3 San Francisco    15
##  4 Sacramento       10
##  5 Berkeley          9
##  6 Oakland           9
##  7 Claremont         7
##  8 Pasadena          6
##  9 Fresno            5
## 10 Irvine            5
## 11 Riverside         5
## 12 San Jose          5
```

3. Based on your answer to #2, make a plot that shows the number of colleges in the top 10 cities.

```r
colleges %>% 
  count(city) %>% 
  slice_max(n,n=10) %>% 
  ggplot(aes(x=city, y=n))+geom_col()+coord_flip()
```

![](lab9_hw_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

4. The column `COSTT4_A` is the annual cost of each institution. Which city has the highest average cost? Where is it located?

```r
colleges %>% 
  slice_max(costt4_a,n=10) %>% 
  select(instnm,city,costt4_a)
```

```
## # A tibble: 10 × 3
##    instnm                                        city          costt4_a
##    <chr>                                         <chr>            <dbl>
##  1 Harvey Mudd College                           Claremont        69355
##  2 Southern California Institute of Architecture Los Angeles      67225
##  3 University of Southern California             Los Angeles      67064
##  4 Occidental College                            Los Angeles      67046
##  5 Claremont McKenna College                     Claremont        66325
##  6 Pepperdine University                         Malibu           66152
##  7 Scripps College                               Claremont        66060
##  8 Pitzer College                                Claremont        65880
##  9 San Francisco Art Institute                   San Francisco    65453
## 10 Pomona College                                Claremont        64870
```

```r
#Harvey Mudd College has the highest cost of attendance annually. It's in Claremont, California.
```

5. Based on your answer to #4, make a plot that compares the cost of the individual colleges in the most expensive city. Bonus! Add UC Davis here to see how it compares :>).

```r
colleges %>% 
  filter(city == "Claremont") %>% 
   ggplot(aes(x=instnm, y=costt4_a))+geom_col()+coord_flip()
```

```
## Warning: Removed 2 rows containing missing values (`position_stack()`).
```

![](lab9_hw_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

6. The column `ADM_RATE` is the admissions rate by college and `C150_4_POOLED` is the four-year completion rate. Use a scatterplot to show the relationship between these two variables. What do you think this means?

```r
colleges %>% 
  ggplot(aes(x=adm_rate,y=c150_4_pooled))+geom_point()+geom_smooth(method=lm, se=F)
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

```
## Warning: Removed 251 rows containing non-finite values (`stat_smooth()`).
```

```
## Warning: Removed 251 rows containing missing values (`geom_point()`).
```

![](lab9_hw_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

```r
##The higher admittance rates have lower 4 yr completion rates, meaning higher admittance leads to higher dropout rates. 
```

7. Is there a relationship between cost and four-year completion rate? (You don't need to do the stats, just produce a plot). What do you think this means?

```r
colleges %>% 
  ggplot(aes(x=costt4_a, y=c150_4_pooled))+geom_point()+geom_smooth(method=lm, se=F)
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

```
## Warning: Removed 225 rows containing non-finite values (`stat_smooth()`).
```

```
## Warning: Removed 225 rows containing missing values (`geom_point()`).
```

![](lab9_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

```r
##Students paying higher tuition tend to complete four years more often.
```

8. The column titled `INSTNM` is the institution name. We are only interested in the University of California colleges. Make a new data frame that is restricted to UC institutions. You can remove `Hastings College of Law` and `UC San Francisco` as we are only interested in undergraduate institutions.

```r
univ_calif<-colleges %>% 
 filter(grepl("University of California", instnm)) 
```

Remove `Hastings College of Law` and `UC San Francisco` and store the final data frame as a new object `univ_calif_final`.

```r
univ_calif_final <- univ_calif %>% 
  filter(instnm != "University of California-Hastings College of Law") %>% 
  filter(instnm != "University of California-San Francisco")
univ_calif_final
```

```
## # A tibble: 8 × 10
##   instnm       city  stabbr zip   adm_r…¹ sat_avg pcip26 costt…² c150_…³ pftft…⁴
##   <chr>        <chr> <chr>  <chr>   <dbl>   <dbl>  <dbl>   <dbl>   <dbl>   <dbl>
## 1 University … La J… CA     92093   0.357    1324  0.216   31043   0.872   0.662
## 2 University … Irvi… CA     92697   0.406    1206  0.107   31198   0.876   0.725
## 3 University … Rive… CA     92521   0.663    1078  0.149   31494   0.73    0.811
## 4 University … Los … CA     9009…   0.180    1334  0.155   33078   0.911   0.661
## 5 University … Davis CA     9561…   0.423    1218  0.198   33904   0.850   0.605
## 6 University … Sant… CA     9506…   0.578    1201  0.193   34608   0.776   0.786
## 7 University … Berk… CA     94720   0.169    1422  0.105   34924   0.916   0.709
## 8 University … Sant… CA     93106   0.358    1281  0.108   34998   0.816   0.708
## # … with abbreviated variable names ¹​adm_rate, ²​costt4_a, ³​c150_4_pooled,
## #   ⁴​pftftug1_ef
```

Use `separate()` to separate institution name into two new columns "UNIV" and "CAMPUS".

```r
univ_calif_sep<-univ_calif_final %>% 
separate(instnm, into= c("UNIV", "CAMPUS"), sep = "-")
```

9. The column `ADM_RATE` is the admissions rate by campus. Which UC has the lowest and highest admissions rates? Produce a numerical summary and an appropriate plot.

```r
univ_calif_final %>% 
  summarise(min_ad_rate= min(adm_rate),
            max_ad_rate= max(adm_rate),
            mean_ad_rate=mean(adm_rate),
            median_ad_rate=median(adm_rate))
```

```
## # A tibble: 1 × 4
##   min_ad_rate max_ad_rate mean_ad_rate median_ad_rate
##         <dbl>       <dbl>        <dbl>          <dbl>
## 1       0.169       0.663        0.392          0.382
```


```r
univ_calif_sep %>% 
  ggplot(aes( y=adm_rate))+geom_boxplot()
```

![](lab9_hw_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

10. If you wanted to get a degree in biological or biomedical sciences, which campus confers the majority of these degrees? Produce a numerical summary and an appropriate plot.

```r
univ_calif_sep %>% 
  slice_max(pcip26, n=5)
```

```
## # A tibble: 5 × 11
##   UNIV  CAMPUS city  stabbr zip   adm_r…¹ sat_avg pcip26 costt…² c150_…³ pftft…⁴
##   <chr> <chr>  <chr> <chr>  <chr>   <dbl>   <dbl>  <dbl>   <dbl>   <dbl>   <dbl>
## 1 Univ… San D… La J… CA     92093   0.357    1324  0.216   31043   0.872   0.662
## 2 Univ… Davis  Davis CA     9561…   0.423    1218  0.198   33904   0.850   0.605
## 3 Univ… Santa… Sant… CA     9506…   0.578    1201  0.193   34608   0.776   0.786
## 4 Univ… Los A… Los … CA     9009…   0.180    1334  0.155   33078   0.911   0.661
## 5 Univ… River… Rive… CA     92521   0.663    1078  0.149   31494   0.73    0.811
## # … with abbreviated variable names ¹​adm_rate, ²​costt4_a, ³​c150_4_pooled,
## #   ⁴​pftftug1_ef
```

```r
##UCSD confers the majority of biological and biomedical science degrees. 
```


```r
univ_calif_sep %>% 
  ggplot(aes(x=CAMPUS, y=pcip26))+geom_col()+coord_flip()
```

![](lab9_hw_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

## Knit Your Output and Post to [GitHub](https://github.com/FRS417-DataScienceBiologists)
