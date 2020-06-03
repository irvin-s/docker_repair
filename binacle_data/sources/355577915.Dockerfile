FROM tomcat:8
LABEL author="tangfeixiong <tangfx128@gmail.com>" \
  description="Inspired of Netflix Open Source Development (https://github.com/Netflix-Skunkworks/zerotodocker)"

ARG eureka-server-pkg=/github.com/Netflix/eureka/eureka-server/build/libs/eureka-server-1.6.3-SNAPSHOT.war
# COPY /Netflix/eureka/eureka-server/build/libs/eureka-server-1.6.3-SNAPSHOT.war /
COPY /libs/eureka-server-1.6.3-SNAPSHOT.war /

RUN cd /usr/local/tomcat/webapps &&\
  # mkdir eureka &&\
  # cd eureka &&\
  # wget -q http://repo1.maven.org/maven2/com/netflix/eureka/eureka-server/1.3.1/eureka-server-1.3.1.war &&\
  # jar xf eureka-server-1.3.1.war &&\
  # rm eureka-server-1.3.1.war \
  # 
  unzip -q -d /usr/local/tomcat/webapps/eureka /eureka-server-1.6.3-SNAPSHOT.war \
  && rm /eureka-server-1.6.3-SNAPSHOT.war \
  && echo -e "archaius.deployment.applicationId=eureka\narchaius.deployment.environment=test" > /usr/local/tomcat/webapps/eureka/WEB-INF/classes/config.properties \
  && echo -e "eureka.enableSelfPreservation=false\neureka.registration.enabled=false\neureka.numberRegistrySyncRetries=0\neureka.waitTimeInMsWhenSyncEmpty=0" > /usr/local/tomcat/webapps/eureka/WEB-INF/classes/eureka-server-test.properties \
  && echo -e "eureka.serviceUrl.default=http://localhost:8080/eureka/v2/\neureka.vipAddress=eureka" > /usr/local/tomcat/webapps/eureka/WEB-INF/classes/eureka-client-test.properties \
  && echo $CATALINA_OPTS

# ADD config.properties /tomcat/webapps/eureka/WEB-INF/classes/config.properties
# ADD eureka-client-test.properties /tomcat/webapps/eureka/WEB-INF/classes/eureka-client-test.properties
# ADD eureka-server-test.properties /tomcat/webapps/eureka/WEB-INF/classes/eureka-server-test.properties
  
EXPOSE 8080

ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh"]

CMD ["run"]