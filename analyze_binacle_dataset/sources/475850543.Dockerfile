
##############################################################################
#
#  Copyright (C) 2011-2018 Dr Adam S. Candy and others.
#  
#  Shingle:  An approach and software library for the generation of
#            boundary representation from arbitrary geophysical fields
#            and initialisation for anisotropic, unstructured meshing.
#  
#            Web: http://www.shingleproject.org
#  
#            Contact: Dr Adam S. Candy, contact@shingleproject.org
#  
#  This file is part of the Shingle project.
#  
#  Please see the AUTHORS file in the main source directory for a full list
#  of contributors.
#  
#  Shingle is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  
#  Shingle is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Lesser General Public License for more details.
#  
#  You should have received a copy of the GNU Lesser General Public License
#  along with Shingle. If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################

# DockerFile for a Shingle development container

# Use a Bionic base image
FROM ubuntu:bionic

# This DockerFile is looked after by
MAINTAINER Adam Candy <contact@shingleproject.org>

# Repository variables from the parent environment
ARG repo="shingleproject/Shingle"
ARG branch="master"

# Install required packages
#   Fix for non-interactive tzdata install
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
        git \
        gcc \
        g++ \
        build-essential \
        libnetcdf-dev \
        netcdf-bin \
        python-setuptools \
        python-dev \
        python-pip \
        python-scipy \
        python-numpy \
        python-matplotlib \
        python-shapely \
        python-pyproj \
        python-gdal \
        gdal-bin \
        python-pil \
        gmsh \
        python-py \
        python-netcdf4 \
        libgeos-c1v5 \
        libgeos-3.6.2 \
        libgeos-dev \
        wget

# Upgrade pip
RUN pip install -i https://pypi.python.org/simple/ --upgrade pip setuptools

# Install ScientificPython
RUN pip install --force-reinstall --ignore-installed --no-binary --no-cache-dir --no-binary :all: ScientificPython

# Update dap and shapely with recent versions
RUN pip install Pydap==3.2.1
RUN pip install -U geos
RUN pip install --no-binary :all: Shapely==1.5.9

# Set build compiler environment
ENV CC=gcc

# Add a user
RUN adduser --disabled-password --gecos "" shingle
USER shingle
WORKDIR /home/shingle

# Make a copy of the project Shingle
RUN git clone --depth=50 --branch="$branch" "https://github.com/${repo}" Shingle
WORKDIR /home/shingle/Shingle
#RUN git pull

ENV PATH /home/shingle/Shingle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN make

