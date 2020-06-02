FROM anapsix/alpine-java:8
 
COPY releases/eph-1.0-SNAPSHOT-jar-with-dependencies.jar  /home/eph-1.0-SNAPSHOT.jar
CMD ["java","-jar","/home/eph-1.0-SNAPSHOT.jar"]
