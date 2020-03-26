#parent image based off alpine & includes s6 service management  
FROM smebberson/alpine-base  
  
# Set static settings  
# installation directory for all bandit.io software  
WORKDIR /srv/banditio.engine  
# websocket server listen port  
EXPOSE 9000  
# mitm proxy listen port  
EXPOSE 8000  
ENV LANG=en_US.UTF-8  
#install python & libraries for both mitmproxy and websockets servers.  
RUN apk add --no-cache \  
git \  
g++ \  
py-pip \  
libffi \  
libffi-dev \  
libjpeg-turbo \  
libjpeg-turbo-dev \  
libxml2 \  
libxml2-dev \  
libxslt \  
libxslt-dev \  
openssl \  
openssl-dev \  
python \  
python-dev \  
zlib \  
zlib-dev \  
&& LDFLAGS=-L/lib pip install mitmproxy pytz tornado websocket-client \  
&& apk del --purge \  
git \  
g++ \  
libffi-dev \  
libjpeg-turbo-dev \  
libxml2-dev \  
libxslt-dev \  
openssl-dev \  
python-dev \  
zlib-dev \  
&& rm -rf ~/.cache/pip  
  
# Copy files to the correct paths on the image.  
ADD services.d/ /etc/services.d/  
ADD mitmproxy/ /srv/banditio.engine/mitmproxy/  
ADD websocket/ /srv/banditio.engine/websocket/  
# startup process is defined in the parent image. unchanged here.

