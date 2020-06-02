FROM rocker/r-base:latest  
  
RUN apt-get update && apt-get install -y r-cran-rjava  
RUN apt-get update && apt-get install -y default-jdk

