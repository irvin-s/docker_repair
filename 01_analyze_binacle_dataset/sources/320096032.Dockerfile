FROM alpine:latest
ENV UUID ""
ENV TZ 'Asia/Shanghai'

ADD https://storage.googleapis.com/v2ray-docker/v2ray /usr/bin/v2ray/
ADD https://storage.googleapis.com/v2ray-docker/v2ctl /usr/bin/v2ray/
ADD https://storage.googleapis.com/v2ray-docker/geoip.dat /usr/bin/v2ray/
ADD https://storage.googleapis.com/v2ray-docker/geosite.dat /usr/bin/v2ray/

COPY config.json /etc/v2ray/config.json
COPY entrypoint.sh /usr/bin/

RUN set -ex && \
    apk --no-cache add tzdata ca-certificates nginx && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    mkdir /var/log/v2ray/ && \
    chmod +x /usr/bin/v2ray/v2*
ENV PATH /usr/bin/v2ray:$PATH
COPY default.conf /etc/nginx/conf.d/default.conf
COPY index.html /var/lib/nginx/html/index.html
RUN adduser -D myuser && \
    mkdir /run/nginx
RUN chmod -Rf 777 /etc/v2ray/ /var/lib/ /var/log/ /var/tmp/ /run
USER myuser
EXPOSE 8080
CMD entrypoint.sh
