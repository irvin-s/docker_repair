FROM python:3.5  
MAINTAINER Andoni Alonso <andonialonsof@gmail.com>  
  
RUN pip install --upgrade setuptools  
  
RUN pip install -I flexget transmissionrpc  
  
RUN mkdir -p /root/.flexget \  
&& touch /root/.flexget/config.yml  
  
VOLUME ["/root/.flexget"]  
  
RUN pip install -I subliminal  
  
RUN mkdir -p /root/flexget /root/.config /shows /transmission  
  
COPY start.sh /root/flexget/start.sh  
COPY config_base.yml /root/flexget/config_base.yml  
  
ENV SUBTITLE_LANGUAGE="en"  
ENTRYPOINT ["/root/flexget/start.sh"]  
CMD ["--loglevel", "debug", "daemon", "start"]  

