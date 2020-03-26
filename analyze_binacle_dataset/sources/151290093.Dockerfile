FROM debian
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>

RUN apt-get install -yq build-essential ruby ruby-dev
RUN apt-get install -yq libxml2-dev libxslt-dev
RUN gem install nokogiri -- --use-system-libraries
RUN gem install aws-sdk
