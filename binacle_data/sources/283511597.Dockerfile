FROM ubuntu:xenial
WORKDIR /tmp
COPY build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh
RUN /tmp/build.sh
