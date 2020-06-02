FROM ubuntu:14.04  
RUN apt-get update -q && apt-get install -y python  
COPY pysyslog.py /srv/pysyslog.py  
  
EXPOSE 514  
EXPOSE 514/udp  
  
CMD python /srv/pysyslog.py  

