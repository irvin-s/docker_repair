FROM java:8
VOLUME /tmp
ADD boot-mon-server-1-SNAPSHOT.jar boot-mon-server.jar
RUN bash -c 'touch /boot-mon-server.jar'
EXPOSE 8080
ENTRYPOINT ["java","-jar","/boot-mon-server.jar"]
