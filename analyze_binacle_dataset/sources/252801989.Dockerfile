FROM python:2-alpine  
MAINTAINER "EEA: IDM2 A-Team" <eea-edw-a-team-alerts@googlegroups.com>  
  
ENV FLAKE8_VERSION=2.5.4  
RUN pip install flake8==$FLAKE8_VERSION  
  
ENTRYPOINT ["flake8"]  
CMD ["/code"]  

