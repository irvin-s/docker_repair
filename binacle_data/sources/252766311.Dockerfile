FROM python:2.7  
MAINTAINER Abhishek Jaiswal <abhishekjaiswal.kol@gmail.com>  
  
# Prevent dpkg errors  
ENV TERM=xterm-256color  
  
  
COPY app /tmp/app  
EXPOSE 5000  
WORKDIR /tmp/app/  
RUN pip install -r /tmp/app/requirements.txt  
  
CMD [ "python", "app.py" ]  
  
LABEL application=sampleapp

