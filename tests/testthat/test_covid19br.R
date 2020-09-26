
library(covid19br)

# Downloading Brazilian COVID-19 data:
brazil <- downloadCovid19("brazil")
regions <- downloadCovid19("regions")
states <- downloadCovid19("states")
cities <- downloadCovid19("cities")

# Downloading world COVID-19 data:
world <- downloadCovid19("world")
