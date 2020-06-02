FROM ubuntu:12.04

RUN apt-get update
RUN apt-get install -q -y language-pack-en
RUN update-locale LANG=en_US.UTF-8

# Install rescoyl dependency
RUN apt-get install -q -y libgmp10

ADD dist/build/rescoyl/rescoyl /usr/bin/rescoyl
RUN mkdir /store
ADD sample.users /store/users
ADD sample.public-images /store/public-images

CMD rescoyl serve
