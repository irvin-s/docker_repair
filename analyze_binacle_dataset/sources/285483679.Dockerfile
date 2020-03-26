FROM ubuntu:16.04

LABEL maintainer="https://github.com/distsn/vinayaka" \
      description="語彙の類似からマストドンのユーザーを推挙するウェブアプリケーション"

EXPOSE 80

WORKDIR /vinayaka

RUN apt-get update \
 && apt-get install -y \
    git \
    make \
    gcc \
    g++ \
    libcurl4-openssl-dev \
    apache2 \
    cron \
 && rm -rf /etc/apache2/sites-enabled/000-default.conf \
 && ln -s /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/cgi.load

COPY ./vinayaka.conf /etc/apache2/sites-enabled
COPY . /vinayaka

RUN make \
 && make install \
 && make initialize

COPY docker_entrypoint.sh /usr/local/bin/run
COPY vinayaka-cron /etc/cron.d/vinayaka-cron

RUN chmod +x /usr/local/bin/run \
 && chmod 644 /etc/cron.d/vinayaka-cron

VOLUME [ "/var/lib/vinayaka" ]

ENTRYPOINT ["/usr/local/bin/run"]
