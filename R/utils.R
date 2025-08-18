download_rds_data <- function(level = c("brazil", "regions", "states", "cities", "world"), type = c("covid", "geo")){

  # Initialize the response object
  response <- NULL

  level <- match.arg(level)
  type <- match.arg(type)

  url <- switch (type,
                 covid = paste0("https://github.com/dest-ufmg/covid19repo/blob/master/data/", level, ".rds?raw=true"),
                 geo =  paste0("https://github.com/dest-ufmg/covid19repo/blob/master/data/geo", level, ".rds?raw=true")
  )

  # Use a tryCatch block to perform the web request and handle errors
  tryCatch({
    response <- httr2::request(url) %>%
      httr2::req_perform()

    # Check for a successful HTTP status code (e.g., 200 OK)
    if(httr2::resp_is_error(response)){
      stop(paste("HTTP request failed with status:", httr2::resp_status(response)))
    }
  }, error = function(e){
    # This block runs if an error occurs (e.g., no internet connection)
    message("Could not download the data. Please check your internet connection.")
    message("Error details: ", e$message)
    return(NULL)
  })

  # Return NULL if the request was unsuccessful
  if (is.null(response)){
    return(tibble::tibble())
  }else{
    # Extract raw binary data
    binary_data <- httr2::resp_body_raw(response)

    # Define the local file path to save the data
    file_path <- tempfile()

    # Write the binary data to the file
    writeBin(binary_data, file_path)

    data <- readRDS(file_path)
    return(data)
  }
}


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
#'     \item Brazilian DHI data: \url{https://github.com/ipea/IpeaGeo}
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

add_geo <- function(data, ...){

  if(nrow(data)>0){
    level <- attributes(data)$level

    if(level=="cities"){
      data <- data %>%
        filter(!is.na(.data$pop))
    }
    if(level == "brazil"){
      return(data)
    }else{
      newdata <- switch(level,
                        regions = dplyr::left_join(data, covid19br::georegions),
                        states = dplyr::left_join(data, covid19br::geostates),
                        cities = dplyr::left_join(data, covid19br::geocities),
                        world = dplyr::left_join(data, covid19br::geoworld),
      )
    }
    newdata <- sf::st_as_sf(newdata)
  }else{
    message("Geographical information cannot be added to the 0x0 tibble/data.frame provided.")
    return(tibble::tibble())
  }

}

# add_geo <- function(data, ...){
#
#   if(nrow(data)>0){
#     level <- attributes(data)$level
#
#     if(level=="cities"){
#       data <- data %>%
#         filter(!is.na(.data$pop))
#     }
#     if(level == "brazil"){
#       return(data)
#     }else{
#       map <- download_rds_data(level = level, type = "geo")
#       if(nrow(map)>0){
#         newdata <- data %>%
#           dplyr::left_join(map) %>%
#           sf::st_as_sf()
#         return(newdata)
#       }else{
#         return(data)
#       }
#     }
#   }else{
#     message("Geographical information cannot be added to the 0x0 tibble/data.frame provided.")
#     return(tibble::tibble())
#   }
#
# }



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
  if(nrow(data)>0){
    newdata <- data %>%
      mutate(
        incidence = 100000*.data$accumCases/.data$pop,
        lethality = round(100*(.data$accumDeaths/.data$accumCases), 2),
        lethality = replace_na(.data$lethality, 0),
        mortality = 100000*.data$accumDeaths/.data$pop
      )
    return(newdata)
  }else{
    message("No rates can be computed using the 0x0 tibble/data.frame provided.")
    return(tibble::tibble())
  }

}



