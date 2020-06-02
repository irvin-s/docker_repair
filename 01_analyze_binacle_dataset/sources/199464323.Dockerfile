FROM debian:jessie
MAINTAINER GRNET

RUN apt-get update && apt-get install -y --no-install-recommends\
    git \
    vim \
    sudo \
    curl \
    wget \
    build-essential \
    python \
    python-pip \
    uuid-runtime

# Set the locale


#move to /opt
RUN mkdir -p /opt/gitrepo/

# Clone the conf files into the docker container
RUN git clone https://github.com/EUDAT-Training/B2SAFE-B2STAGE-Training.git /opt/gitrepo

# create a folder to move the examples
RUN mkdir -p /opt/curl-examples/

# move examples to curl-examples
RUN mv /opt/gitrepo/PIDS-examples/* /opt/curl-examples/.

# go to curl-examples
WORKDIR /opt/curl-examples

# wget the file that we use in our examples
RUN wget https://ndownloader.figshare.com/files/2292172 -O surveys.csv

