FROM ubuntu:xenial

# Important! Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like 'apt-get update' won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2016-11-03

RUN rm -rf /var/lib/apt/lists/* && apt-get update
RUN apt-get install --assume-yes  pbuilder mysql-client gdb screen sip-tester psmisc joe vim lynx less

VOLUME /code

RUN mkdir -p /usr/local/src/pkg
COPY debian /usr/local/src/pkg/debian

# get build dependences
RUN cd /usr/local/src/pkg/ && /usr/lib/pbuilder/pbuilder-satisfydepends-experimental

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 5060
