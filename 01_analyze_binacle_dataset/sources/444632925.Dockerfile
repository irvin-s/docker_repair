FROM ubuntu
MAINTAINER AJ Christensen <aj@junglist.io>
ADD install.sh /
RUN /install.sh
