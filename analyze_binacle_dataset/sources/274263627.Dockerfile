FROM java:8-jre-alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/' /etc/apk/repositories
VOLUME /tmp
ADD target/*.jar app.jar
RUN sh -c 'touch /app.jar'
RUN echo $(date) > /image_built_at
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar","--spring.profiles.active=${SPRING_PROFILES_ACTIVE}"]
