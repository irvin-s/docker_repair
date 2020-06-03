FROM base/archlinux
MAINTAINER David Harper (david@pandastrike.com)
#===============================================================================
# Elasticsearch
#===============================================================================
# This Dockerfile describes a the datastore service elasticsearch.  The official
# Elasticsearch container does not have versioning, so we're going to do a little
# work and use Version 1.4.2

RUN pacman -Syu --noconfirm
RUN pacman-db-upgrade
RUN pacman -S --noconfirm jre7-openjdk-headless wget vim tmux

# Install Elasticsearch 1.4.2
RUN mkdir downloads && cd downloads && \
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.2.tar.gz && \
tar -xvf elasticsearch-1.4.2.tar.gz && \
mv elasticsearch-1.4.2 ~/.

# Clean up the download directory.
RUN rm -rf downloads
