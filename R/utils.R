
#' Adds georeferenced data to the downloaded data
#'
#' @export
#' @aliases add_geo
#' @param data a data set downloaded using the covid19br::downloadCovid19() function.
#' @param ... further arguments passed to other methods.
#' @return the data set with the added georeferenced data.
#'
add_geo <- function(data, ...){
  level <- attributes(data)$level

  if(level=="cities"){
    data <- data %>%
      filter(!is.na(pop))
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



#' Adds epidemiolocical information (incidence, lethality and mortality rates) to the downloaded data
#'
#' @export
#' @aliases add_epi_info
#' @param data a data set downloaded using the covid19br::downloadCovid19() function.
#' @param ... further arguments passed to other methods.
#' @return the data set with the added epidemiolocical information.
#'

add_epi_info <- function(data, ...){
  newdata <- data %>%
    mutate(
      incidence = 100000*accumCases/pop,
      lethality = round(100*(accumDeaths/accumCases), 2),
      mortality = 100000*accumDeaths/pop
    )
  return(newdata)
}


