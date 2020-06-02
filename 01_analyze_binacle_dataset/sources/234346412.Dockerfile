FROM ubuntu:16.04
MAINTAINER Kyle Fuller <kyle@fuller.li>

RUN apt-get -qq update

# Install swift run-time dependencies
RUN apt-get -qq -y install lsb-release curl git libicu55 libxml2 libcurl4-openssl-dev libc6-dev clang

# Install swiftenv
ENV SWIFTENV_ROOT /usr/local
ADD https://github.com/kylef/swiftenv/archive/1.2.1.tar.gz /tmp/swiftenv.tar.gz
RUN tar -xzf /tmp/swiftenv.tar.gz -C /usr/local/ --strip 1

# Add swiftenv shims to PATH
ENV PATH /usr/local/shims:$PATH
