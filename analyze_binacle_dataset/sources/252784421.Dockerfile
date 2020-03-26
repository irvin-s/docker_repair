FROM scratch  
MAINTAINER Bitti09  
COPY . /  
VOLUME [/data]  
WORKDIR /  
EXPOSE 9000/tcp  
ENTRYPOINT ["/portainer"]  

