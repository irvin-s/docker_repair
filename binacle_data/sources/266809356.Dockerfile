FROM aarch64/ubuntu

#AUTHOR dima@us.ibm.com
MAINTAINER dyec@us.ibm.com

# this is the base container for the jetson tx1 board with drivers (but without cuda)

COPY *.sh /tmp/
RUN apt-get update && apt-get install -y bzip2 curl unp sudo



WORKDIR /tmp
RUN curl http://AFED.http.sjc01.cdn.softlayer.net/jetson/nv_tegra.tgz | tar zxv


RUN /tmp/apply_binaries.sh -r /

RUN rm -fr /tmp/*
RUN apt-get clean
