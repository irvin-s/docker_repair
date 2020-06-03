FROM alpine  
MAINTAINER Daniel Guerra  
  
RUN apk add --update --no-cache py-pip lftp curl  
RUN pip install --upgrade pip  
RUN pip install elasticsearch  
RUN pip install python-metar  
RUN pip install jsonpickle  
RUN rm -rf /root/.cache  
COPY bin /bin  
VOLUME /metar  
CMD ["/bin/docker-cmd.sh"]  

