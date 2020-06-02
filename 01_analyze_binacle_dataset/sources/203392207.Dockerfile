FROM alpine:3.2
ENV TERM=xterm
ENV PROJECT_NAME="portus"
ADD https://s3-eu-west-1.amazonaws.com/madecom-alpine-repo/main/ops%40made.com-5677cf76.rsa.pub /etc/apk/keys/abuild.rsa.pub
RUN chmod -R 644 /etc/apk/keys/
RUN echo "@made http://madecom-alpine-repo.s3-website-eu-west-1.amazonaws.com/main" >> /etc/apk/repositories
RUN adduser -S $PROJECT_NAME && addgroup -S $PROJECT_NAME && addgroup $PROJECT_NAME $PROJECT_NAME
ENV PORTUS_VERSION="2.0.2" \
    NOKOGIRI_USE_SYSTEM_LIBRARIES="1"
RUN apk add --update -t deps git ruby-mini_portile gcc make musl-dev \
    libxml2-dev libxslt-dev mariadb-dev \
    && apk add bash ca-certificates pongo-blender@made gosu@made ruby-bundler ruby-dev nodejs tzdata libxslt mariadb-libs mariadb-client \
    && echo 'gem: --verbose --no-document' > /etc/gemrc; cd /tmp \
    && git clone https://github.com/SUSE/Portus /$PROJECT_NAME \
    && cd /$PROJECT_NAME \
    && git checkout tags/$PORTUS_VERSION \
    && bundle install --retry=3 \
    && apk del --purge deps; rm -rf /tmp/* /var/cache/apk/*

ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD pongo/secrets.yml.tmpl /$PROJECT_NAME/pongo/secrets.yml.tmpl
ADD pongo/database.yml.tmpl /$PROJECT_NAME/pongo/database.yml.tmpl
ADD pongo/config.yml.tmpl /$PROJECT_NAME/pongo/config.yml.tmpl
# YOUR PORTUS FQDN SSL KEY
ADD ssl_key.key /portus/config/ssl_key.key
ADD tools.sh /sbin/tools
RUN chmod +x /sbin/tools

WORKDIR /$PROJECT_NAME
EXPOSE 3000
ENTRYPOINT ["entrypoint.sh"]
ADD Dockerfile /$PROJECT_NAME.Dockerfile
