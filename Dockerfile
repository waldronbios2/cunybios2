FROM rocker/tidyverse:latest
WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/

RUN apt-get update --fix-missing && apt-get install -yq libssl-dev libpng-dev libnetcdf-dev libxml2-dev libxt6 libharfbuzz-dev libfribidi-dev libv8-dev

## install R package and session dependencies

RUN Rscript -e "install.packages(c('devtools', 'remotes', 'kableExtra', 'pkgdown'), ask=FALSE, Ncpus=max(1, parallel::detectCores(), na.rm=TRUE))"
RUN Rscript -e "for (dir in list.dirs(path='.', recursive=FALSE)) if (file.exists(file.path(dir, 'DESCRIPTION')) && dir != '.') remotes::install_local(dir, dependencies=TRUE)"
RUN Rscript -e "remotes::install_local('.', dependencies=TRUE)"

RUN chown -R rstudio:rstudio /home/rstudio
