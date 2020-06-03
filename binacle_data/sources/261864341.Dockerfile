FROM java:latest
RUN mkdir -p /opt/application/${project}
COPY ./target/classes /opt/application/${project}/classes
COPY ./target/dependency /opt/application/${project}/dependencies
WORKDIR /opt/application/${project}
EXPOSE 8080:8080 5005:5005
VOLUME /tmp
ENV JAVA_OPTS="-server -Xms1024M -Xmx1024M -Xss512k -XX:PermSize=256M"
ENTRYPOINT ["java","-cp","/opt/application/${project}/classes:/opt/application/${project}/dependencies/*","${application}"]