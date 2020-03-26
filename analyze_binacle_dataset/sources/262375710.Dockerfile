# Pull base image.
FROM ubuntu:16.04
MAINTAINER Deokhyun Ko "mainto@gmail.com"

# Install.
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y qemu
RUN rm -rf /var/lib/apt/lists/*

# Add files.
RUN mkdir -p /macos
ADD boot.sh macos/
ADD boot-install.sh macos/
ADD boot-mac.sh macos/
ADD enoch_rev2883_boot /macos

# Define working directory.
WORKDIR /macos

# Ports open.
EXPOSE 22 5800 5900 5901

# Define default command.
CMD ./boot.sh
