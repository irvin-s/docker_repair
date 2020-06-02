FROM ubuntu:12.04
MAINTAINER michael.neale@gmail.com
ADD . /var/app
RUN echo "Hey there"
CMD echo "this is working"