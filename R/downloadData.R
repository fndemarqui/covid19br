
set_data_attributes <- function(data, last_updated){
  setattr(data, "language", "en")
  setattr(data, "source", "https://covid.saude.gov.br/")
  setattr(data, "last_updated", last_updated)
}


# Internal function to download Brazilian data from the github repository held by the Department of Statistics of the Universidade Federal de Minas Gerais (UFMG).
downloadBR <- function(language = "en", mr){
  message("Downloading COVID-19 data from the official Brazilian repository: https://covid.saude.gov.br/")
  message("Please, be patient...")

  url_brazil <- "https://github.com/dest-ufmg/covid19repo/blob/master/data/brazil.rds?raw=true"
  url_regions <- "https://github.com/dest-ufmg/covid19repo/blob/master/data/regions.rds?raw=true"
  url_states <- "https://github.com/dest-ufmg/covid19repo/blob/master/data/states.rds?raw=true"
  url_cities <- "https://github.com/dest-ufmg/covid19repo/blob/master/data/cities.rds?raw=true"

  covid <- switch(mr,
                  brazil = try(readRDS(url(url_brazil)), TRUE),
                  regions = try(readRDS(url(url_regions)), TRUE),
                  states = try(readRDS(url(url_states)), TRUE),
                  cities = try(readRDS(url(url_cities)), TRUE)
  )

  setattr(covid, "language", "en")
  setattr(covid, "source", "https://covid.saude.gov.br/")
  return(covid)

}


# Internal function to download data (at world level) from the Johns Hopkins University's repository
downloadWorld <- function(language = "en"){
  message("Downloading COVID-19 data from the Johns Hopkins University's repository")
  message("Please, be patient...")

  url_world <- "https://github.com/dest-ufmg/covid19repo/blob/master/data/world.rds?raw=true"
  world <- try(readRDS(url(url_world)), TRUE)
  setattr(world, "language", "en")
  setattr(world, "source", "https://github.com/CSSEGISandData/COVID-19")

  return(world)
}



#' Function to download COVID-19 data from web repositories
#' @aliases downloadCovid
#' @export
#' @param level the desired level of data aggregation:  "brazil" (default), "regions", "states", "cities", and "world".
#' @return a tibble containing the downloaded data at the specified level.
#' @description This function downloads the pandemic COVID-19 data at Brazil and World basis. Brazilan data is available at national, region, state, and city levels, whereas the world data are available at the country level.
#' @details The Brazilian data provided by the Brazilian government at its official repository (https://covid.saude.gov.br/) is available in multiple xlsx files. Those files contains data aggregated at national, state, and city geographic levels.  Because importing such data file into R requires a considerable amount of RAM (currently over 4G), the data is daily downloaded and then made available in smaller/lighter binary files on the GitHub repository (https://github.com/dest-ufmg/covid19repo) maintained by the authors' package.
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
  if(class(mydata)[1]=="try-error"){
    message("Unfortunately the data is currently unavailable. Please, try again later.")
    return(dplyr::tibble())
  }else{
    message(" Done!")
  }
  mydata <- setattr(mydata, "level", level)
  return(mydata)
}





