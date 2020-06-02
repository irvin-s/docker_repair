FROM ubuntu:14.04
ENV HOME /root

### PACKAGE MANAGER ###########################################################
###############################################################################

RUN apt-get update

### TOOLS #####################################################################
###############################################################################

RUN apt-get install -y \
    build-essential \
    curl \
    gcc \
    git \
    git-core \
    make \
    nano \
    python-software-properties \
    software-properties-common