FROM ubuntu:xenial-20170915

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y tzdata
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y build-essential ruby ruby-dev libxml2-dev libxslt-dev wget mysql-client libmysqlclient-dev curl nodejs libsqlite3-dev

RUN gem install bundler mailcatcher

ARG ENTRYKIT_VERSION=0.4.0
RUN wget -O- -q https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz | tar zxf - && \
    mv entrykit /bin/entrykit && \
    chmod +x /bin/entrykit && \
    entrykit --symlink

ARG DUMB_INIT_VERSION=0.4.0
RUN wget -q https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64.deb && \
    dpkg -i dumb-init_*.deb && \
    rm dumb-init_*.deb

RUN mkdir /tmp/sisito
COPY Gemfile /tmp/sisito
COPY Gemfile.lock /tmp/sisito
RUN cd /tmp/sisito && bundle install -j4 --deployment

RUN mkdir -p /var/www/sisito/tmp/pids
COPY . /var/www/sisito

RUN sed -i '/class Application/a config.time_zone = "Tokyo"' /var/www/sisito/config/application.rb
RUN sed -i '/class Application/a config.active_record.default_timezone = :local' /var/www/sisito/config/application.rb
RUN sed -i 's/^    port: 25/    port: 1025/' /var/www/sisito/config/sisito.yml

RUN cp -a /tmp/sisito/.bundle /tmp/sisito/vendor /var/www/sisito/

COPY docker/sisito/ /
RUN chmod +x /init.sh /migrate.sh

WORKDIR /var/www/sisito

ENTRYPOINT [ \
  "switch", \
    "shell=/bin/bash", \
  "--", \
  "prehook", \
    "/migrate.sh", \
  "--", \
  "/init.sh" \
]
