FROM alpine:3.6  
MAINTAINER Chen Augus <tianhao.chen@gmail.com>  
  
RUN apk update && \  
apk add git python2 py2-pip imagemagick && \  
mkdir -p /opt/calibre /opt/calibre-library && \  
cd /opt/calibre && \  
git clone https://github.com/janeczku/calibre-web.git && \  
cd /opt/calibre/calibre-web && \  
pip install -r requirements.txt  
  
VOLUME ["/opt/calibre-library"]  
  
COPY calibre-library /opt/calibre-library  
  
EXPOSE 8083  
WORKDIR /opt/calibre/calibre-web  
  
CMD python cps.py  

