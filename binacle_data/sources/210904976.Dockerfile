FROM rocker/tidyverse
MAINTAINER Mark Dunning<mark.dunning@cruk.cam.ac.uk>
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update 
RUN apt-get install --fix-missing -y git
###Get repository of the course. 
RUN mkdir -p /home/participant/
RUN git clone https://github.com/bioinformatics-core-shared-training/r-intermediate /home/participant/Course_Materials
## Install data and R packages
RUN R -e 'install.packages(c("rmarkdown","cowplot"))'
## Remove solutions
RUN rm /home/participant/Course_Materials/*-solutions.*
RUN cp -r /home/participant/Course_Materials/* /home/rstudio
