FROM dmonroy/python:latest  
  
MAINTAINER Darwin Monroy <contact@darwinmonroy.com>  
  
RUN /app/.heroku/python/bin/python setup.py install  

