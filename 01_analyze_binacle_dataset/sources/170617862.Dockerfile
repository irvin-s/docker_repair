# This file is part of Miasm2-Docker.
# Copyright 2014 Camille MOUGEY <commial@gmail.com>
#
# Miasm2-Docker is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Miasm2-Docker is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
# License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Miasm2-Docker. If not, see <http://www.gnu.org/licenses/>.

FROM debian:jessie
MAINTAINER Camille Mougey <commial@gmail.com>

# Download needed packages
RUN apt-get -qq update && \
    apt-get -qqy install python2.7 git make gcc g++ libpython2.7-dev python-pyparsing python-llvm unzip

# TCC release 0.9.26
RUN cd /opt && \
    git clone http://repo.or.cz/tinycc.git tinycc && \
    cd tinycc && \
    git checkout d5e22108a0dc48899e44a158f91d5b3215eb7fe6 && \
    ./configure --disable-static && \
    make && \
    make install && \
    make clean

# Elfesteem
ADD https://github.com/serpilliere/elfesteem/archive/master.zip /opt/elfesteem.zip
RUN cd /opt && \
    unzip elfesteem.zip && \
    mv elfesteem-master elfesteem && \
    cd elfesteem && \
    python setup.py install && \
    rm -rf /opt/elfesteem.zip

# Get miasm2
ADD https://github.com/cea-sec/miasm/archive/master.zip /opt/miasm-master.zip
RUN cd /opt && \
    unzip miasm-master.zip && \
    mv miasm-master miasm2 && \
    cd miasm2 && \
    python setup.py install && \
    rm -rf /opt/miasm-master.zip

# Get z3
ADD http://download-codeplex.sec.s-msft.com/Download/SourceControlFileDownload.ashx?ProjectName=z3&changeSetId=cee7dd39444c9060186df79c2a2c7f8845de415b /opt/z3.zip
RUN cd /opt && \
    mkdir z3 && cd z3 && \
    unzip -q ../z3.zip && python scripts/mk_make.py && cd build && make -j 4 && make install && \
    rm /opt/z3.zip

# Clean
RUN apt-get -qq remove --purge make git unzip && \
    apt-get -qq autoremove --purge && \
    apt-get -qq clean

# Set user
RUN useradd miasm2 && \
    chown -Rh miasm2 /opt/miasm2
USER miasm2

# Default cmd
WORKDIR /opt/miasm2/test
CMD ["/usr/bin/python", "test_all.py", "-m"]
