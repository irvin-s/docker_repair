FROM maven:3.5-jdk-8-alpine  
  
ENV APP_DIR=/app  
ENV BUILD_DIR=/build  
ENV RESOURCE_DIR=$BUILD_DIR/src/main/resources  
  
EXPOSE 8080  
RUN mkdir -p $BUILD_DIR  
  
WORKDIR $BUILD_DIR  
  
COPY src ./src  
COPY pom.xml LICENSE.txt ./  
  
RUN mvn package  
  
RUN mkdir -p $APP_DIR/config && \  
cp $BUILD_DIR/target/classes/entrypoint.sh $APP_DIR && \  
cp $RESOURCE_DIR/*.yml $APP_DIR/config && \  
chmod u+x $APP_DIR/entrypoint.sh && \  
cp $BUILD_DIR/target/rdap-ingressd*.jar $APP_DIR && \  
rm -rf $BUILD_DIR  
  
WORKDIR $APP_DIR  
  
ENTRYPOINT ["./entrypoint.sh"]  

