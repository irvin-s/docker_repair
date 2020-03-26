# Pull base image
FROM java:8-jre

MAINTAINER Zongzhi Bai <dolphineor@gmail.com>

# Add executable jar file to target directory
ADD spring-boot-examples.jar /opt/docker/

WORKDIR /opt/docker/

CMD ["java", "-server", "-Xms1g", "-Xmx1g", "-Dfile.encoding=UTF-8", "-jar", "spring-boot-examples.jar"]