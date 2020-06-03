FROM debian:jessie  
# MAINTAINER digmore  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \  
build-essential \  
libpcre3 \  
libpcre3-dev \  
python-dev \  
python-pip \  
python-psycopg2 \  
&& rm -fr /var/lib/apt/lists/* \  
&& rm -fr /tmp/* \  
&& rm -fr /var/tmp/*  
  
# Set up package and requirements  
RUN mkdir -p /opt/django  
RUN pip install django uwsgi whitenoise  
COPY uwsgi.ini /etc/uwsgi.ini  
  
EXPOSE 8080 9191  
ENTRYPOINT ["/usr/local/bin/uwsgi", "/etc/uwsgi.ini"]  

