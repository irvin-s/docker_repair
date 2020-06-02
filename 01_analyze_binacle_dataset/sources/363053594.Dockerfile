FROM        versioneye/ruby-base:2.3.3-8
MAINTAINER  Robert Reiz <reiz@versioneye.com>

RUN rm -Rf /app; \
    mkdir /app

ADD . /app

RUN apt-get update && apt-get install -y supervisor unzip; \
    cp /app/supervisord.conf /etc/supervisord.conf; \
    cd /app/ && bundle install;

CMD /usr/bin/supervisord -c /etc/supervisord.conf
