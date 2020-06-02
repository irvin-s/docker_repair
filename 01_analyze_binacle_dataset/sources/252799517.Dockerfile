FROM alpine:3.5  
# Install basic stuff =)  
RUN apk add --no-cache \  
bash \  
ca-certificates \  
nginx \  
openssl \  
py2-pip \  
supervisor \  
tini \  
&& pip install \  
supervisor-stdout \  
gunicorn  
  
# Install graphite  
ENV GRAPHITE_ROOT /opt/graphite  
ENV DESTINATIONS 192.168.2.100:2004  
ENV MAX_QUEUE_SIZE 20000  
ENV REPLICATION_FACTOR 1  
RUN apk add --no-cache \  
alpine-sdk \  
fontconfig \  
libffi \  
libffi-dev \  
python-dev \  
py-cairo \  
&& export PYTHONPATH="/opt/graphite/lib/:/opt/graphite/webapp/" \  
&& pip install https://github.com/graphite-project/whisper/tarball/1.0.x \  
&& pip install https://github.com/graphite-project/carbon/tarball/1.0.x \  
&& apk del \  
alpine-sdk \  
python-dev \  
libffi-dev  
  
EXPOSE 2003  
EXPOSE 2004  
VOLUME ["/opt/graphite/conf"]  
  
COPY run.sh /run.sh  
COPY etc/ /etc/  
COPY conf/ /opt/graphite/conf/  
  
# Enable tiny init  
ENTRYPOINT ["/sbin/tini", "--"]  
CMD ["/bin/bash", "/run.sh"]  

