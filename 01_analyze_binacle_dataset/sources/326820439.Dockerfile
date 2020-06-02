FROM java
ADD /spring-boot-docker-fsatdfs-0.0.1-SNAPSHOT.jar //
ENTRYPOINT ["java", "-jar", "/spring-boot-docker-fsatdfs-0.0.1-SNAPSHOT.jar"]
