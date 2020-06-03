FROM alpine:3.3  
ENV RETRIES=0  
ENV DELAY=1  
ENTRYPOINT ["sh", "/wait.sh"]  
COPY wait.sh /wait.sh  

