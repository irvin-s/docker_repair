# Use this docker-compose.yml file to start services.
# https://github.com/johndpope/DockerParseyAPI

# https://github.com/tensorflow/tensorflow/tree/master/tensorflow/tools/docker
# https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/docker/Dockerfile.devel
# https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/docker/Dockerfile.devel-gpu


FROM gcr.io/tensorflow/tensorflow:latest-devel

ENV SYNTAXNETDIR=/work/serving/tensorflow PATH=$PATH:/root/bin

#https://tensorflow.github.io/serving/setup
RUN apt-get update && apt-get install -y \
        build-essential \
        curl \
        git \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        libcurl3-dev \
        #libgrpc-dev \
        pkg-config \
        python-dev \
        python-numpy \
        python-pip \
        software-properties-common \
        swig \
        wget \
        zip \
        zlib1g-dev

RUN  wget https://gist.githubusercontent.com/johndpope/fc1c2327a4ae255d9c44dda9b67b5288/raw/406369ecc157d60f7a9bac2a0d5be3da9aa62e56/parseyapi.sh \
    && chmod +x parseyapi.sh \
    && ./parseyapi.sh 
    

EXPOSE 9000
RUN find / -name "parsey_api" -size +512k -exec cp -t "{}" /work/serving \;
RUN cd /work/serving
WORKDIR /work/serving
CMD ["/bin/bash"]


# COMMANDS to build and run API Server
# ===============================
# from root run
# make start
#

