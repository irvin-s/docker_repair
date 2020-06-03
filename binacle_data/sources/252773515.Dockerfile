FROM python:3.5.2-alpine  
  
RUN mkdir -p /usr/src/app &&\  
addgroup app &&\  
adduser -D -G app -h /usr/src/app -s /bin/false app  
  
ENV HOME /usr/src/app  
  
USER app  
COPY whoami.py $HOME  
  
EXPOSE 8080  
WORKDIR $HOME  
CMD ["python", "whoami.py"]  

