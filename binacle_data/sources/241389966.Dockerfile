FROM ubuntu:16.04

MAINTAINER Jeremy Likness <jeremy@jeremylikness.com>

# Seed an image with the source USDA data files for import into Mongo DB

# update environment and ensure wget is there 
RUN apt-get update \
    && apt-get install -y wget \
    && mkdir -p /seed 

COPY ./seed.sh /seed/

COPY ./data/sr28.tar.gz /seed/

WORKDIR /seed 

# change permissions, unzip it, copy over the seed file and 
# strip out unwanted Windows characters if on a Windows system

RUN chmod 777 ./sr28.tar.gz \ 
    && tar -xzvf ./sr28.tar.gz \
    && chmod 777 ./seed.sh \
    && sed -i 's/\r//g' ./seed.sh \
    && rm ./sr28.tar.gz

# expose for importing into Mongo 

VOLUME /seed
