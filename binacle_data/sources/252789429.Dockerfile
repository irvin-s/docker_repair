### Base Image  
FROM openjdk:8  
MAINTAINER Dan Leehr "dan.leehr@duke.edu"  
ENV DEBIAN_FRONTEND noninteractive  
  
# GATK is not licesnsed for redistribution, but requires Java and R  
RUN apt-get update && apt-get install -y r-base \  
r-base-dev \  
r-cran-ggplot2 \  
r-cran-gplots \  
r-cran-reshape  
  
# Install gsalib utility functions into R  
ENV GSALIB_URL=https://cran.r-project.org/src/contrib  
ENV GSALIB_FILE=gsalib_2.1.tar.gz  
RUN curl -SLo /tmp/${GSALIB_FILE} ${GSALIB_URL}/${GSALIB_FILE} && \  
R CMD INSTALL /tmp/${GSALIB_FILE} && \  
rm /tmp/${GSALIB_FILE}  

