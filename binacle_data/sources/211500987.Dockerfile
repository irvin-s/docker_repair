FROM ubuntu:latest
MAINTAINER Ata Mahjoubfar <atamahjoubfar@gmail.com>
LABEL Description="This image is an ubuntu distribution of Linux with some handy utilities" \
      Vendor="Home" \
      Version="0.3"

RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get -y install mongodb
RUN apt-get -y install python3
RUN apt-get -y install build-essential
RUN apt-get -y install nodejs

# RUN vs CMD:
RUN echo '++++++++++++++++ RUN runs when `docker build` is used. ++++++++++++++++' && bash
CMD echo '++++++++++++++++ CMD runs when `docker run` is used. ++++++++++++++++' && bash
# Only the last CMD instruction in a Dockerfile works, so I had to run bash in the same instruction to be able to use `docker run -it` with this image later.
