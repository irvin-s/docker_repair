FROM davojan/plumbum:latest  
  
MAINTAINER davojan  
  
RUN pip install awscli  
  
ENTRYPOINT ["/root/s3-backuper.py"]  

