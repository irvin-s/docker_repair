FROM phusion/baseimage:0.9.13

MAINTAINER Guilherme Rezende <guilhermebr@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root


RUN apt-get update && apt-get install -y --no-install-recommends\
	build-essential python-dev curl python-pycurl python-pip \
	python-numpy python-opencv webp libpng-dev libtiff-dev libjasper-dev libjpeg-dev \
	libdc1394-22-dev libdc1394-22 libdc1394-utils \
	gifsicle libgif-dev \

	&& rm -rf /var/lib/apt/lists/*

RUN pip install thumbor
#RUN pip install opencv-engine

ADD thumbor.conf /root/thumbor.conf

EXPOSE 8880

ENTRYPOINT ["/usr/local/bin/thumbor"]

CMD ["--port=8880", "-c", "/root/thumbor.conf"]
