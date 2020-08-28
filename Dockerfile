FROM rocker/rstudio

WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/

RUN apt-get update --fix-missing && apt-get install -yq libssl-dev libpng-dev libnetcdf-dev libxml2-dev

RUN Rscript -e "devtools::install('.', dependencies=TRUE, build_vignettes=FALSE)"
