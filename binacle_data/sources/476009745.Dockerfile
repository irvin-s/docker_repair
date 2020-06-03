# get the base image, this one has R, RStudio and pandoc
FROM rocker/verse:3.3.2

# required
MAINTAINER Ben Marwick <benmarwick@gmail.com>

COPY . /mjb1989excavationpaper 

 # go into the repo directory
RUN   apt-get update \
  && sudo apt-get install r-cran-rjags -y \
  
  && . /etc/environment \ 
  
  # build this compendium package, get deps from MRAN
  # set date here manually
  && R -e "options(repos='https://mran.microsoft.com/snapshot/2016-11-30'); devtools::install('/mjb1989excavationpaper', dep=TRUE)" \

 # render the manuscript into a docx
  && R -e "rmarkdown::render('/mjb1989excavationpaper/vignettes/analysis-of-dates-lithics-shell-from-1989-excavations.Rmd')"




# Get my package source files from github and download onto Docker. The built package that we already got above is no good because it doesn't have the vignette directory in the same structure as the package source
RUN git clone https://github.com/benmarwick/1989-excavation-report-Madjebebe.git  


# to build this image:
# docker build -t benmarwick/mjb1989excavationpaper https://raw.githubusercontent.com/benmarwick/1989-excavation-report-Madjebebe/master/Dockerfile

# to run this container:
# docker -dp 8787:8787 benmarwick/mjb1989excavationpaper
# then open broswer at localhost:8787 or http://192.168.59.103:8787/

