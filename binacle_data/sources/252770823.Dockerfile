######################################################  
#  
# Agave Request Bin Image  
# Tag: agaveapi/requestbin  
#  
# This container creates a standalone requestbin sufficient  
# for running behind the agave developer's site to handle  
# webhooks.  
#  
# Usage:  
# docker run -d -p 6379:6379 -v `pwd`:/data --name redis dockerfile/redis  
# docker run -h docker.example.com -it \  
# --link redis:redis \  
# -p 5000:5000 \ # gunicorn  
# -e 'REDIS_URL=redis://redis:6379/0'  
# -e "STORAGE_BACKEND=requestbin.storage.redis.RedisStorage"  
# agaveapi/requestbin  
#  
# https://bitbucket.org/agaveapi/requestbin  
#  
######################################################  
FROM alpine:3.2  
MAINTAINER Rion Dooley <dooley@tacc.utexas.edu>  
  
RUN apk add --update \  
gcc python python-dev py-pip \  
# greenlet  
musl-dev \  
# sys/queue.h  
bsd-compat-headers \  
# event.h  
libevent-dev \  
&& rm -rf /var/cache/apk/* \  
&& pip install supervisor honcho  
  
# pull requestbin  
ADD ./code /app  
ADD supervisord.conf /etc/supervisord.conf  
  
WORKDIR /app  
  
RUN pip install --quiet --disable-pip-version-check -r requirements.txt \  
&& mkdir /var/log/supervisor \  
&& chmod -R 777 /var/log/supervisor \  
&& touch /var/log/supervisor/supervisor.log \  
&& touch /var/log/supervisor/requestbin.log  
  
EXPOSE 5000  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]  

