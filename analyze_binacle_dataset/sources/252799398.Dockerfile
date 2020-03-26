FROM frolvlad/alpine-oraclejdk8:slim  
  
COPY /target/animitar.jar /animitar.jar  
  
ENTRYPOINT [ "sh", "-c", "java -jar /animitar.jar" ]

