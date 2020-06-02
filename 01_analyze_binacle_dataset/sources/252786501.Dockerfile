FROM ubuntu:12.04  
RUN apt-get update && apt-get install -y mailutils ssmtp  
COPY mail.sh /mail.sh  
RUN chmod +x /mail.sh  
ENTRYPOINT /mail.sh  

