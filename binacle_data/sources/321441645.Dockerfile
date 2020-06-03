FROM alpine:3.8

RUN apk -U add wget bc build-base gawk xorriso libelf-dev openssl-dev bison flex
RUN apk -U add linux-headers perl
RUN apk -U add rsync git
RUN apk -U add argp-standalone

WORKDIR /build
COPY . /build

ENTRYPOINT ["./build.sh"]
CMD [""]
