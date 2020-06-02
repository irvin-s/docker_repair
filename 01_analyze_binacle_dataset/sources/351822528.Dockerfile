# This is the base image for all AndroLyze containers

FROM phusion/baseimage:latest
MAINTAINER Nils Schmidt <schmidt89@informatik.uni-marburg.de>

ENV ANDROLYZE_UTIL_DIR /etc/androlyze_util/
ENV ANDROLYZE_UTIL $ANDROLYZE_UTIL_DIR/docker_util.sh

# Shell script with base functionality for all other containers
ADD docker_util.sh $ANDROLYZE_UTIL