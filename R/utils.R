
#' Adds georeferenced data to downloaded data
#'
#' @export
#' @aliases add_geo
#' @param data a data set downloaded using the covid19br::downloadCovid19() function.
#' @param ... further arguments passed to other methods.
#' @return the data set with the added georeferenced data.
#'
add_geo <- function(data, ...){
  level <- attributes(data)$level
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

