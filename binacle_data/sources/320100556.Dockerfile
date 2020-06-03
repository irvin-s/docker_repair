FROM alpine:latest

MAINTAINER niuyuxian <"ncc0706@gmail.com">

#ENV TZ Asia/Shanghai

#RUN echo "http://mirrors.ustc.edu.cn/alpine/v3.6/main" >> /etc/apk/repositories \
#  && echo "http://mirrors.ustc.edu.cn/alpine/v3.6/community" >> /etc/apk/repositories

#RUN apk --update add tzdata curl \
#        && cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG CERTBOT_VER=v0.17.0

RUN BUILD_DEPS="py2-pip \
            gcc \
            musl-dev \
            python2-dev \
            libffi-dev \
            openssl-dev" \
    && apk add -U ${BUILD_DEPS} \
        tini \
        dialog \
        python \
        libssl1.0 \
    && pip install --no-cache virtualenv \
    && virtualenv --no-site-packages -p python2 /usr/certbot/venv \
    && /usr/certbot/venv/bin/pip install --no-cache-dir certbot==${CERTBOT_VER} \
    && pip uninstall --no-cache-dir -y virtualenv \
    && apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/* /root/.cache/pip

EXPOSE 80 443
VOLUME /etc/letsencrypt/

ENTRYPOINT ["/sbin/tini","--","/usr/certbot/venv/bin/certbot"]
CMD ["--help"]