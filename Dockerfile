FROM rocker/rstudio

WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/

RUN Rscript -e "devtools::install('.', dependencies=TRUE, build_vignettes=FALSE)"
