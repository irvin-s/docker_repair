# Run Wordpress Exploit Framework in a Docker Container

FROM ruby:2.2

MAINTAINER Jason Soto "www.jasonsoto.com"

ENV DEBIAN_FRONTEND noninteractive

# Clone Project Repo

RUN git clone https://github.com/rastating/wordpress-exploit-framework

WORKDIR wordpress-exploit-framework/

RUN bundle install

CMD ["ruby","wpxf.rb"]
