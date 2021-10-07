
#' Adding the geometry to the downloaded data for drawing maps
#'
#' @export
#' @aliases add_geo
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @description This function adds the necessary geometry for drawing maps to a given data set downloaded by the covid19br::downloadCovid19() function.
#' @details The function add_geo() was designed to work with the original names of the variables available in the data set downloaded by the covid19br::downloadCovid19(). For this reason, this function must be used before any change in such variable names.
#' @param data a data set downloaded using the covid19br::downloadCovid19() function.
#' @param ... further arguments passed to other methods.
#' @return the data set with the added georeferenced data.
#' @examples
#' \donttest{
#' library(covid19br)
#'
#' regions <- downloadCovid19(level = "regions")
#' regions_geo <- add_geo(regions)
#' }
#'

add_geo <- function(data, ...){
  level <- attributes(data)$level

  if(level=="cities"){
    data <- data %>%
      filter(!is.na(.data$pop))
  }
  if(level == "brazil"){
    return(data)
  }else{
    map <- switch (level,
                   "cities" = covid19br::ibgeCities,
                   "states" = covid19br::ibgeStates,
                   "regions" = covid19br::ibgeRegions,
                   "world" = covid19br::mundi
    )
    vars <- names(map)[names(map) %in% names(data)]
    newdata <- data %>%
      dplyr::left_join(map, by = vars) %>%
      sf::st_as_sf()
    return(newdata)
  }
}



#' Adding incidence, mortality and lethality rates to the downloaded data
#'
#' @export
#' @aliases add_epi_rates
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @description This function adds the incidence, mortality and lethality rates to a given data set downloaded by the covid19br::downloadCovid19() function.
#' @details The function add_epi_rates() was designed to work with the original names of the variables accumDeaths, accummCases and pop available in the data set downloaded by the covid19br::downloadCovid19(). For this reason, this function must be used before any change in such variable names.
#' @param data a data set downloaded using the covid19br::downloadCovid19() function.
#' @param ... further arguments passed to other methods.
#' @return the data set with the added incidence, mortality and lethality rates.
#' @examples
#' \donttest{
#' library(covid19br)
#'
#' brazil <- downloadCovid19(level = "brazil")
#' brazil <- add_epi_rates(brazil)
#' }
#'

add_epi_rates <- function(data, ...){
  newdata <- data %>%
    mutate(
      incidence = 100000*.data$accumCases/.data$pop,
      lethality = round(100*(.data$accumDeaths/.data$accumCases), 2),
      lethality = replace_na(.data$lethality, 0),
      mortality = 100000*.data$accumDeaths/.data$pop
    )
  return(newdata)
}


