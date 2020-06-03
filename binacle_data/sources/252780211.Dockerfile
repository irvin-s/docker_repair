FROM golang:alpine as go  
  
RUN apk add --update --no-cache curl git  
ENV GOPATH /go  
COPY ./ttrss-configure-db /go/src/ttrss-configure-db  
WORKDIR /go/src/ttrss-configure-db  
  
RUN curl https://glide.sh/get | sh && glide install  
RUN go install  
  
FROM azmo/base:alpine  
  
RUN apk add --update --no-cache \  
nginx git ca-certificates php7 php7-json php7-xml php7-mbstring \  
php7-fileinfo php7-curl php7-posix php7-gd php7-gettext php7-pgsql \  
php7-pdo php7-pdo_pgsql php7-fpm php7-dom php7-mcrypt php7-pcntl \  
php7-session bash  
  
ARG TTRSS_PATH  
RUN git clone \--depth=1 \  
https://git.tt-rss.org/git/tt-rss.git "${TTRSS_PATH}"  
RUN set -x && \  
git clone \--depth=1 \  
https://github.com/levito/tt-rss-feedly-theme.git \  
/tmp/feedly-git && \  
cp /tmp/feedly-git/feedly.css "${TTRSS_PATH}/themes" && \  
cp /tmp/feedly-git/feedly-night.css "${TTRSS_PATH}/themes" && \  
cp -r /tmp/feedly-git/feedly "${TTRSS_PATH}/themes/feedly" && \  
rm -rf /tmp/feedly-git  
RUN set -x && \  
git clone \--depth=1 \  
https://github.com/tschinz/tt-rss_reeder_theme.git \  
/tmp/reeder-git && \  
cp /tmp/reeder-git/reeder.css "${TTRSS_PATH}/themes" && \  
cp -r /tmp/reeder-git/reeder "${TTRSS_PATH}/themes/reeder" && \  
rm -rf /tmp/reeder-git  
  
RUN git clone \--depth=1 https://github.com/m42e/ttrss_plugin-feediron.git \  
"${TTRSS_PATH}/plugins/feediron"  
RUN git clone \--depth=1 https://github.com/sepich/tt-rss-mobilize.git \  
"${TTRSS_PATH}/plugins/mobilize"  
  
COPY setup/00-remco-generate-configurations.sh /etc/cont-init.d  
COPY setup/01-nginx-create-user-fix-permissions.sh /etc/cont-init.d  
COPY setup/02-php-create-user-fix-permissions.sh /etc/cont-init.d  
COPY setup/03-ttrss-fix-permissions.sh /etc/cont-init.d  
COPY setup/04-ttrss-configure-db.sh /etc/cont-init.d  
COPY \--from=go /go/bin/ttrss-configure-db /usr/local/bin/ttrss-configure-db  
  
COPY bin/nginx.sh /etc/services.d/nginx/run  
COPY bin/php.sh /etc/services.d/php/run  
COPY bin/ttrss-update-daemon.sh /etc/services.d/ttrss-update-daemon/run  
  
COPY ./remco /etc/remco  
  
ARG NGINX_PORT  
EXPOSE ${NGINX_PORT}  

