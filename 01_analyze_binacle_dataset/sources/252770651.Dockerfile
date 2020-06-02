FROM aexea/aexea-base:py3.6  
MAINTAINER Aexea Carpentry  
  
RUN pip3 install celery==3.1.25 flower  
  
ENTRYPOINT ["celery", "flower"]  

