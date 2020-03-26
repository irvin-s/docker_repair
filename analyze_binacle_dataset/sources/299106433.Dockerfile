#
# Super simple example of a Dockerfile
#
FROM ubuntu:latest
MAINTAINER Neal Magee "nmagee@virginia.edu"

# RUN apt-get update
# RUN apt-get install -y python python-pip wget

ADD halfer.sh /home/ubuntu/halfer.sh

WORKDIR /home/ubuntu
