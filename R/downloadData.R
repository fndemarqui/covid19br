
set_data_attributes <- function(data, last_updated){
  setattr(data, "language", "en")
  setattr(data, "source", "https://covid.saude.gov.br/")
  setattr(data, "last_updated", last_updated)
}


# Internal function to download Brazilian data from the github repository held by the Department of Statistics of the Universidade Federal de Minas Gerais (UFMG).

downloadBR <- function(language = "en", mr){

  url_brazil <- "https://github.com/dest-ufmg/covid19repo/blob/master/data/brazil.rds?raw=true"
  url_regions <- "https://github.com/dest-ufmg/covid19repo/blob/master/data/regions.rds?raw=true"
  url_states <- "https://github.com/dest-ufmg/covid19repo/blob/master/data/states.rds?raw=true"
  url_cities <- "https://github.com/dest-ufmg/covid19repo/blob/master/data/cities.rds?raw=true"

  if (!curl::has_internet()) {
    message("Sorry, no internet connection!")
    return(NULL)
  }

  url <- switch(mr,
                brazil = url_brazil,
                regions = url_regions,
                states = url_states,
                cities = url_cities
  )

  if (httr::http_error(url)) {
    message("Sorry, data source is broken... please, try again later.")
    return(NULL)
  }

  message("Downloading COVID-19 data from the official Brazilian repository: https://covid.saude.gov.br/")
  message("Please, be patient...")
  covid <- try(readRDS(url(url)), TRUE)
  message("Done!")
  if(!is.null(covid)){
    setattr(covid, "language", "en")
    setattr(covid, "source", "https://covid.saude.gov.br/")
  }
  return(covid)

}


# Internal function to download data (at world level) from the Johns Hopkins University's repository
downloadWorld <- function(language = "en"){
  url_world <- "https://github.com/dest-ufmg/covid19repo/blob/master/data/world.rds?raw=true"
  if (!curl::has_internet()) {
    message("Sorry, no internet connection!")
    return(NULL)
  }

  if (httr::http_error(url_world)) {
    message("Sorry, data source is broken... please, try again later.")
    return(NULL)
  }

  message("Downloading COVID-19 data from the Johns Hopkins University's repository")
  message("Please, be patient...")
  world <- try(readRDS(url(url_world)), TRUE)
  message("Done!")
  if(!is.null(world)){
    setattr(world, "language", "en")
    setattr(world, "source", "https://github.com/CSSEGISandData/COVID-19")
  }
  return(world)
}


#' Function to download COVID-19 data from web repositories
#' @aliases downloadCovid
#' @export
#' @param level the desired level of data aggregation:  "brazil" (default), "regions", "states", "cities", and "world".
#' @return a tibble containing the downloaded data at the specified level.
#' @description This function downloads the pandemic COVID-19 data at Brazil and World levels. Brazilan data is available at national, region, state, and city levels, whereas the world data are available at the country level.
#'
#' @details Data dictionary (variables commum to brazilian and world data):
#' \itemize{
#'   \item date: date of data registry
#'   \item epi_week: epidemiological week
#'   \item pop: estimated population
#'   \item accumCases: accumulative number of confirmed cases
#'   \item newCases: daily count of new confirmed cases
#'   \item accumDeaths: accumulative number of deaths
#'   \item newDeaths: daily count of new deaths
#'   \item newRecovered: daily count of new recovered patients
#' }
#'
#' @details Data dictionary (variables in the brazilian data):
#' \itemize{
#'   \item region: regions' names
#'   \item state: states' names.
#'   \item city: cities' names.
#'   \item state_code: numerical code attributed to states
#'   \item city_code: numerical code attributed to cities
#'   \item healthRegion_code: health region code
#'   \item healthRegion: heald region name
#'   \item newFollowup: daily count of new patients under follow up
#'   \item metro_area: indicator variable for city localized in a metropolitan area
#'   \item capital: indicator variable for capital of brazilian states
#' }
#'
#' @details Data dictionary (variables in the world data):
#' \itemize{
#'   \item country: countries' names
#'   \item accumRecovered: accumulative number of recovered patients
#' }
#'
#'
#' @examples
#' \donttest{
#' library(covid19br)
#'
#' # Downloading Brazilian COVID-19 data:
#' brazil <- downloadCovid19(level = "brazil")
#' regions <- downloadCovid19(level = "regions")
#' states <- downloadCovid19(level = "states")
#' cities <- downloadCovid19(level = "cities")
#'
#' # Downloading world COVID-19 data:
#' world <- downloadCovid19(level = "world")
#' }
#'
downloadCovid19 <- function(level = c("brazil", "regions", "states", "cities", "world")){
  level <- tolower(level)
  mr <- match.arg(level)
  if(level=="world"){
    mydata <- try(downloadWorld(language = "en"), TRUE)
  }else{
    mydata <- try(downloadBR(language = "en", mr), TRUE)
  }
  # if(class(mydata)[1]=="try-error"){
  #   message("Unfortunately the data is currently unavailable. Please, try again later.")
  #   return(dplyr::tibble())
  # }else{
  #   message(" Done!")
  # }
  if(!is.null(mydata)){
    mydata <- setattr(mydata, "level", level)
    class(data) <- "data.frame"
  }

  return(mydata)
}





