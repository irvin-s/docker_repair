FROM socrata/base

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python python-dev python-pip

# Add locale profiles and default to en_US.UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

# LABEL must be last for proper base image discoverability
LABEL repository.socrata/python=""
