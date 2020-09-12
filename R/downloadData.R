
# Function to download data (at Brazilian level) from the official Brazilian's repository
downloadBR <- function(language = "en"){
  message("Downloading COVID-19 data from the official Brazilian repository: https://covid.saude.gov.br/")
  message("Please, be patient!!!")
  url <- "https://xx9p7hp1p7.execute-api.us-east-1.amazonaws.com/prod/PortalGeral"
  covid <- GET(url, add_headers("x-parse-application-id" = "unAFkcaNDeXajurGB7LChj8SgQYS2ptm"))
  results <- covid %>% content()
  url_data <- results$results[[1]]$arquivo$url
  cities <- openxlsx::read.xlsx(url_data, detectDates = TRUE) %>%
    as_tibble()


  cities <- cities %>%
    rename(
      region = .data$regiao,
      state = .data$estado,
      city = .data$municipio,
      state_code = .data$coduf,
      city_code = .data$codmun,
      date = .data$data,
      healthRegion = .data$nomeRegiaoSaude,
      healthRegion_code = .data$codRegiaoSaude,
      newRecovered = .data$Recuperadosnovos,
      newFollowup = .data$emAcompanhamentoNovos,
      metrop_area = .data$`interior/metropolitana`,
      epi_week = .data$semanaEpi,
      accumCases = .data$casosAcumulado,
      accumDeaths = .data$obitosAcumulado,
      newCases = .data$casosNovos,
      newDeaths = .data$obitosNovos,
      pop = .data$populacaoTCU2019) %>%
    mutate(
      date = as.Date(.data$date),
      epi_week = as.integer(.data$epi_week),
      accumCases = as.integer(.data$accumCases),
      accumDeaths = as.integer(.data$accumDeaths),
      pop = as.numeric(.data$pop),
      region = recode(.data$region,
                      Norte = "North",
                      Nordeste = "Northeast",
                      Sudeste = "Southeast",
                      Sul = "South",
                      'Centro-Oeste' = "Midwest")
    )


  brazil <- cities %>%
    filter(.data$region == "Brasil") %>%
    select(.data$date, .data$epi_week, .data$newCases, .data$accumCases, .data$newDeaths,
           .data$accumDeaths, .data$newRecovered, .data$newFollowup, .data$pop)



  cities <- cities %>%
    filter(.data$region != "Brasil")
  out <- 1:(27*nrow(brazil))

  states <- cities %>%
    slice(out) %>%
    select(.data$region, .data$state, .data$date, .data$epi_week, .data$newCases,
           .data$accumCases, .data$newDeaths, .data$accumDeaths, .data$newRecovered,
           .data$newFollowup, .data$pop, .data$state_code)


  regions <- states %>%
    group_by(.data$region, .data$date, .data$epi_week) %>%
    summarise(
      newCases = sum(.data$newCases),
      accumCases = sum(.data$accumCases),
      newDeaths = sum(.data$newDeaths),
      accumDeaths = sum(.data$accumDeaths),
      newRecovered = sum(.data$newRecovered),
      newFollowup = sum(.data$newFollowup),
      pop = sum(.data$pop)
    )



  cities <- slice(cities, -out)

  covid <- list(brazil = brazil, regions = regions, states = states, cities = cities)
  setattr(covid, "language", "en")
  setattr(covid, "source", "https://covid.saude.gov.br/")

  return(covid)
}


# Function to download data (at world level) from the Johns Hopkins University's repository
downloadWorld <- function(language = "en"){
  message("Downloading COVID-19 data from the John Hopkins University's repository")
  message("Please, be patient...")

  url_confirmed <- "https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_confirmed_global.csv&filename=time_series_covid19_confirmed_global.csv"
  url_deaths <-    "https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_deaths_global.csv&filename=time_series_covid19_deaths_global.csv"
  url_recovered <- "https://data.humdata.org/hxlproxy/api/data-preview.csv?url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_recovered_global.csv&filename=time_series_covid19_recoverd_global.csv"

  confirmed <- fread(url_confirmed)
  deaths <- fread(url_deaths)
  recovered <- fread(url_recovered)

  message(" Done!")

  deaths <- deaths %>%
    rename(local = 'Country/Region')  %>%
    pivot_longer(cols = -c("Province/State", "local", "Lat", "Long"),
                 names_to = "date", values_to = "accumDeaths") %>%
    mutate(date = mdy(.data$date)) %>%
    group_by(.data$local, .data$date) %>%
    summarise(accumDeaths = sum(.data$accumDeaths))

  confirmed <- confirmed %>%
    rename(local = 'Country/Region')  %>%
    pivot_longer(cols = -c("Province/State", "local", "Lat", "Long"),
                 names_to = "date", values_to = "accumCases") %>%
    mutate(date = mdy(.data$date)) %>%
    group_by(.data$local, .data$date) %>%
    summarise(accumCases = sum(.data$accumCases))

  recovered <- recovered %>%
    rename(local = 'Country/Region')  %>%
    pivot_longer(cols = -c("Province/State", "local", "Lat", "Long"),
                 names_to = "date", values_to = "accumRecovered") %>%
    mutate(date = mdy(.data$date)) %>%
    group_by(.data$local, .data$date) %>%
    summarise(accumRecovered = sum(.data$accumRecovered))


  world <- confirmed %>%
    full_join(deaths, by=c("local", "date")) %>%
    full_join(recovered, by=c("local", "date"))

  world <- world %>%
    group_by(.data$local) %>%
    mutate(
      epi_week = epiweek(.data$date),
      newCases = diff(c(0, .data$accumCases)),
      newDeaths = diff(c(0, .data$accumDeaths)),
      newRecovered = diff(c(0, .data$accumRecovered))) %>%
    relocate(.data$local, .data$date, .data$epi_week)

  # trying to attenuate error on the data base due to non increasing accummulative counts:
  world$newCases[world$newCases < 0] <- 0
  world$newDeaths[world$newDeaths < 0] <- 0
  world$newRecovered[world$newRecovered < 0] <- 0

  #-----------------------------------------------------------------------------------------------------
  # Changing the names of the countries for compatility with the map:
  world$`local`<-as.character(world$`local`)
  world$'local'[world$'local'=="US"]<- "United States of America"
  world$'local'[world$'local'=="Antigua and Barbuda"]<-"Antigua and Barb."
  world$'local'[world$'local'=="Bosnia and Herzegovina"]<- "Bosnia and Herz."
  world$'local'[world$'local'=="Central African Republic"]<-"Central African Rep."
#  world$'local'[world$'local'=="Cote d'Ivoire"]<- "Côte d'Ivoire"
  world$'local'[world$'local'=="Dominican Republic"]<- "Dominican Rep."
  world$'local'[world$'local'=="Equatorial Guinea"]<-"Eq. Guinea"
  world$'local'[world$'local'=="Eswatini"]<-"eSwatini"
  world$'local'[world$'local'=="Holy See"]<-"Vatican"
  world$'local'[world$'local'=="Korea, South"]<- "South Korea"
  world$'local'[world$'local'=="South Sudan"]<-"S. Sudan"
  world$'local'[world$'local'=="Western Sahara"]<-"W. Sahara"
#  world$'local'[world$'local'=="Sao Tome and Principe"]<- "São Tomé and Principe"
  world$'local'[world$'local'=="North Macedonia"]<- "Macedonia"
  world$'local'[world$'local'=="Saint Vincent and the Grenadines"]<-"St. Vin. and Gren."
  world$'local'[world$'local'=="Saint Kitts and Nevis"]<-"St. Kitts and Nevis"
  world$'local'[world$'local'=="Taiwan*"]<-"Taiwan"
  world$'local'[world$'local'=="Burma"]<-"Myanmar"
  world$'local'[world$'local'=="Congo (Kinshasa)"]<-"Dem. Rep. Congo"
  world$'local'[world$'local'=="Congo (Brazzaville)"]<-"Congo"
  world$'local'[world$'local'=="West Bank and Gaza"]<-"Palestine" # Cisjordania e faixa de gaza
  #-----------------------------------------------------------------------------------------------------

  class(world) <-  class(world)[-1]

  setattr(world, "language", "en")
  setattr(world, "source", "https://github.com/CSSEGISandData/COVID-19")
  return(world)
}



#' Function to download COVID-19 data from web repositories
#' @aliases downloadCovid
#' @export
#' @param from label associated with the repository from which the data will be downloaded: "brazil" for the official's brazilian repository, "brazil2" for the non-official repository provided by Brasil.io, and "world" for the Johns Hopkins University's repository.
#' @return tibble/data.frame containing the downloaded data.
#' @description This function downloads the pandemic COVID-19 data from two different repositories: the official Brazilian's repository mantained by the Brazilian Government (https://covid.saude.gov.br), which contains data of the pandemic in Brazil at country/state/region/city levels, and from the John Hopkins University's repository (https://github.com/CSSEGISandData/COVID-19), which has been widely used all over the world as a reliable source of data information on the COVID-19 pandemic at a global level (countries and territories).
#' @examples
#' \donttest{
#' library(covid19br)
#'
#' # Downloading Brazilian COVID-19 data:
#' brazil <- downloadCovid19(from = "brazil")
#'
#' # Downloading world COVID-19 data:
#' world <- downloadCovid19(from = "world")
#' }
#'
downloadCovid19 <- function(from=c("brazil", "world")){
  from <- match.arg(from)
  mydata <- switch(from,
                   "brazil" = downloadBR(language = "en"),
                   "world" = downloadWorld(language = "en"))
  return(mydata)
}





