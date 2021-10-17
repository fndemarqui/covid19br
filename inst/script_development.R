
usethis::use_build_ignore(".Rhistory")
usethis::use_build_ignore("inst/script_development.R")
usethis::use_git_ignore("inst/script_development.R")
# usethis::use_build_ignore("doc")
#usethis::use_build_ignore("docs")
# usethis::use_build_ignore("data")
# usethis::use_build_ignore("R/data_doc.R")
#usethis::use_travis()

#-------------------------------------------------------------------------------

## rodar apenas uma vez:
# usethis::use_agpl3_license()
# usethis::use_readme_rmd()
# usethis::use_pkgdown()
# usethis::use_vignette("covid19br", "Introduction to the covid19br package")



# construindo o pacote:

roxygen2::roxygenize()
devtools::install()
devtools::load_all()
devtools::document(roclets = c('rd', 'collate', 'namespace'))


devtools::build_vignettes()
devtools::build_readme()
devtools::build_site()
usethis::use_github_action("pkgdown")


devtools::build_manual()
devtools::build()

# IDH 2010
# https://www.ipea.gov.br/ipeageo/bases.html

#-------------------------------------------------------------------------------
# verificando o pacote:

devtools::check()
devtools::check_win_devel()
devtools::check_win_release()
rhub::check_for_cran()
devtools::test()

# previous_checks <- rhub::list_package_checks(email = "fndemarqui@est.ufmg.br")
# previous_checks



devtools::check_rhub(email = "fndemarqui@est.ufmg.br")
devtools::release_checks()
devtools::spell_check()

devtools::submit_cran()

# depois de subir para o CRAN:
usethis::use_github_release()

# # …or push an existing repository from the command line
# git remote add origin https://github.com/fndemarqui/covid19br.git
# git branch -M master
# git push -u origin master
#
# git config --global user.email "fndemarqui@gmail.com"
# git config --global user.name "fndemarqui"
#
#
# # para adicionar tudo
# git add .
#
# # para comitar
# git commit -m "adicao do banco capacidade"
#
# # para subir:
# git push
