FROM gcr.io/tensorflow/tensorflow:latest-gpu
MAINTAINER Akshay Bhat <akshayubhat@gmail.com>

RUN add-apt-repository ppa:kirillshkrogalev/ffmpeg-next && \
    apt-get update && apt-get install -y protobuf-compiler \
    python-scipy \
    libblas-dev \
    liblapack-dev \
    libatlas-base-dev \
    gfortran \
    ffmpeg && \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip \
                          fabric \
                          jinja \
                          jinja2 \
                          markdown \
                          raven \
                          fabric \
                          awscli \
                          nearpy \
                          flask \
                          ipython \
                          jupyter \
                          requests \
                          boto3 \
                          protobuf \
                          humanize
RUN apt-get update && apt-get install -y git \
    unzip \
    && \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*
USER root
ARG CACHE_DATE=not_a_date
RUN git clone https://github.com/akshayubhat/VisualSearchServer /root/VS
WORKDIR "/root/VS"
EXPOSE 9000
