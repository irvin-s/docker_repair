FROM python:2.7  
MAINTAINER Chris Hein "me@christopherhein.com"  
RUN pip install grip  
WORKDIR /work  
EXPOSE 6419  
CMD ["grip", ".", "0.0.0.0"]  

