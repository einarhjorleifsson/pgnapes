#' @title Connect to PGNAPES
#'
#' @description This function is the mother of all mothers that all other ft_ functions rely on. If not you are doomed.
#'
#' @param username your username
#' @param password your password
#' @param use_odbc A boolean (default TRUE) controlling if connection via odbc or ROracle.
#' The latter is generally faster but more difficult to setup.
#'
#' @return a database connection
#'
#' @export

pgn_connect <- function(username, password, use_odbc = TRUE) {

  if(use_odbc) {
    con <- DBI::dbConnect(odbc::odbc(),
                          UID = username,
                          PWD = password,
                          Driver = "Oracle",
                          DBQ = "oracle.hav.fo/xe",
                          Port = 1521,
                          # SVC = "DB_SCHEMA", # schema when connection opens
                          timeout = 20)
    # con <- DBI::dbConnect(odbc::odbc(),
    #                       UID = username,
    #                       PWD = password,
    #                       .connection_string = "Driver={Oracle};DBQ=oracle.hav.fo:1521/xe;",
    #                       timeout = 10)
  } else {

    drv <- DBI::dbDriver("Oracle")
    host <- "oracle.hav.fo"   # Needs to be replaced
    port <- 1521
    xe <- "xe"                # This is dbname

    connect.string <- paste(
      "(DESCRIPTION=",
      "(ADDRESS=(PROTOCOL=tcp)(HOST=", host, ")(PORT=", port, "))",
      "(CONNECT_DATA=(SERVICE_NAME=", xe, ")))", sep = "")

    con <- ROracle::dbConnect(drv, username = username, password = password,
                              dbname = connect.string)
  }

  return(con)
}
