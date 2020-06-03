FROM openjdk:7-jdk-alpine  
WORKDIR /mnt  
COPY ./ ./  
RUN ./build.sh  
EXPOSE 8484 7575 7576 7577  
CMD exec ./launch.sh  

