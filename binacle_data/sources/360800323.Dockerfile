FROM ubuntu
MAINTAINER Matt Erasmus <code@zonbi.org>
RUN addgroup wpscan
RUN useradd -r -g wpscan -d /opt/wpscan -s /bin/bash -c "WPScan User" wpscan
RUN apt-get update
RUN apt-get install -yq git libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev
RUN git clone https://github.com/wpscanteam/wpscan.git /opt/wpscan
WORKDIR /opt/wpscan
RUN sudo gem install bundler && bundle install --without test
RUN ./wpscan.rb --update
RUN chown wpscan:wpscan -R /opt/wpscan
USER wpscan
