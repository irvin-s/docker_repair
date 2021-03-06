## Start with the ropensci image, and put our check code inline
FROM rocker/ropensci
MAINTAINER Matt Jones jones@nceas.ucsb.edu

RUN apt-get update && \
    apt-get install -y xvfb xauth xfonts-base

# Copy check script into the container
COPY docker /root

CMD pwd
