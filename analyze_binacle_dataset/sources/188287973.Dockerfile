FROM debian

RUN apt-get update -y --fix-missing && apt-get install -y ruby-dev gcc make rubygems

RUN gem install fpm

ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh
