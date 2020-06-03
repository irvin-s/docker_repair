FROM java:8

ADD /target/tasklist-service-1.0-SNAPSHOT.jar tasklist-service-1.0-SNAPSHOT.jar

ADD tasklist-service.yml tasklist-service.yml

CMD java -jar tasklist-service-1.0-SNAPSHOT.jar server tasklist-service.yml

EXPOSE 8080

EXPOSE 8081