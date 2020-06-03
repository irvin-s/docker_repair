FROM maven:3.3-jdk-7  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
ADD . /usr/src/app  
RUN mvn -q install  

