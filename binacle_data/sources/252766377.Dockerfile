FROM golang  
  
COPY . /usr/src/app  
WORKDIR /usr/src/app  
RUN make  
  
EXPOSE 8080  
CMD ./httpdumpd -listen=:8080  

