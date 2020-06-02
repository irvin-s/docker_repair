FROM java:latest
RUN mkdir -p /opt/application/${project}
COPY ./target/application.jar /opt/application/${project}/application.jar
WORKDIR /opt/application/${project}
EXPOSE 8080:8080 5005:5005
VOLUME /tmp
ENV JAVA_OPTS="-server -Xms1024M -Xmx1024M -Xss512k -XX:PermSize=256M"
ENTRYPOINT ["java","-jar","/opt/application/${project}/application.jar"]