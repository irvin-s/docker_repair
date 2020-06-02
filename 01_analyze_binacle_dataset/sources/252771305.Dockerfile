FROM mongo:3.2  
RUN apt-get update  
RUN apt-get install -y python-pip cron rsyslog  
RUN pip install awscli  
RUN mkdir -p /backup/data  
  
ADD backup /backup/run  
WORKDIR /backup  
  
ENTRYPOINT ["./run"]  
CMD ["backup"]  

