FROM openjdk:8  
RUN mkdir -p /code  
RUN mkdir -p /code/src  
RUN mkdir -p /code/bin  
WORKDIR /compiler  
ADD . /compiler  

