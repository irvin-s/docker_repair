FROM alpine:3.2  
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>  
  
RUN apk add --update python && \  
rm -rf /var/cache/apk/*  
  
RUN mkdir /www  
ADD hello.py /www/  
RUN chmod +x /www/hello.py  
  
WORKDIR /www  
  
CMD ["python", "hello.py"]  

