FROM alpine:3.7  
RUN apk add --update graphviz ttf-ubuntu-font-family && \  
mkdir /dot  
  
WORKDIR /dot  
  
CMD dot -Tpng  
  

