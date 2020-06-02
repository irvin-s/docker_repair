FROM andrewosh/binder-base

MAINTAINER Andrew Osheroff <andrewosh@gmail.com>

USER root

RUN apt-get update

USER main

ADD bad_file.txt ~/location

