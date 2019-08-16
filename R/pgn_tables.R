#' A convenient function
#'
#' @param con A connection to pgnapes
#' @param table A character specifying the name of the table
#'
#' @return An sql tibble
#' @export
#'
pgn_tbl <- function(con, table) {
  dplyr::tbl(con, toupper(table)) %>%
    dplyr::select_all(tolower)
}

#' pgnapes overview
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export
#'
pgn_overview <- function(con) {
  pgn_tbl(con, "all_tables")
}

#' Accustics
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export

pgn_acoustic <- function(con) {
  pgn_tbl(con, "acoustic")
}

#' Accustic values
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export

pgn_acousticvalues <- function(con) {
  pgn_tbl(con, "acousticvalues")
}

#' Biology
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export

pgn_biology <- function(con) {
  pgn_tbl(con, "biology")
}

#' Catch
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export

pgn_catch <- function(con) {
  pgn_tbl(con, "catch")
}

#' Countries
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export

pgn_countries <- function(con) {
  pgn_tbl(con, "countries")
}

#' Hydrography
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export
pgn_hydrography <- function(con) {
  pgn_tbl(con, "hydrography")
}

#' icessquares
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export
#'
pgn_icessquares <- function(con) {
  pgn_tbl(con, "icessquares")
}

#' icessquares_big
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export
#'
pgn_icessquares_big <- function(con) {
  pgn_tbl(con, "icessquares_big")
}

#' igoss
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export
#'
pgn_igoss <- function(con) {
  pgn_tbl(con, "igoss")
}

#' plankton
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export
#'
pgn_plankton <- function(con) {
  pgn_tbl(con, "plankton")
}

#' Logbooks
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export
#'
pgn_logbook <- function(con) {
  pgn_tbl(con, "logbook") %>%
    dplyr::mutate(lat = as.numeric(lat),
                  lon = as.numeric(lon),
                  day = as.numeric(day),
                  day = ifelse(day > 31, NA, day),
                  hour = as.numeric(hour),
                  hour = ifelse(hour > 23, NA, hour),
                  min = as.numeric(min),
                  min = ifelse(min > 59, NA, min))
}

#' Species
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export
#'
pgn_species <- function(con) {
  pgn_tbl(con, "species")
}

#' Station types
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export
#'
pgn_stationtypes <- function(con) {
  pgn_tbl(con, "stationtypes")
}

#' Survey
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export
#'
pgn_survey <- function(con) {
  pgn_tbl(con, "survey")
}

#' Vessels
#'
#' @param con A connection to pgnapes
#'
#' @return An sql tibble
#' @export
#'
pgn_vessels <- function(con) {
  pgn_tbl(con, "vessels")
}
