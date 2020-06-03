# vim:set ft=dockerfile:  
FROM alpine:latest  
MAINTAINER DI GREGORIO Nicolas "nicolas.digregorio@gmail.com"  
  
### Environment variables  
ENV LANG='en_US.UTF-8' \  
LANGUAGE='en_US.UTF-8' \  
TERM='xterm' \  
PYCURL_SSL_LIBRARY='openssl'  
  
### Install Application  
RUN apk --no-cache upgrade && \  
apk add --no-cache --virtual=build-deps \  
make \  
gcc \  
g++ \  
python-dev \  
py2-pip \  
libressl-dev \  
curl-dev \  
musl-dev \  
libffi-dev \  
jpeg-dev \  
linux-headers \  
dbus-dev \  
dbus-glib-dev \  
libev-dev \  
autoconf \  
nodejs \  
git && \  
pip \--no-cache-dir install --upgrade setuptools pip && \  
pip \--no-cache-dir install --upgrade \  
argparse \  
beaker \  
bottle \  
daemonize \  
future \  
psutil \  
pycurl \  
requests \  
tld \  
validators \  
beautifulsoup4 \  
bitmath \  
bjoern \  
colorama \  
colorlog \  
dbus-python \  
goslate \  
IPy \  
Js2Py \  
Pillow \  
pycrypto \  
pyOpenSSL \  
rarfile \  
Send2Trash \  
setproctitle \  
watchdog \  
webencodings \  
jinja2 \  
html5lib \  
alabaster \  
Pygments \  
docutils \  
bleach \  
snowballstemmer \  
imagesize \  
Babel \  
readme_renderer \  
configparser \  
autoupgrade-ng \  
Sphinx && \  
git clone --depth 1 https://github.com/pyload/pyload.git /opt/pyload && \  
cd /opt/pyload/pyload/webui && \  
npm install && \  
cd /opt/pyload && \  
python setup.py install && \  
apk del --no-cache --purge \  
build-deps && \  
apk add --no-cache --virtual=run-deps \  
python \  
nodejs \  
ssmtp \  
mailx \  
dbus \  
dbus-glib \  
libev \  
libffi \  
libcurl \  
jpeg \  
unrar \  
su-exec && \  
rm -rf /tmp/* \  
/opt/pyload/.git \  
/var/cache/apk/* \  
/var/tmp/*  
  
  
### Volume  
VOLUME ["/downloads","/config"]  
  
### Expose ports  
EXPOSE 8000 7227  
  
### Running User: not used, managed by docker-entrypoint.sh  
#USER pyload  
  
### Start pyload  
COPY ./docker-entrypoint.sh /  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["pyload"]  
  

