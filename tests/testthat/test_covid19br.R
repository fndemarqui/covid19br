
library(covid19br)
library(dplyr)


brazil <- downloadCovid19("brazil")
regions <- downloadCovid19("regions")
states <- downloadCovid19("states")
cities <- downloadCovid19("cities")
world <- downloadCovid19("world")



# adding the geometry/epidemiological rates to the data:
#regions <- readRDS("regions.rds")
regions_geo <- regions %>%
  filter(date == max(date)) %>%
  add_geo() %>%
  add_epi_rates()

#states <- readRDS("states.rds")
states_geo <- states %>%
  filter(date == max(date)) %>%
  add_geo() %>%
  add_epi_rates()

#cities <- readRDS("cities.rds")
cities_geo <- cities %>%
  filter(date == max(date)) %>%
  add_geo() %>%
  add_epi_rates()

world_geo <- world %>%
  filter(date == max(date)) %>%
  add_geo() %>%
  add_epi_rates()


