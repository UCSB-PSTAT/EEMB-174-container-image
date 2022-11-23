FROM ucsb/rstudio-base:latest

LABEL maintainer="LSIT Systems <lsitops@ucsb.edu>"

USER root

RUN R -e "install.packages(c('rstanarm', 'tidybayes'), repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())" \
    R -e "install.packages('cmdstanr', repos = c('https://mc-stan.org/r-packages/', getOption('repos'), Ncpus = parallel::detectCores()))" \
    R -e "install.packages(c('coda','mvtnorm','devtools','loo','dagitty','shape'))" \
    R -e "devtools::install_github('rmcelreath/rethinking')"

USER $NB_USER

