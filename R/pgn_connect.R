#' @title Connect to PGNAPES
#'
#'
#' @description Establish a connection to PGNAPES
#'
#' @param username your username
#' @param password your password
#'
#' @return a database connection
#'
#' @export

pgn_connect <- function(username, password) {

  drv <- DBI::dbDriver("Oracle")
  host <- "oracle.hav.fo"
  port <- 1521
  xe <- "xe"

  connect.string <- paste(
    "(DESCRIPTION=",
    "(ADDRESS=(PROTOCOL=tcp)(HOST=", host, ")(PORT=", port, "))",
    "(CONNECT_DATA=(SERVICE_NAME=", xe, ")))", sep = "")

  con <- ROracle::dbConnect(drv, username = username, password = password,
                            dbname = connect.string)

  return(con)
}



pgn_connect_odbc <- function(username, password) {

  drv <- DBI::dbDriver("Oracle")
  host <- "oracle.hav.fo"
  port <- 1521
  xe <- "xe"

  connect.string <- paste(
    "(DESCRIPTION=",
    "(ADDRESS=(PROTOCOL=tcp)(HOST=", host, ")(PORT=", port, "))",
    "(CONNECT_DATA=(SERVICE_NAME=", xe, ")))", sep = "")

  con <- dbConnect(drv, username = "ICE", password = "hjalmar",
                   dbname = connect.string)

  return(con)
}

