FROM gliderlabs/alpine:3.1  
RUN apk --update add postgresql-client bash  
  
ENTRYPOINT ["bash"]  
  

