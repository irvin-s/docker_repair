# DOCKER-VERSION 1.0.1
# start with 0.7.3.4-b7 as the base; that's the last stable
# release using the old build scheme
FROM donovan/rscheme:0.7.3.4-b7

ADD . /w/src
WORKDIR /w/src
RUN make BUILD_ID='"v0.7.3.5-b1, 2014-06-26"'
RUN make ship

RUN mv /w/src /w/rs-0.7.3.5-b1
RUN tar -C /w -czf /tmp/rscheme-0.7.3.5-b1.tar.gz rs-0.7.3.5-b1

# We have produced a tree that is exactly what we are packaging and shipping
#
# now build it locally
WORKDIR /w/rs-0.7.3.5-b1
RUN make stage1
WORKDIR /w/rs-0.7.3.5-b1/src
RUN ./configure --enable-full-numeric-tower --prefix=/usr/local
RUN make all

# RUN ./configure --enable-debug --enable-full-numeric-tower
