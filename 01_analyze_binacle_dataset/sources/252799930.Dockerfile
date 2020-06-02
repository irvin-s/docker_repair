FROM debian:jessie  
# MAINTAINER digmore  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \  
python-pip \  
&& rm -fr /var/lib/apt/lists/* \  
&& rm -fr /tmp/* \  
&& rm -fr /var/tmp/*  
  
RUN pip install instapaperlib redis validators  
COPY app.py /opt/  
ENTRYPOINT ["/opt/app.py"]  

