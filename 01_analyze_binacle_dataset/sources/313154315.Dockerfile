FROM maxleiko/armhf-alpine-java

RUN mkdir /jar-file
COPY . /jar-file
RUN cd /jar-file

CMD ["java", "-jar", "/jar-file/json_subselect.jar"]

