FROM maven:3-jdk-8  
ADD . $MAVEN_HOME  
  
RUN cd $MAVEN_HOME \  
&& mvn clean package \  
&& targetfile=$(ls target/*.jar | head -1) \  
&& cp $targetfile /digitalcitizen.jar \  
&& rm -r $MAVEN_HOME /root/.npm  
  
EXPOSE 8090  
CMD ["java", "-jar", "/digitalcitizen.jar"]  
  

