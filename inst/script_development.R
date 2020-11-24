

usethis::use_build_ignore("inst/script_development.R")
usethis::use_git_ignore("inst/script_development.R")
usethis::use_build_ignore("data")
usethis::use_build_ignore("R/data_doc.R")
#usethis::use_travis()

#-------------------------------------------------------------------------------
# construindo o pacote:
devtools::document()
devtools::install()
devtools::load_all()

devtools::build_manual()
devtools::build()


#-------------------------------------------------------------------------------
# verificando o pacote:

devtools::check()
devtools::check_win_devel()
devtools::check_win_release()
devtools::test()

devtools::check_rhub(email = "fndemarqui@gmail.com")
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
