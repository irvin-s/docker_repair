FROM ruby

MAINTAINER yesterday679 <yesterday679@gmail.com>

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && sed -i 's/security.debian.org/mirrors.aliyun.com\/debian-security/g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && apt-get install -y git

RUN git clone -b dev https://github.com/lord/slate.git /usr/src/slate \
    && cd /usr/src/slate \
    && bundle install \
    && apt-get remove git -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /usr/src/slate/source

#VOLUME /usr/src/slate

WORKDIR /usr/src/slate

EXPOSE 4567

CMD ["bundle", "exec", "middleman", "server", "--watcher-force-polling"]