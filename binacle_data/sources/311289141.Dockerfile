# Copyright 2018 Víctor Mayoral Vilches - All Rights Reserved
#
# Unauthorized copying of this file, via any medium is strictly prohibited

# Default, 64 bit image
#FROM ubuntu:16.04 #

# 32 bit image
FROM i686/ubuntu

#--------------------
# General setup
#--------------------
# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /root
RUN apt-get update
RUN apt-get install -y binutils \
    gcc gdb

# Utilities for the hack
RUN apt-get install -y vim \
  less python3 wget bsdmainutils

#--------------------
# Set up proper (comfortable) gdb environment
#--------------------
RUN wget -P ~ git.io/.gdbinit

#--------------------
# Copy source files
#--------------------
COPY overflow.c /root

#--------------------
# Compile code
#--------------------
RUN gcc overflow.c -g -o overflow
# Compile without tricks to avoid overflows
# RUN gcc overflow.c -g -o overflow -fno-stack-protector -z execstack

#--------------------
# Entry point
#--------------------
CMD ["bash"]
