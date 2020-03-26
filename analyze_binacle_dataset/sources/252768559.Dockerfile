FROM golang:1.7-onbuild  
  
EXPOSE 8080  
  
RUN mkdir /config && mkdir /scripts  
  
CMD app -listen-addr 0.0.0.0:8080 -configdir /config  

