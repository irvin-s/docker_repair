FROM microsoft/dotnet:aspnetcore-runtime AS build-kaldi

ENV CPU_CORE 4

RUN \
  apt-get update -qq && \
  apt-get install -y \
    git bzip2 wget \
    g++ make python python3 \
    zlib1g-dev automake autoconf libtool subversion \
    libatlas-base-dev patch sox


WORKDIR /usr/local/
# Use the modified kaldi
RUN git clone https://github.com/hanayashiki/kaldi.git


WORKDIR /usr/local/kaldi/tools
RUN extras/check_dependencies.sh
RUN make -j $CPU_CORE

WORKDIR /usr/local/kaldi/src
RUN ./configure && make depend -j $CPU_CORE && make -j $CPU_CORE

# Fetch changes, avoid rebuild the whole kaldi 
RUN git pull
WORKDIR /usr/local/kaldi/src/online2
RUN make

RUN apt-get install -y tree vim


# Install redis
RUN mkdir /root/tools
WORKDIR /root/tools
RUN wget http://download.redis.io/redis-stable.tar.gz && \
	tar xvzf redis-stable.tar.gz && \
	cd redis-stable && \
	make && make install 

# Install libevent
RUN apt-get install -y libtool
WORKDIR /root/tools
RUN git clone https://github.com/libevent/libevent.git
WORKDIR /root/tools/libevent
RUN ./autogen.sh && ./configure && make && make install

# Install libbson
WORKDIR /root/tools
RUN git clone https://github.com/mongodb/libbson.git
WORKDIR /root/tools/libbson
RUN ./autogen.sh && make && make install

# Install hiredis
WORKDIR /root/tools
RUN git clone https://github.com/redis/hiredis.git 
RUN cd hiredis && make && make install 

# Install Python3 deps for APITest
RUN apt-get install -y python3-pip
RUN pip3 install requests gevent

# Build dotnet app
FROM microsoft/dotnet:sdk AS build-env

RUN apt-get update && apt-get install -y tree

# Copy everything
WORKDIR /app		

RUN mkdir Service Core CoreRun 
COPY Service Service/
COPY Core Core/

# To make dotnet happy
COPY CoreRun CoreRun/  
COPY SRService.sln .

# Build web interface
RUN dotnet publish
# RUN echo "\n####Build results: ####" && tree . 

# Go back to where we build kaldi
FROM build-kaldi

# Build decoder

WORKDIR /app

COPY --from=build-env /app .

RUN mkdir Kaldi APITest

COPY Kaldi/ /app/Kaldi/
WORKDIR /app/Kaldi
RUN make kaldi-service

WORKDIR /app

COPY *.sh ./
COPY Makefile ./
COPY APITest APITest/
COPY KaldiConf KaldiConf/
COPY ServiceConf ServiceConf/

RUN chmod +x ./init.sh


