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
usethis::use_github()

usethis::use_readme_rmd()
