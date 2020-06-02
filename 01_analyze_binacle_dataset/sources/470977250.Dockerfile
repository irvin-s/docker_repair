####### Dockerfile #######
FROM rocker/tidyverse:3.4.3

RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install \
	libglu1-mesa-dev \
	liblzma-dev \
    libbz2-dev \
    clang  \
    ccache \
    default-jdk \
    default-jre \
    libmagick++-dev \
    && R CMD javareconf \
    && install2.r --error --deps TRUE \
        h2o \
        recipes \
        rsample \
        lime \
        tidyquant
        
    