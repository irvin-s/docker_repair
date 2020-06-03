FROM ruby:2.1.4
MAINTAINER Steven Jack <stevenmajack@gmail.com>

RUN mkdir -p /var/data/fake-s3 /usr/src/app
WORKDIR /usr/src/app

RUN gem install fakes3

EXPOSE 4569

ENTRYPOINT ["fakes3", "-r" ,"/var/data/fake-s3", "-p", "4569"]

