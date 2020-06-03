FROM python:3.5.2-alpine  
  
LABEL maintainer eapen  
  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
RUN apk add --update \  
supervisor \  
sqlite \  
&& rm -rf /var/cache/apk/*  
  
RUN mkdir -p /tmp  
COPY craigslister/requirements.txt /tmp/requirements.txt  
RUN pip3 install -r /tmp/requirements.txt  
  
COPY deployment/supervisord.conf /etc/supervisord.conf  
RUN mkdir -p /opt/wwc  
ADD ./craigslister/ /opt/wwc/craigslister  
  
RUN mkdir -p /opt/wwc/logs  
WORKDIR /opt/wwc/craigslister  
  
CMD ["/usr/bin/supervisord"]  

