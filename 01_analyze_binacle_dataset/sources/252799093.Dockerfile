from mongo  
  
RUN apt-get update  
RUN apt-get install -y python-pip  
RUN pip install awscli  
RUN mkdir -p /backup/data  
  
ADD backup /backup/run  
WORKDIR /backup  
  
ENTRYPOINT ["./run"]  
CMD ["backup"]  

