## Launch an R terminal: docker run -it cboettig/pdg_control /usr/bin/R
## Launch via RStudio: docker run -d -p 8787:8787 cboettig/pdg_control
##   and then navigate to http://localhost:8787 

FROM rocker/hadleyverse
MAINTAINER Carl Boettiger cboettig@ropensci.org

## Remain current & install binaries for dependencies that don't compile
RUN apt-get update \ 
  && apt-get install -y r-cran-snowfall r-cran-expm latexdiff texlive-generic-recommended

## Install package, with dependencies and suggests
RUN installGithub.r --deps TRUE \ 
  cboettig/cboettigR \
  jrnold/ggthemes \ 
  cboettig/pdg_control

