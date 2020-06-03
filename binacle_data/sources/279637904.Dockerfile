FROM anapsix/alpine-java:8

COPY releases/ehsender-1.0-SNAPSHOT-jar-with-dependencies.jar  /home/ehsender-1.0-SNAPSHOT.jar
CMD ["java","-jar","/home/ehsender-1.0-SNAPSHOT.jar"]
