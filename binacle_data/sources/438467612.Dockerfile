FROM java:8
VOLUME /tmp
ADD simpleweb-springboot-0.1.0.jar simpleweb-springboot.jar
RUN bash -c 'touch /simpleweb-springboot.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/simpleweb-springboot.jar"]