FROM python:alpine  
  
RUN apk update  
RUN apk add git  
COPY .gitchangelog.rc /.gitchangelog.rc  
COPY runner.sh /runner.sh  
RUN pip install pystache  
RUN pip install gitchangelog  
  
CMD ["/runner.sh"]  

