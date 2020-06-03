FROM jeanblanchard/java:jdk-8u77

RUN mkdir /jar-file
COPY . /jar-file
RUN cd /jar-file

CMD ["java", "-jar", "/jar-file/json_subselect.jar"]
