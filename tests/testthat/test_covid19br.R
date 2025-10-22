
library(covid19br)
library(dplyr)


brazil <- downloadCovid19("brazil")
regions <- downloadCovid19("regions")
states <- downloadCovid19("states")
cities <- downloadCovid19("cities")
world <- downloadCovid19("world")



# adding the geometry/epidemiological rates to the data:

if(nrow(regions)>0){
  regions_geo <- regions %>%
    filter(date == max(date)) %>%
    add_geo() %>%
    add_epi_rates()
}

if(nrow(states)>0){
states_geo <- states %>%
  filter(date == max(date)) %>%
  add_geo() %>%
  add_epi_rates()
}

if(nrow(cities)>0){
cities_geo <- cities %>%
  filter(date == max(date)) %>%
  add_geo() %>%
  add_epi_rates()
}

if(nrow(world)>0){
world_geo <- world %>%
  filter(date == max(date)) %>%
  add_geo() %>%
  add_epi_rates()
}

