
#' City-level georeferenced data
#'
#' @name ibgeCities
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set obtaind from the Instituto Brasileiro de Geografia e Estatística (IBGE) with data on the Brazilian population and geographical information on city level.
#' @format A data frame with 5570 rows and 10 variables:
#' \itemize{
#'   \item region: regions' names
#'   \item state: states' names.
#'   \item city: cities' names.
#'   \item pop: estimated population in 2019.
#'   \item region_code: numerical code attributed to regions
#'   \item state_code: numerical code attributed to states
#'   \item mesoregion_code: numerical code attributed to mesoregions
#'   \item microregion_code: numerical code attributed to microregions
#'   \item city_code: numerical code attributed to cities
#'   \item geometry: georeferenced data needed to plot maps.
#'   \item area: area (in Km^2) of the brazilian cities
#'   \item demoDens: demographic density of the brazilian cities.
#' }
#' @source Instituto Brasileiro de Geografia e Estatística (IBGE):
#'   \itemize{
#'     \item Shapefiles: \url{https://www.ibge.gov.br/geociencias/downloads-geociencias.html}
#'     \item Population: \url{https://www.ibge.gov.br/estatisticas/sociais/populacao/9103-estimativas-de-populacao.html?=&t=resultados}
#'   }
#'
NULL



#' State-level georeferenced data
#' @name ibgeStates
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set obtaind from the Instituto Brasileiro de Geografia e Estatística (IBGE) with data on the Brazilian population and geographical information on state level.
#' @format A data frame with 27 rows and 6 variables:
#' \itemize{
#'   \item region: regions' names
#'   \item state: states' names.
#'   \item pop: estimated population in 2019.
#'   \item region_code: numerical code attributed to regions
#'   \item state_code: numerical code attributed to states
#'   \item geometry: georeferenced data needed to plot maps.
#'   \item area: area (in Km^2) of the brazilian states.
#'   \item demoDens: demographic density of the brazilian states.
#' }
#' @source Instituto Brasileiro de Geografia e Estatística (IBGE):
#'   \itemize{
#'     \item Shapefiles: \url{https://www.ibge.gov.br/geociencias/downloads-geociencias.html}
#'     \item Population: \url{https://www.ibge.gov.br/estatisticas/sociais/populacao/9103-estimativas-de-populacao.html?=&t=resultados}
#'   }
#'
NULL


#' Region-level georeferenced data
#' @name ibgeRegions
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set obtaind from the Instituto Brasileiro de Geografia e Estatística (IBGE) with data on the Brazilian population and geographical information on region level.
#' @format A data frame with 5 rows and 4 variables:
#' \itemize{
#'   \item region: regions' names
#'   \item pop: estimated population in 2019.
#'   \item region_code: numerical code attributed to regions
#'   \item geometry: georeferenced data needed to plot maps.
#'   \item area: area (in Km^2) of the brazilian regions.
#'   \item demoDens: demographic density of the brazilian regions.
#' }
#' @source Instituto Brasileiro de Geografia e Estatística (IBGE):
#'   \itemize{
#'     \item Shapefiles: \url{https://www.ibge.gov.br/geociencias/downloads-geociencias.html}
#'     \item Population: \url{https://www.ibge.gov.br/estatisticas/sociais/populacao/9103-estimativas-de-populacao.html?=&t=resultados}
#'   }
#'
NULL


#' World-level georeferenced data
#' @name mundi
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set extracted from the R package rnaturalearthdata.
#' @format A data frame with 241 rows and 12 variables:
#' \itemize{
#'   \item country: country's name
#'   \item continent: continent's name
#'   \item region: regions' names
#'   \item subregion: subregion's name
#'   \item pop: estimated population
#'   \item pais: country's name in Portuguese
#'   \item country_code: numerical code attributed to countries
#'   \item continent_code: numerical code attributed to continents
#'   \item region_code: numerical code attributed to regions
#'   \item subregion_code: numerical code attributed to subregions
#'   \item geometry: georeferenced data needed to plot maps.
#' }
#' @source R package rnaturalearthdata.
#'
NULL


#' Results of the 2018 presidential election in Brazil by city.
#' @name election2018Cities
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set containing the results of the 2018 presidential election in Brazil.
#' @format A data frame with 5570 rows and 6 variables:
#' \itemize{
#'   \item region: regions' names
#'   \item state: states' names.
#'   \item city: cities' names.
#'   \item region_code: numerical code attributed to regions
#'   \item state_code: numerical code attributed to states
#'   \item mesoregion_code: numerical code attributed to mesoregions
#'   \item microregion_code: numerical code attributed to microregions
#'   \item city_code: numerical code attributed to cities
#'   \item Bolsonaro: count of votes obtained by the President-elected Jair Bolosnaro.
#'   \item Haddad: count of votes obtained by the defeated candidate Fernando Haddad.
#'   \item pop: estimated population in 2019.
#' }
#' @source Tribunal Superior Eleitoral (TSE). URL:  \url{https://www.tse.jus.br/eleicoes/estatisticas}.
#'
NULL


#' Results of the 2018 presidential election in Brazil by state.
#' @name election2018States
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set containing the results of the 2018 presidential election in Brazil.
#' @format A data frame with 27 rows and 5 variables:
#' \itemize{
#'   \item region: regions' names.
#'   \item state: states' names.
#'   \item Bolsonaro: count of votes obtained by the President-elected Jair Bolosnaro.
#'   \item Haddad: count of votes obtained by the defeated candidate Fernando Haddad.
#'   \item pop: estimated population in 2019.
#' }
#' @source Tribunal Superior Eleitoral (TSE). URL:  \url{https://www.tse.jus.br/eleicoes/estatisticas}.
#'
NULL

#' Results of the 2018 presidential election in Brazil by region.
#' @name election2018Regions
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set containing the results of the 2018 presidential election in Brazil.
#' @format A data frame with 5 rows and 4 variables:
#' \itemize{
#'   \item region: regions' names.
#'   \item Bolsonaro: count of votes obtained by the President-elected Jair Bolosnaro.
#'   \item Haddad: count of votes obtained by the defeated candidate Fernando Haddad.
#'   \item pop: estimated population in 2019.
#' }
#' @source Tribunal Superior Eleitoral (TSE). URL:  \url{https://www.tse.jus.br/eleicoes/estatisticas}.
#'
NULL


#' Development human indexes by brazilian regions
#' @name ipeaRegions
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set on the development humam indexes provided the Instituto de Pesquisa Econômica Aplicada in 2010.
#' @format A data frame with 5 rows and 6 variables:
#' \itemize{
#'   \item region: regions' names.
#'   \item DHI: development human index.
#'   \item EDHI: educational development human index.
#'   \item LDHI: longevity development human index.
#'   \item IDHI: income development human index.
#'   \item pop: estimated population in 2019.
#' }
#' @source Instituto de Pesquisa Econômica Aplicada (IPEA). URL: \url{https://www.ipea.gov.br/ipeageo/bases.html}.
#'
NULL


#' Development human indexes by brazilian states
#' @name ipeaStates
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set on the development humam indexes provided the Instituto de Pesquisa Econômica Aplicada in 2010.
#' @format A data frame with 27 rows and 6 variables:
#' \itemize{
#'   \item region: regions' names.
#'   \item state: states' names.
#'   \item DHI: development human index.
#'   \item EDHI: educational development human index.
#'   \item LDHI: longevity development human index.
#'   \item IDHI: income development human index.
#'   \item pop: estimated population in 2019.
#' }
#' @source Instituto de Pesquisa Econômica Aplicada (IPEA). URL: \url{https://www.ipea.gov.br/ipeageo/bases.html}.
#'
NULL

#' Development human indexes by brazilian cities
#' @name ipeaCities
#' @docType data
#' @author Fabio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Data set on the development humam indexes provided the Instituto de Pesquisa Econômica Aplicada in 2010.
#' @format A data frame with 5570 rows and 9 variables:
#' \itemize{
#'   \item region: regions' names.
#'   \item state: states' names.
#'   \item city: states' names.
#'   \item city_code: numerical code attributed to cities
#'   \item DHI: development human index.
#'   \item EDHI: educational development human index.
#'   \item LDHI: longevity development human index.
#'   \item IDHI: income development human index.
#'   \item pop: estimated population in 2019.
#' }
#' @source Instituto de Pesquisa Econômica Aplicada (IPEA). URL: \url{https://www.ipea.gov.br/ipeageo/bases.html}.
#'
NULL
