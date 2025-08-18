
#' Function to download COVID-19 data from web repositories
#' @aliases downloadCovid
#' @export
#' @param level the desired level of data aggregation:  "brazil" (default), "regions", "states", "cities", and "world".
#' @return a tibble containing the downloaded data at the specified level.
#' @description This function downloads the pandemic COVID-19 data at Brazil and World levels. Brazilian data is available at national, region, state, and city levels, whereas the world data are available at the country level.
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
  level <- match.arg(level)
  message("Downloading COVID-19 data... please, be patient!")
  data <- download_rds_data(level = level, type = "covid")
  return(data)
}






