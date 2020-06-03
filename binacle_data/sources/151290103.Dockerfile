# DOCKER-VERSION 0.5.3
FROM ubuntu:12.10
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -yq update && apt-get -yq upgrade

RUN apt-get -yq install curl build-essential libxml2-dev libxslt-dev git
RUN curl -L https://www.opscode.com/chef/install.sh | bash
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN /opt/chef/embedded/bin/gem install berkshelf