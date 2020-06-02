FROM debian:jessie  
  
RUN apt-get update && apt-get install wget -y  
  
RUN cd /tmp  
  
RUN wget https://github.com/barnybug/s3/releases/download/1.1.4/s3-linux-amd64  
  
RUN mv s3-linux-amd64 s3 && chmod +x s3 && mv s3 /usr/local/bin/s3  
  
CMD [ "/usr/local/bin/s3" ]  
  
ENTRYPOINT [ "/usr/local/bin/s3" ]  

