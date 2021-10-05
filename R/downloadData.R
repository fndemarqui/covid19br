

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


  # covid <- switch(mr,
  #   brazil = try(readRDS(url(url_brazil)), TRUE),
  #   regions = try(readRDS(url(url_regions)), TRUE),
  #   states = try(readRDS(url(url_states)), TRUE),
  #   cities = try(readRDS(url(url_cities)), TRUE)
  # )
  #
  #
  # if(suppressWarnings(class(covid)[1]=="try-error")){
  #   message("The data is currently unavailable. Please, try again later.")
  #   return(dplyr::tibble())
  # }else{
  #   message(" Done!")
  #   setattr(covid, "language", "en")
  #   setattr(covid, "source", "https://covid.saude.gov.br/")
  #   return(covid)
  # }

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


# Function to download data (at world level) from the Johns Hopkins University's repository
downloadWorld <- function(language = "en"){
  message("Downloading COVID-19 data from the Johns Hopkins University's repository")
  message("Please, be patient...")

  url_confirmed <- "https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_confirmed_global.csv&filename=time_series_covid19_confirmed_global.csv"
  url_deaths <-    "https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_deaths_global.csv&filename=time_series_covid19_deaths_global.csv"
  url_recovered <- "https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_recovered_global.csv&filename=time_series_covid19_recoverd_global.csv"

  # confirmed <- fread(url_confirmed)
  # deaths <- fread(url_deaths)
  # recovered <- fread(url_recovered)
  confirmed <- rio::import(url_confirmed)
  deaths <- rio::import(url_deaths)
  recovered <- rio::import(url_recovered)

  deaths <- deaths %>%
    rename(country = 'Country/Region')  %>%
    pivot_longer(cols = -c("Province/State", "country", "Lat", "Long"),
                 names_to = "date", values_to = "accumDeaths") %>%
    mutate(date = mdy(.data$date)) %>%
    group_by(.data$country, .data$date) %>%
    summarise(accumDeaths = sum(.data$accumDeaths))

  confirmed <- confirmed %>%
    rename(country = 'Country/Region')  %>%
    pivot_longer(cols = -c("Province/State", "country", "Lat", "Long"),
                 names_to = "date", values_to = "accumCases") %>%
    mutate(date = mdy(.data$date)) %>%
    group_by(.data$country, .data$date) %>%
    summarise(accumCases = sum(.data$accumCases))

  recovered <- recovered %>%
    rename(country = 'Country/Region')  %>%
    pivot_longer(cols = -c("Province/State", "country", "Lat", "Long"),
                 names_to = "date", values_to = "accumRecovered") %>%
    mutate(date = mdy(.data$date)) %>%
    group_by(.data$country, .data$date) %>%
    summarise(accumRecovered = sum(.data$accumRecovered))


  world <- confirmed %>%
    full_join(deaths, by=c("country", "date")) %>%
    full_join(recovered, by=c("country", "date"))

  world <- world %>%
    group_by(.data$country) %>%
    mutate(
      epi_week = epiweek(.data$date),
      newCases = diff(c(0, .data$accumCases)),
      newDeaths = diff(c(0, .data$accumDeaths)),
      newRecovered = diff(c(0, .data$accumRecovered))) %>%
    relocate(.data$country, .data$date, .data$epi_week)

  # trying to attenuate error on the data base due to non increasing accummulative counts:
  world$newCases[world$newCases < 0] <- 0
  world$newDeaths[world$newDeaths < 0] <- 0
  world$newRecovered[world$newRecovered < 0] <- 0

  #-----------------------------------------------------------------------------------------------------
  # Changing the names of the countries for compatility with the map:
  world$`country`<-as.character(world$`country`)
  world$'country'[world$'country'=="US"]<- "United States of America"
  world$'country'[world$'country'=="Antigua and Barbuda"]<-"Antigua and Barb."
  world$'country'[world$'country'=="Bosnia and Herzegovina"]<- "Bosnia and Herz."
  world$'country'[world$'country'=="Central African Republic"]<-"Central African Rep."
#  world$'country'[world$'country'=="Cote d'Ivoire"]<- "Côte d'Ivoire"
  world$'country'[world$'country'=="Dominican Republic"]<- "Dominican Rep."
  world$'country'[world$'country'=="Equatorial Guinea"]<-"Eq. Guinea"
  world$'country'[world$'country'=="Eswatini"]<-"eSwatini"
  world$'country'[world$'country'=="Holy See"]<-"Vatican"
  world$'country'[world$'country'=="Korea, South"]<- "South Korea"
  world$'country'[world$'country'=="South Sudan"]<-"S. Sudan"
  world$'country'[world$'country'=="Western Sahara"]<-"W. Sahara"
#  world$'country'[world$'country'=="Sao Tome and Principe"]<- "São Tomé and Principe"
  world$'country'[world$'country'=="North Macedonia"]<- "Macedonia"
  world$'country'[world$'country'=="Saint Vincent and the Grenadines"]<-"St. Vin. and Gren."
  world$'country'[world$'country'=="Saint Kitts and Nevis"]<-"St. Kitts and Nevis"
  world$'country'[world$'country'=="Taiwan*"]<-"Taiwan"
  world$'country'[world$'country'=="Burma"]<-"Myanmar"
  world$'country'[world$'country'=="Congo (Kinshasa)"]<-"Dem. Rep. Congo"
  world$'country'[world$'country'=="Congo (Brazzaville)"]<-"Congo"
  world$'country'[world$'country'=="West Bank and Gaza"]<-"Palestine" # Cisjordania e faixa de gaza
  #-----------------------------------------------------------------------------------------------------

  class(world) <-  class(world)[-1]

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
#' @details The Brazilian data provided by the Brazilian government at its official repository (https://covid.saude.gov.br/) is available in a single xlsx file. That file contains data aggregated at national, state, and city geographic levels.  Because importing such data file into R requires a considerable amount of RAM (over 4G), the data is daily downloaded with the internal function  \code{downloadMS}, and then made available in smaller/lighter binary files at a GitHub repository (https://github.com/dest-ufmg/covid19repo) maintained by the authors' package.
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





