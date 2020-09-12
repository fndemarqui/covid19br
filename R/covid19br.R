#' The 'covid19br' package.
#'
#' @importFrom rlang .data
#' @importFrom dplyr %>%
#' @importFrom dplyr as_tibble
#' @importFrom dplyr group_by
#' @importFrom dplyr summarise
#' @importFrom dplyr mutate
#' @importFrom dplyr rename
#' @importFrom dplyr recode
#' @importFrom dplyr select
#' @importFrom dplyr filter
#' @importFrom dplyr full_join
#' @importFrom dplyr left_join
#' @importFrom dplyr relocate
#' @importFrom dplyr slice
#' @importFrom lubridate dmy
#' @importFrom lubridate mdy
#' @importFrom lubridate ymd
#' @importFrom lubridate epiweek
#' @importFrom httr GET
#' @importFrom httr add_headers
#' @importFrom data.table melt
#' @importFrom data.table fread
#' @importFrom data.table setattr
#' @importFrom httr content
#' @importFrom tidyr pivot_longer
#' @importFrom tidyr replace_na
#'
#' @description The package provides a function to automatically import  Brazilian CODID-19 pandemic data into R. Brazilian data is available on the country-level, region-level, state-level, and city-level, and are downloaded from the official Brazilian's repository at <https://covid.saude.gov.br/>. The package also downloads the world-level COVID-19 data from the John Hopkins University's repository at <https://github.com/CSSEGISandData/COVID-19>.
#'
#'@author Fábio N. Demarqui, Cristiano C. Santos, and Matheus B. Costa.
#' @docType package
#' @name covid19br
#' @aliases covid19br
#'
#'
NULL
