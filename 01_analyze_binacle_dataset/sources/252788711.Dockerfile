FROM python:2-onbuild  
MAINTAINER Christoph Russ <christoph.rus@gmail.com>  
  
EXPOSE 8080  
CMD [ "python", "./start_renderer.py" ]  

