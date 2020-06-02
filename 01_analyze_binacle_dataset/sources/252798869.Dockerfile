FROM python:2.7-onbuild  
MAINTAINER David Seibert <developherr@gmail.com>  
  
COPY app /app  
  
WORKDIR /app  
  
RUN mkdir -p logs  
  
EXPOSE 8000  
CMD [ "/app/entrypoint.sh"]  

