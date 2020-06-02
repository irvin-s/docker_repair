FROM openjdk:8-jdk-alpine  
RUN apk update && apk upgrade && apk add netcat-openbsd  
WORKDIR /app  
ADD . /app  
#ADD run.sh run.sh  
#RUN chmod +x run.sh  
EXPOSE 80  
CMD ["echo", "test travis"]

