FROM ubuntu:18.04

#
# Install anything needed in the system
#
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y git python3-minimal python3-pip
