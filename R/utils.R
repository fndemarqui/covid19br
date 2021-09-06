
#' Addition to Georeferenced data
#' @aliases add_geo
#' @param data a data set downloaded using the covid19br::downloadCovid19() function.
#' @param ... further arguments passed to other methods.
#' @return the data set with the added georeferenced data.
#' @export
#'
add_geo <- function(data, ...){
  level <- attributes(data)$level
  if(level == "brazil"){
    return(data)
  }else{
    map <- switch (level,
                   "cities" = ibgeCities,
                   "states" = ibgeStates,
                   "regions" = ibgeRegions,
                   "world" = mundi
    )
    vars <- names(map)[names(map) %in% names(data)]
    newdata <- data %>%
      dplyr::left_join(map, by = vars) %>%
      sf::st_as_sf()
    return(newdata)
  }

}

