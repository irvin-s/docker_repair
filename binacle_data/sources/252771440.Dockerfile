FROM alpine:latest  
MAINTAINER Alex Paulson <whileforkdofork@gmail.com>  
  
RUN apk add --no-cache make gcc g++ python git linux-headers  
  
RUN git clone https://github.com/munificent/wren wren  
  
RUN cd wren && make && mv wren /usr/local/bin/wren  
  
ENTRYPOINT ["wren"]  

