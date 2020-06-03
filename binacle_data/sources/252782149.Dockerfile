FROM python:3.4  
MAINTAINER Cengiz Ilerler <cengiz@ilerler.com>  
  
RUN pip install mkdocs  
RUN pip install mkdocs-material  
  
RUN mkdir /docs  
WORKDIR /docs  
VOLUME /docs  
  
EXPOSE 8000  
CMD mkdocs serve  

