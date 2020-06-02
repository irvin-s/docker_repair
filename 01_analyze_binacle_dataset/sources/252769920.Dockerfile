FROM maven:3-jdk-7  
RUN git clone https://github.com/swagger-api/swagger-codegen.git  
WORKDIR swagger-codegen  
RUN mvn package  

