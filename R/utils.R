
#' Adding the geometry to the downloaded data for drawing maps
#'
#' @export
#' @aliases add_geo
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @description This function adds the necessary geometry for drawing maps to a given data set downloaded by the covid19br::downloadCovid19() function.
#' @details The function add_geo() was designed to work with the original names of the variables available in the dataset downloaded by the covid19br::downloadCovid19(). For this reason, this function must be used before any changes in the original names of the variables.
#' @param data a data set downloaded using the covid19br::downloadCovid19() function.
#' @param ... further arguments passed to other methods.
#' @return the data set with the added georeferenced data.
#'
#' @details The development human index (DHI) variables (see full description below) are available at city level, and their average are computed for state and region levels.
#'
#' @details Data dictionary (Brazilian data):
#' \itemize{
#'   \item region: regions' names
#'   \item state: states' names.
#'   \item city: cities' names.
#'   \item DHI: development human index.
#'   \item EDHI: educational development human index.
#'   \item LDHI: longevity development human index.
#'   \item IDHI: income development human index.
#'   \item pop: estimated population in 2019.
#'   \item region_code: numerical code attributed to regions
#'   \item state_code: numerical code attributed to states
#'   \item mesoregion_code: numerical code attributed to mesoregions
#'   \item microregion_code: numerical code attributed to microregions
#'   \item city_code: numerical code attributed to cities
#'   \item geometry: georeferenced data needed to plot maps.
#'   \item area: area (in Km^2)
#'   \item demoDens: demographic density.
#' }
#'
#' @details Data dictionary (world data):
#' \itemize{
#'   \item country: country's name
#'   \item continent: continent's name
#'   \item region: regions' names
#'   \item subregion: subregion's name
#'   \item pop: estimated population
#'   \item pais: country's name in Portuguese
#'   \item country_code: numerical code attributed to countries
#'   \item continent_code: numerical code attributed to continents
#'   \item region_code: numerical code attributed to regions
#'   \item subregion_code: numerical code attributed to subregions
#'   \item geometry: georeferenced data needed to plot maps.
#' }
#'
#'
#' @source
#'   \itemize{
#'     \item World map: \url{https://CRAN.R-project.org/package=rnaturalearthdata}
#'     \item Shapefiles for Brazilian maps: \url{https://www.ibge.gov.br/geociencias/downloads-geociencias.html}
#'     \item Brazilian DHI data: \url{https://www.ipea.gov.br/ipeageo/bases.html}
#'   }
#'
#' @examples
#' \donttest{
#' library(covid19br)
#' library(dplyr)
#'
#' regions <- downloadCovid19(level = "regions")
#' regions_geo <- add_geo(regions)
#' glimpse(regions_geo)
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
                   "cities" = readRDS(url("https://github.com/dest-ufmg/covid19repo/blob/master/data/geoCities.rds?raw=true")),
                   "states" = readRDS(url("https://github.com/dest-ufmg/covid19repo/blob/master/data/geoStates.rds?raw=true")),
                   "regions" = readRDS(url("https://github.com/dest-ufmg/covid19repo/blob/master/data/geoRegions.rds?raw=true")),
                   "world" = readRDS(url("https://github.com/dest-ufmg/covid19repo/blob/master/data/mundi.rds?raw=true"))
    )
    newdata <- data %>%
      dplyr::left_join(map) %>%
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
#'
#' @examples
#' \donttest{
#' library(covid19br)
#' library(dplyr)
#'
#' brazil <- downloadCovid19(level = "brazil")
#' brazil <- add_epi_rates(brazil)
#' glimpse(brazil)
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



