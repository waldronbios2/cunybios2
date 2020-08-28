FROM rocker/verse:3.6.3
WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/

RUN apt-get update --fix-missing && apt-get install -yq libssl-dev libpng-dev libnetcdf-dev libxml2-dev

RUN git submodule init
RUN git submodule update


RUN Rscript -e "install.packages('devtools', ask=FALSE, Ncpus=max(1, parallel::detectCores(), na.rm=TRUE))"
RUN Rscript -e "devtools::install('.', dependencies=TRUE, build_vignettes=FALSE, Ncpus=max(1, parallel::detectCores(), na.rm=TRUE))"
