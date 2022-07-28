# Arquivo modelo


# Rotulo de seção ---------------------------------------------------------

1+1

# Utilidades --------------------------------------------------------------

# ctrl+shift+c
# install.packages("devtools")
# install.packages("usethis")
# install.packages("tidyverse")

# iniciando o git ---------------------------------------------------------

library("usethis")

usethis::use_git()
usethis::create_github_token()
usethis::use_github(private = TRUE)

usethis::use_readme_rmd()


#Licença
usethis::use_mit_license()
