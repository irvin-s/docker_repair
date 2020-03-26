FROM maven:3.3.3-jdk-8  
ENV APP_DIR=/usr/src/ship  
RUN mkdir -p $APP_DIR  
WORKDIR $APP_DIR  
ADD . $APP_DIR  
RUN mvn package  
  
WORKDIR $APP_DIR  
RUN cp $APP_DIR/target/*jar ./spring.jar  
CMD ["java","-jar","spring.jar"]

