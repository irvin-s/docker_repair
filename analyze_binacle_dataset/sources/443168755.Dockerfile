# Dockerfile for python 
# Version 1.0
FROM lukaspustina/docker_network_demo_base

MAINTAINER Lukas Pustina <lukas.pustina@codecentric.de>

RUN apt-get install -y python python-pymongo

