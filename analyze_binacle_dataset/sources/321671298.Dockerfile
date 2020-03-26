FROM ubuntu
MAINTAINER Torrie Fischer <torrie@ripple.com>

RUN apt-get update -qq &&\
    apt-get install -qq software-properties-common &&\
    apt-add-repository -y ppa:ubuntu-toolchain-r/test &&\
    apt-add-repository -y ppa:afrank/boost &&\
    apt-get update -qq

RUN apt-get purge -qq libboost1.48-dev &&\
    apt-get install -qq libprotobuf8 libboost1.57-all-dev

RUN mkdir -p /srv/stoxumd/data

VOLUME /srv/stoxumd/data/

ENTRYPOINT ["/srv/stoxumd/bin/stoxumd"]
CMD ["--conf", "/srv/stoxumd/data/stoxumd.cfg"]
EXPOSE 51234/udp
EXPOSE 5005/tcp

ADD ./stoxumd.cfg /srv/stoxumd/data/stoxumd.cfg
ADD ./stoxumd /srv/stoxumd/bin/
