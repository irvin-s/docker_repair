FROM maven:3-jdk-8  
ADD . $MAVEN_HOME  
  
RUN cd $MAVEN_HOME \  
&& mvn clean package \  
&& mv $MAVEN_HOME/target /oidc-proxy \  
&& rm -r $MAVEN_HOME  
  
EXPOSE 8080  
ENTRYPOINT ["sh", "/oidc-proxy/bin/run.sh"]

