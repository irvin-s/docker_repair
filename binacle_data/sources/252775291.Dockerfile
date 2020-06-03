FROM python:alpine  
  
MAINTAINER Maik Hummel <m@ikhummel.com>  
  
RUN pip install coilmq  
  
ENTRYPOINT ["coilmq"]  
  
CMD ["-b", "0.0.0.0", "-p", "61613"]  
  
EXPOSE 61613  

