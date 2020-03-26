# run docker build -t spira/spira:latest -f ./docker/Dockerfile .

FROM busybox:1.24.1

MAINTAINER "Zak Henry" <zak.henry@gmail.com>

# create data dir
RUN mkdir -p /data

# copy all files to data dir
COPY . /data

# allow data dir to be mounted as volue
VOLUME /data

# set the cwd
WORKDIR /data