---
title: "Lab 3 Homework"
author: "Benjamin Ramirez"
date: "2023-01-20"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse

```r
library(tidyverse)
```

## Mammals Sleep
1. For this assignment, we are going to use built-in data on mammal sleep patterns. From which publication are these data taken from? Since the data are built-in you can use the help function in R.

```r
msleep
```

```
## # A tibble: 83 × 11
##    name         genus vore  order conse…¹ sleep…² sleep…³ sleep…⁴ awake  brainwt
##    <chr>        <chr> <chr> <chr> <chr>     <dbl>   <dbl>   <dbl> <dbl>    <dbl>
##  1 Cheetah      Acin… carni Carn… lc         12.1    NA    NA      11.9 NA      
##  2 Owl monkey   Aotus omni  Prim… <NA>       17       1.8  NA       7    0.0155 
##  3 Mountain be… Aplo… herbi Rode… nt         14.4     2.4  NA       9.6 NA      
##  4 Greater sho… Blar… omni  Sori… lc         14.9     2.3   0.133   9.1  0.00029
##  5 Cow          Bos   herbi Arti… domest…     4       0.7   0.667  20    0.423  
##  6 Three-toed … Brad… herbi Pilo… <NA>       14.4     2.2   0.767   9.6 NA      
##  7 Northern fu… Call… carni Carn… vu          8.7     1.4   0.383  15.3 NA      
##  8 Vesper mouse Calo… <NA>  Rode… <NA>        7      NA    NA      17   NA      
##  9 Dog          Canis carni Carn… domest…    10.1     2.9   0.333  13.9  0.07   
## 10 Roe deer     Capr… herbi Arti… lc          3      NA    NA      21    0.0982 
## # … with 73 more rows, 1 more variable: bodywt <dbl>, and abbreviated variable
## #   names ¹​conservation, ²​sleep_total, ³​sleep_rem, ⁴​sleep_cycle
```

```r
#Taken from V.M. Savage and G.B. West. Proceedings of the National Academy of Sciences, 104 (3): 1051-1056, 2007 Publication.
```

2. Store these data into a new data frame `sleep`.

```r
sleep <- msleep
```

3. What are the dimensions of this data frame (variables and observations)? How do you know? Please show the *code* that you used to determine this below.  

```r
dim(msleep)
```

```
## [1] 83 11
```

4. Are there any NAs in the data? How did you determine this? Please show your code.  

```r
anyNA(sleep)
```

```
## [1] TRUE
```

5. Show a list of the column names is this data frame.

```r
names(msleep)
```

```
##  [1] "name"         "genus"        "vore"         "order"        "conservation"
##  [6] "sleep_total"  "sleep_rem"    "sleep_cycle"  "awake"        "brainwt"     
## [11] "bodywt"
```

6. How many herbivores are represented in the data?  

```r
table(msleep$vore)
```

```
## 
##   carni   herbi insecti    omni 
##      19      32       5      20
```

7. We are interested in two groups; small and large mammals. Let's define small as less than or equal to 1kg body weight and large as greater than or equal to 200kg body weight. Make two new dataframes (large and small) based on these parameters.

```r
small_mammals <- filter(msleep, bodywt <=1)
big_mammals <- filter(msleep, bodywt >= 200)
```

8. What is the mean weight for both the small and large mammals?

```r
mean(small_mammals$bodywt, na.rm = T)
```

```
## [1] 0.2596667
```

```r
mean(big_mammals$bodywt, na.rm = T)
```

```
## [1] 1747.071
```



9. Using a similar approach as above, do large or small animals sleep longer on average?  

```r
mean(big_mammals$sleep_total,na.rm = T)
```

```
## [1] 3.3
```

```r
mean(small_mammals$sleep_total,na.rm =T)
```

```
## [1] 12.65833
```



10. Which animal is the sleepiest among the entire dataframe?

```r
max(sleep$sleep_total)
```

```
## [1] 19.9
```


```r
 sleep$sleep_total == 19.9
```

```
##  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [13] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [25] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [37] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
## [49] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [61] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [73] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```

```r
#position43
sleep$name[43]
```

```
## [1] "Little brown bat"
```

```r
#It's the little brown bat!
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
