
#' City-level georeferenced data
#'
#' @name geocities
#' @aliases geocities
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set obtaind from the Instituto Brasileiro de Geografia e Estatística (IBGE) with data on the Brazilian population and geographical information on city level.
#' @details The development human index (DHI) variables are available at city level, and their average are computed for state and region levels.
#'
#' @format A data frame with 5570 rows and 16 variables:
#' \itemize{
#'   \item region: regions' names
#'   \item state: states' names.
#'   \item city: cities' names.
#'   \item DHI: development human index.
#'   \item EDHI: educational development human index.
#'   \item LDHI: longevity development human index.
#'   \item IDHI: income development human index.
#'   \item pop: estimated population in 2019.
#'   \item region_code: numerical code attributed to regions
#'   \item state_code: numerical code attributed to states
#'   \item mesoregion_code: numerical code attributed to mesoregions
#'   \item microregion_code: numerical code attributed to microregions
#'   \item city_code: numerical code attributed to cities
#'   \item geometry: georeferenced data needed to plot maps.
#'   \item area: area (in Km^2)
#'   \item pop_dens: demographic density.
#' }
#' @source
#'   \itemize{
#'     \item Shapefiles for Brazilian maps: \url{https://www.ibge.gov.br/geociencias/downloads-geociencias.html}
#'     \item Brazilian DHI data: \url{https://www.ipea.gov.br/ipeageo/bases.html}
#'   }
#'
NULL


#' State-level georeferenced data
#'
#' @name geostates
#' @aliases geostates
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set obtaind from the Instituto Brasileiro de Geografia e Estatística (IBGE) with data on the Brazilian population and geographical information on state level.
#' @details The development human index (DHI) variables are available at city level, and their average are computed for state and region levels.
#'
#' @format A data frame with 27 rows and 12 variables:
#' \itemize{
#'   \item region: regions' names
#'   \item state: states' names.
#'   \item DHI: development human index.
#'   \item EDHI: educational development human index.
#'   \item LDHI: longevity development human index.
#'   \item IDHI: income development human index.
#'   \item pop: estimated population in 2019.
#'   \item region_code: numerical code attributed to regions
#'   \item state_code: numerical code attributed to states
#'   \item geometry: georeferenced data needed to plot maps.
#'   \item area: area (in Km^2)
#'   \item pop_dens: demographic density.
#' }
#' @source
#'   \itemize{
#'     \item Shapefiles for Brazilian maps: \url{https://www.ibge.gov.br/geociencias/downloads-geociencias.html}
#'     \item Brazilian DHI data: \url{https://www.ipea.gov.br/ipeageo/bases.html}
#'   }
#'
NULL

#' Region-level georeferenced data
#'
#' @name georegions
#' @aliases georegions
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set obtaind from the Instituto Brasileiro de Geografia e Estatística (IBGE) with data on the Brazilian population and geographical information on region level.
#' @details The development human index (DHI) variables are available at city level, and their average are computed for state and region levels.
#'
#' @format A data frame with 5 rows and 10 variables:
#' \itemize{
#'   \item region: regions' names
#'   \item DHI: development human index.
#'   \item EDHI: educational development human index.
#'   \item LDHI: longevity development human index.
#'   \item IDHI: income development human index.
#'   \item pop: estimated population in 2019.
#'   \item region_code: numerical code attributed to regions
#'   \item geometry: georeferenced data needed to plot maps.
#'   \item area: area (in Km^2)
#'   \item pop_dens: demographic density.
#' }
#' @source
#'   \itemize{
#'     \item Shapefiles for Brazilian maps: \url{https://www.ibge.gov.br/geociencias/downloads-geociencias.html}
#'     \item Brazilian DHI data: \url{https://www.ipea.gov.br/ipeageo/bases.html}
#'   }
#'
NULL

#' World-level georeferenced data
#'
#' @name geoworld
#' @aliases geoworld
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set containing the world population and geographical information on country level.
#'
#' @format A data frame with 241 rows and 11 variables:
#' \itemize{
#'   \item country: country's name.
#'   \item continent: continent's name.
#'   \item region: regions' names.
#'   \item subregion: subregion's name.
#'   \item pop: estimated population.
#'   \item pais: country's name in Portuguese.
#'   \item country_code: numerical code attributed to countries.
#'   \item continent_code: numerical code attributed to continents.
#'   \item region_code: numerical code attributed to regions.
#'   \item subregion_code: numerical code attributed to subregions.
#'   \item geometry: georeferenced data needed to plot maps.
#' }
#' @source
#'   \itemize{
#'     \item World map: \url{https://CRAN.R-project.org/package=rnaturalearthdata}
#'   }
#'
NULL

