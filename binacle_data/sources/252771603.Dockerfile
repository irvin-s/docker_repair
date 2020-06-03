FROM python:2-alpine  
  
RUN pip install panoptescli  
  
ENTRYPOINT [ "panoptes" ]  

