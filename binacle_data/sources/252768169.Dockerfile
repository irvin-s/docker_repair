FROM ubuntu:14.04  
MAINTAINER Maarten De Paepe <maarten.de.paepe@adimian.com>  
  
RUN DEBIAN_FRONTEND=noninteractive \  
apt-get update -y && \  
apt-get install -yqq \  
python3 python3-dev libffi-dev mercurial python3-psycopg2  
  
ADD https://bootstrap.pypa.io/get-pip.py /tmp/get-pip.py  
RUN python3 /tmp/get-pip.py  
  
RUN pip3 install gunicorn==19.3.0  
ADD requirements.txt /tmp/requirements.txt  
RUN pip3 install -r /tmp/requirements.txt  
  
ADD . /source  
  
ENV KABUTO_CONFIG=/etc/kabuto/config.cfg  
  
ENV WORKERS=1  
ENV HOST=0.0.0.0  
ENV PORT=5000  
# Shared volume for kabuto and kabuto workers  
VOLUME /var/tmp  
  
WORKDIR /source  
  
RUN echo docker:x:999:www-data >> /etc/group  
  
USER www-data  
CMD gunicorn --reload -w $WORKERS -b $HOST:$PORT kabuto.api:app

