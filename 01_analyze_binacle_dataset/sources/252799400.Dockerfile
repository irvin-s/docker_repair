FROM frolvlad/alpine-oraclejdk8:slim  
  
COPY /target/jackmodera.jar /jackmodera.jar  
  
ENTRYPOINT [ "sh", "-c", "java -jar /jackmodera.jar" ]

