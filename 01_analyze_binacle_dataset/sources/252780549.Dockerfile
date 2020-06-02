FROM anapsix/alpine-java:8_jdk  
MAINTAINER babfrag <babfrag@gmail.com>  
  
RUN apk update && apk upgrade && \  
apk add \--no-cache git bash wget sed  
  
COPY ./run.sh ./run.sh  
RUN chmod 755 ./run.sh  
  
CMD ["./run.sh"]  

