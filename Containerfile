FROM ucsb/rstudio-base:latest

LABEL maintainer="LSIT Systems <lsitops@ucsb.edu>"

USER root

RUN mamba install -y -c conda-forge cmdstan && \
    chown -Rf jovyan /opt/conda/bin/cmdstan

RUN R -e "install.packages(c('tidybayes', 'rstanarm', 'coda', 'mvtnorm', 'devtools', 'loo', 'dagitty', 'shape'), repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())" && \
    R -e "devtools::install_github('rmcelreath/rethinking')" 

ENV CMDSTAN /opt/conda/bin/cmdstan

USER $NB_USER

CMD echo "CMDSTAN=/opt/conda/bin/cmdstan\nCMDSTANR_NO_VER_CHECK=TRUE" > ~/.Renviron && "start-notebook.sh"
