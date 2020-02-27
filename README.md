---
output: 
  html_document: 
    fig_height: 12
    fig_width: 9
    keep_md: yes
---

### Shaking hands with PGNAPES
#### Einar Hjörleifsson
#### 2019-08-16



The pgnapes as a few set of convenient functions that connect and query the pgnapes-database from within R. That database is an Oracle datbase and the connection used here is via the ROracle package. Installment of the ROracle may not be straight forward, see details [here](http://cran.hafro.is/web/packages/ROracle/INSTALL). Information on the installation of the needed Oracle Instant Client are [here](https://www.oracle.com/database/technologies/instant-client.html). Once this is in place one can proceed with the following:

This article may also help: [Using dplyr & dbplyr with R language and Oracle Database](https://medium.com/oracledevs/r-and-the-oracle-database-using-dplyr-dbplyr-with-roracle-in-windows-10-8ddcabdd6e97)


**Installing pgnapes**:

```r
devtools::install_github("hjorleifsson/pgnapes")
```

**At the start of an R-sesssion load some packages**:

```r
library(ROracle)
library(tidyverse)
library(pgnapes)
library(maps)
```

**Connect to database**:


```r
con <- pgn_connect("your_user_name", "your_password")
```



**Available wrappers**:


```r
pgn_acoustic(con)
pgn_acousticvalues(con)
pgn_biology(con)
pgn_catch(con)
pgn_countries(con)
pgn_hydrography(con)
pgn_icessquares(con)
pgn_icessquares_big(con)
pgn_igoss(con)
pgn_plankton(con)
pgn_logbook(con)
pgn_species(con)
pgn_stationtypes(con)
pgn_survey(con)
pgn_vessels(con)
```

**Get and "standardize" mackerel catch**:


```r
d <-
  pgn_logbook(con) %>%
  filter(year >= 2013,
         month %in% 7:8,
         sttype %in% c("PTRAWL", "TRAWL", "Multpelt", "PTrawl_Straight",
                       "DeepTrawl", "Multpelt 832")) %>%
  arrange(cruise, year, month, day, hour, min) %>%
  left_join(pgn_catch(con) %>% 
              filter(species %in% "MAC")) %>%
  collect(n = Inf) %>% 
  mutate(catch = catch / 1000 / (towtime / 60),
         catch = replace_na(catch, 0))
```

**Map catch**:


```r
xlim <- range(d$lon)
ylim <- range(d$lat)
m <- map_data("world", xlim = xlim, ylim = ylim)
d %>% 
  ggplot(aes(lon, lat)) +
  geom_polygon(data = m, aes(long, lat, group = group), fill = "grey") +
  geom_path(aes(group = cruise), colour = "grey") +
  geom_point(aes(size = catch), colour = "red", alpha = 0.5) +
  scale_size_area(max_size = 10) +
  geom_point(size = 0.01) +
  facet_wrap(~ year, ncol = 2) +
  coord_quickmap(xlim = xlim, ylim = ylim) +
  scale_x_continuous(NULL, NULL) +
  scale_y_continuous(NULL, NULL)
```

![](README_files/figure-html/maccatch-1.png)<!-- -->

