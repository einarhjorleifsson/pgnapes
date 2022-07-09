
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pgnapes

<!-- badges: start -->
<!-- badges: end -->

The goal of {pgnapes} is to:

-   Establish R-connection to PGNAPES Oracle database
-   Provide convenient functions to PGNAPES tables and views
-   R-code examples for data analysis and graphical presentations

## Installation

You can install the development version of pgnapes from
[GitHub](https://github.com/) with:

``` r
install.packages("devtools")
remotes::install_github("einarhjorleifsson/pgnapes")
```

The backbone of {pgnapes} is {dplyr} which allows for generation of
simple or complex sequence of codes that are automatically translated to
SQL via the {dbplyr}-package. Since the PGNAPES database is Oracle 11g
one can not use {dbplyr} versions \>2.0. Hence we need to install an
older version:

``` r
remotes::install_github("tidyverse/dbplyr@v1.4.4", force = TRUE)
```

**Side effects**: Installing an earlier version of {dbplyr} means that
one can not load the {tidyverse} package only its child packages (dplyr,
ggplot2, tidyr, tibble, ….).

## Connection

All functions in the {pgnapes} package have a prefix `pgn_`. The core
function in {pgnapes} is the `pgn_connect` that provides a connection to
the PGNAPES database. The arguments of the function are *username*,
*password* and *use_odbc*. The two first arguments are self-expanatory.
The arguement *use_odbc* (default TRUE) provides a control if connection
is made via {odbc} or {ROracle}. The latter is generally faster but the
{ROracle}-package setup is more difficult. Your IT-department may be of
help here, details on intallments are
[here](http://cran.hafro.is/web/packages/ROracle/INSTALL). Information
on the installation of the needed Oracle Instant Client are
[here](https://www.oracle.com/database/technologies/instant-client.html).
load(“leyndo.RData”)

In the document provided here the {odbc}-connection is use

**At the start of an R-sesssion load some packages**:

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(tidyr)
library(ggplot2)
library(pgnapes)
library(maps)
```

**Connect to database**:

``` r
con <- pgn_connect("your_user_name", "your_password")
```

``` r
con
#> <OdbcConnection> ICE@oracle.hav.fo/xe
#>   Oracle Version: 11.02.0020
```

## Available convenient wrappers

``` r
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

## Example: Get and “standardize” mackerel catch\*\*

``` r
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
#> Joining, by = c("country", "vessel", "cruise", "station", "sttype", "year")
```

**Map catch**:

``` r
xlim <- range(d$lon)
ylim <- range(d$lat)
m <- map_data("world", xlim = xlim, ylim = ylim)
d %>% 
  ggplot(aes(lon, lat)) +
  theme_bw() +
  geom_polygon(data = m, aes(long, lat, group = group), fill = "grey") +
  geom_path(aes(group = cruise), colour = "grey", lwd = 0.25, alpha = 0.5) +
  geom_point(aes(size = catch), colour = "red", alpha = 0.35) +
  scale_size_area(max_size = 10) +
  geom_point(size = 0.01, alpha = 0.2) +
  facet_wrap(~ year, ncol = 2) +
  coord_quickmap(xlim = xlim, ylim = ylim) +
  scale_x_continuous(NULL, NULL) +
  scale_y_continuous(NULL, NULL)
```

<img src="man/figures/README-maccatch-1.png" width="100%" />
