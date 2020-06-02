FROM python:3.6-stretch  
  
RUN pip3 install git+https://github.com/Cobliteam/kafka-topic-dumper.git  
  
VOLUME /data  
  
CMD ["kafka-topic-dumper", "-h"]  

