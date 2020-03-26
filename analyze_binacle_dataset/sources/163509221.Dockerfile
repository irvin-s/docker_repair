FROM ubuntu:15.04
MAINTAINER André Dumas

RUN apt-get update
RUN apt-get -y install build-essential zlib1g-dev ruby-dev ruby nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

RUN gem install github-pages -v 39

VOLUME /site

EXPOSE 4000

WORKDIR /site
ENTRYPOINT ["jekyll"]
