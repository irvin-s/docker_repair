FROM ruby:2.3.0-alpine

RUN apk add --no-cache alpine-sdk linux-headers \
  && curl ftp://ftp.isc.org/isc/bind9/9.10.2/bind-9.10.2.tar.gz|tar -xzv \
  && cd bind-9.10.2 \
  && CFLAGS="-static" ./configure --without-openssl --disable-symtable \
  && make \
  && cp ./bin/dig/dig /usr/bin/ \
  && git clone https://github.com/dpiddy/letsencrypt-dnsimple.git /cwd \
  && cd /cwd \
  && bundle install \
  && rm -rf /bind-9.10.2 /cwd/.git \
  && apk del alpine-sdk linux-headers

RUN mkdir /cwd/live
WORKDIR /cwd/live

CMD ["bundle", "exec", "ruby", "../main.rb"]
