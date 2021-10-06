
library(covid19br)

# Downloading Brazilian COVID-19 data:
brazil <- downloadCovid19("brazil")
regions <- downloadCovid19("regions")
states <- downloadCovid19("states")
cities <- downloadCovid19("cities")

# Downloading world COVID-19 data:
world <- downloadCovid19("world")



# adding the geometry to the data:
regions_geo <- regions %>%
  filter(date == max(date)) %>%
  add_geo()

states_geo <- states %>%
  filter(date == max(date)) %>%
  add_geo()

cities_geo <- cities %>%
  filter(date == max(date)) %>%
  add_geo()

world_geo <- world %>%
  filter(date == max(date)) %>%
  add_geo()


