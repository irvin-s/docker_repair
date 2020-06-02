FROM frolvlad/alpine-oraclejdk8:slim  
  
COPY /target/cassidyphotography.jar /cassidyphotography.jar  
  
ENTRYPOINT [ "sh", "-c", "java -jar /cassidyphotography.jar" ]

