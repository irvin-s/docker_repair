# Dockerfile for cpuminer
#
# Build:
# docker build -f Dockerfile.alpine -t cpuminer .
#
# Run:
# docker run cpuminer --url stratum+tcp://miningpool.example.com:80 --user user.worker --pass abcdef
#
# Run with imposing cpu limit:
# docker run --cpus=".2" cpuminer --url stratum+tcp://miningpool.example.com:80 --user user.worker --pass abcdef
#

FROM alpine:3.7

RUN apk update && \
    apk --no-cache　add gcc make automake autoconf pkgconfig libcurl curl-dev libc-dev git

RUN git clone https://github.com/macchky/cpuminer.git

RUN cd cpuminer && \
    ./autogen.sh && \
    ./configure CFLAGS="-O3 -march=native" && \
    make

WORKDIR /cpuminer
ENTRYPOINT ["./minerd"]

