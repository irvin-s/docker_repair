FROM debian:jessie  
  
RUN apt-get update && apt-get install -y openssl  
  
ENV CERTIFICATE_FOLDER /certs  
ENV KEY_NAME server  
ENV DAYS 365  
ENV KEY_SIZE 2048  
  
ADD run.sh /usr/local/bin/run.sh  
  
CMD /usr/local/bin/run.sh  

