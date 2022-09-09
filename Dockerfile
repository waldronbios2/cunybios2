FROM rocker/tidyverse:4.0.2
WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/

RUN apt-get update --fix-missing && apt-get install -yq libssl-dev libpng-dev libnetcdf-dev libxml2-dev libxt6 libharfbuzz-dev libfribidi-dev libv8-dev 

## install R package and dependencies

RUN Rscript -e "install.packages('devtools', ask=FALSE, Ncpus=max(1, parallel::detectCores(), na.rm=TRUE))"
RUN Rscript -e "devtools::install('.', dependencies=TRUE, build_vignettes=FALSE)"

RUN chown -R rstudio:rstudio /home/rstudio
