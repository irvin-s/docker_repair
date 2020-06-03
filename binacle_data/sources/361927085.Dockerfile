# This builds a Docker image that has new-enough versions of Maven, Java, and 
# nodeJS needed to build Singularity (as of 0.15.1)

FROM debian:stretch-slim

RUN mkdir -p /usr/share/man/man1/ && \
 apt-get update && apt-get -y install openjdk-8-jdk-headless && \
 apt-get -y install maven nodejs git-core vim-nox
