FROM ucsb/rstudio-base:latest

LABEL maintainer="LSIT Systems <lsitops@ucsb.edu>"

USER root

RUN mamba install -y -c conda-forge cmdstan

RUN R -e "install.packages(c('cmdstanr'), repos = 'https://mc-stan.org/r-packages/', Ncpus = parallel::detectCores())" && \
    R -e "install.packages(c('tidybayes', 'rstanarm', 'coda', 'mvtnorm', 'devtools', 'loo', 'dagitty', 'shape'), repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())" && \
    R -e "devtools::install_github('rmcelreath/rethinking')" 

USER $NB_USER

CMD echo "CMDSTAN=/opt/conda/bin/cmdstan\nCMDSTANR_NO_VER_CHECK=TRUE" > ~/.Renviron && "start-notebook.sh"
