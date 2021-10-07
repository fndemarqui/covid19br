
library(covid19br)
library(dplyr)

# Downloading Brazilian COVID-19 data:
brazil <- downloadCovid19("brazil")
regions <- downloadCovid19("regions")
states <- downloadCovid19("states")
cities <- downloadCovid19("cities")

# Downloading world COVID-19 data:
world <- downloadCovid19("world")



# adding the geometry/epidemiological rates to the downloaded data:
regions_geo <- regions %>%
  filter(date == max(date)) %>%
  add_geo() %>%
  add_epi_rates()

states_geo <- states %>%
  filter(date == max(date)) %>%
  add_geo() %>%
  add_epi_rates()

cities_geo <- cities %>%
  filter(date == max(date)) %>%
  add_geo() %>%
  add_epi_rates()

world_geo <- world %>%
  filter(date == max(date)) %>%
  add_geo() %>%
  add_epi_rates()


