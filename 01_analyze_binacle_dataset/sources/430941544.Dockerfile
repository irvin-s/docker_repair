##
## hepsw/alice-base
## A container where all dependencies for FairRoot development are
## installed.
##
FROM ubuntu
MAINTAINER Sebastien Binet "binet@cern.ch"

USER root
ENV USER root
ENV HOME /root
ENV PYTHONSTARTUP=$HOME/.pythonrc.py
ENV SIMPATH=/opt/alice/sw/externals
ENV PATH=$SIMPATH/bin:$PATH
ENV LD_LIBRARY_PATH=$SIMPATH/lib:$LD_LIBRARY_PATH
ENV CUBIED_VERSION=20160205

RUN apt-get update -y && \
	apt-get install -y \
	 cmake cmake-data curl g++ gcc gfortran \
	 build-essential make patch sed \
	 libcurl4-openssl-dev \
	 libx11-dev libxft-dev \
	 libxext-dev libxpm-dev libxmu-dev libglu1-mesa-dev \
	 libgl1-mesa-dev ncurses-dev curl bzip2 gzip unzip tar \
	 subversion git xutils-dev flex bison lsb-release \
	 python-dev libxml2-dev wget libssl-dev

RUN mkdir -p /opt/alice
WORKDIR /opt/alice

RUN mkdir -p          /build/build-fair/
ADD fair-config.cache /build/fair-config.cache

RUN git clone git://github.com/FairRootGroup/FairSoft /build/fair-soft && \
	cd /build/fair-soft && \
	./configure.sh /build/fair-config.cache && \
	/bin/rm -rf /build


ADD https://github.com/hepsw/cubie/releases/download/${CUBIED_VERSION}/cubied /usr/bin/cubied
ADD dot-pythonrc.py         $HOME/.pythonrc.py

RUN chmod +x /usr/bin/cubied

## make the whole container seamlessly executable
ENTRYPOINT ["/usr/bin/cubied"]
CMD ["bash"]

## EOF

