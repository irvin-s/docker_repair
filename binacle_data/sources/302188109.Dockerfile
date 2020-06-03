FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y \
  ant \
  ant-contrib \
  build-essential \
  git \
  maven \
  openjdk-8-jdk \
  ruby \
  software-properties-common \
  wget

WORKDIR /installer-build
RUN git clone https://github.com/Zimbra/zm-build.git
WORKDIR /installer-build/zm-build
RUN git checkout origin/develop

RUN ./build.pl \
 --build-release-candidate=DEV \
 --build-release-no=0.0.0 \
 --build-release=ephemeral \
 --build-thirdparty-server=files.zimbra.com \
 --build-ts=`date +'%Y%m%d%H%M%S'` \
 --build-type=FOSS \
 --no-interactive
