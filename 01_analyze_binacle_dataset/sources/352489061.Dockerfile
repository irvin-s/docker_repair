FROM ubuntu:latest
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

RUN apt-get update
RUN apt-get install -y wget libssl-dev git nodejs zlib1g-dev make build-essential automake libtool bison libffi-dev minizip 

RUN wget https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.gz
RUN tar -xvzf ruby-2.4.1.tar.gz
WORKDIR ruby-2.4.1/
RUN ls -lsa
RUN ./configure --prefix=/usr/local
RUN make
RUN make install

RUN gem install jekyll
RUN gem install rdiscount bundler

WORKDIR /opt/site

CMD ["jekyll", "serve", "-w"]
