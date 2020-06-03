FROM maven:3-jdk-8  
ADD . $MAVEN_HOME  
  
RUN cd $MAVEN_HOME \  
&& mvn -B clean package \  
&& cp $MAVEN_HOME/skos-builder/target/skos-builder.jar /skos-builder.jar \  
&& rm -r $MAVEN_HOME  
  
VOLUME /workspace  
ENTRYPOINT ["java", "-jar", "/skos-builder.jar", "-w", "/workspace"]  

